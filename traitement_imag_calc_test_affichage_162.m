function traitement_imag_calc_test_affichage_162()
% 12/11/2020 : base V2 mais on retire le traitement auto pour proposer un
% outil tout manuel, avec possibilité d'import/exposxt des listes de Cell
% 17/11/2020 : base V3 mais correction de bug sur inmportation, et
% changement des cCellx vers cercles, ajout d'un signalement que l'export
% s'est bien passé, modification de l'export pour un Cell
% 20/11/2020 : modification de la zone de calcul de l'export (5=>7),
% imposer un format carré aux images, possibilité d'ajouter plusieurs Cell à
% la suite, modifier les ID des Cell, possibilité de voir l'image
% originelle
% 23/11/2020 : changement du mode d'ajout des Cell,
% possibilité de déplacer les Cell
% 24/11/2020 : changement d'organisation des fenetres, ajout d'une fonction
% magnet, changement du scaling F des images, changement du curseur de
% visée, option sur la taille des Cell, option de déplacement de tous les
% Cell avec le clavier, ajout d'une option de colormap, correction d'un bug
% sur le déplacement, ajout d'un réglage du contraste, inclusion de la sous
% fonction normalise_image
% 02/12/2020 : déplacer les Cell se fait maintenant pour les Cell
% sélectionnées, et correctiond'un bug dans move_all, ajout d'une image max
% en plus de STD
% v9 : 4/12/2020 : ajout de super Area dessinées à la main, ajout de
% l'export en image avec options
% v10 : 4/01/2021 : modification du comportement des sliders, et
% corresction bug super area
% 22/01/2021 : correction d'un bug sur l'exportation, ajout d'un feature
% qui affiche les cellules responder, misse en pause des modifs sur les
% sliders et les zones
% V11 : 03/02/2021 : correcition d'un bug dans le calcul des seul de
% reponder, qui était de 3x3, correction d'un bug dans l'affichage des
%  responder si vide, exportation de l'état de responder, et forçage
% de l'état de responder, ajcleaout d'un radiobutton pour la mise à l'échelle
% V12 : 17/02/2021 : le check responder est fait au click, et modification
% du plot, en fait non ça marche pas dechanger le plot
% 24/02/2021 : on retire le plot des V vert et X noir pdt le check
% reponsder, on se contente de changer l'état, ajout d'un slider pour le
% control total du contrast
% V13 : 26/02/2021 : on change le parsing si le nombre de frame et de stack
% n'est pas exprimé pareil, on ajoute la possibilité de travailler sur un
% tiff
% V13.1 : correction de bugs dus au changement de contraste
% V13.2 : on remet les zones, on ne recalcule plus les responder si déjà
% présent lors de l'importation
% 02/04/2021 : V13.3 : correction bug importation et exportation données
% 08/04/2021 : correction nouveau bug importation et exportation données
% 09/04/2021 : V13.4 : les touches G/D pilotent maintenant les frames, et
% on démarre par défaut en RAW/gris
% 12/04/2021 : V13.5 : changement du callback des sliders pour ne refresh
% que si la valeur change effectivement (mode discret)
% 19/04/2021 : V13.6 : ajout d'une option pour l'export, on peut choisir le
% raw de chez raw (data 16bits), plus ajout d'un calcul glissant en plus du std
% 04/05/2021 : V13.8 (à fusionner avec 13.7 pour limite roi) : correction
% d'un bug d'import de zone et duplication de zones, ajout d'un bouton pour
% masquer les zones
% 06/05/2021 : V13.9 ajout d'un bouton de scaling pour l'affichage
% temporel, afin de garder un zoom occasionnel
% 02/06/2021 : V14.0 ajout du réglage de contraste sur l'image STD, et tentative
% de compensation mouvement
% 09/06/2021 : V14.1 patch d'uen erreur dans importation d'un vieux fichier et
% sur l'affichage des listes, et ajout d'un bouton pour faire une mesure
% sur les images
% 16/06/2021 : V14.2 : ajout d'une option dans la fonction d'import pour
% sélection les cellule et/ou les area, ajout de la détection automatique
% ces cellules, et du calcul de la taille des cellules
% 27/08/2021 : V14.3 ajout d'un réglagle pour la péride de référence de
% calcul de la baseline et de la période d'activité, et d'un réglage du
% nombre d'ecarttype pour le calcul du seuil, ces réglages se font
% finalement avec un input text au lieu slider, et ajour d'un clic milieu
% pour changer l'état responder
% 18/02/2022 : V 14.4 onprend maintenant tous les formats d'image, et plus
% seulement des 512 x 512
% 23/02/2022 : V 14.5 on ajoute un deuxième critère de respondeur, et la
% possibilité de retirer l'image médiane de l'image temporelle, on retire
% aussi la normalisation des images pour travailler sur la colormap
% 01/03/2022 : V 14.6, on remet la gestion des saturations
% 04/03/2022 : V15.0 ; correction d'un bug important lors de
% l'ouverture de plusieurs GUI (lié à gcf)
% 11/03/2022 : V15.1 on peut exporter en TIFF bioformat
% 25/03/2022 : V15.2, les paramètres de filtre gaussien et médian sont
% maintenant demandés au lancement de l'application
% 25/05/2022 : l'affichage temps réelle de la ligne temporelle est
% maintenant calculée à partir de la médiane
% 14/06/2022 : V15.4, on ajoute des options dans la correction de drift,
% avec la rotation et la déformation
% 15-06/2022 : V15.5,la compensation se fait maintenant sur la projection
% en Z, ajout de métadonnées dans le fichier export, et un onglet avec les
% calcul DF/F, création d'une figure avec tous les transients, on change
% l'importation en utilisant readcell
% 21/06/2022 : V15.6 : correction de bug, ajout de l'export en STD
% 25/10/2022 : V15.7 : modification de la numerotatin en cas d'effacement
% de cellule, on ne renumerote pas, ajout d'un bouton renumerotation,
% correction d'un bug dans move selec
% 19/01/2023 : V16.0 : on ajoute la possibilité de charger plusieurs images
% 09/02/2023 : axis equal au lieu de square pour les images très
% rectangulaires, et modification de l'export de transients
% 23/02/2023 : V 16.2 : ajout d'une option supplémentaire pour l'export
% image
[fich0,rep] = uigetfile({'*.czi';'*.tiff;*.tif'},'Multiselect','on');
if ischar(fich0)
    fich0 = {fich0};
end
if fich0{1} ~= 0
    ok_filtre = 0;
    while ~ok_filtre
        [mouvement_ok,rotation_ok,shear_ok,sigma_g,taille_m] = gui_pop_filtre();
        ok_filtre = isodd(taille_m) && sigma_g>0;
    end
    for k_fich = 1:length(fich0)
        fich =  fich0{k_fich};
        metadata = [];
        metadata.version = 156;
        cd(rep);
        fich = [rep,'\',fich];
        r = bfopen(fich);
        metadonnees = r{2}.toString;
        A = metadonnees.toCharArray';
        n = strfind(A,'ScalingX');
        chaine = A(n+12:n+80);
        scaling = str2double(chaine(1:strfind(chaine,',')-1));
        % ranger les data de r dans les bons plans et calculs des constantes
        detail_aqui = r{1}{1,2};
        char_comma = findstr(detail_aqui , ';');
        switch length(char_comma)
            case 3
                % cas normal, on a des Z et des T
                char_Z = findstr(detail_aqui , '; Z=');
                char_T = findstr(detail_aqui , '; T=');
                nb_Z = str2double(detail_aqui(char_Z+6:char_comma(end)-1));
                nb_T = str2double(detail_aqui(char_T+6:end));
                if isempty(char_Z) ||  isempty(char_T)
                    char_Z = findstr(detail_aqui , '; Z?=');
                    char_T = findstr(detail_aqui , '; T?=');
                    nb_Z = str2double(detail_aqui(char_Z+7:char_comma(end)-1));
                    nb_T = str2double(detail_aqui(char_T+7:end));
                end
            case 2
                % cas anormal, on a QUE des Z ou QUE des T, mais cela veut dire
                % qu'on a que des T, donc on cherche les plane
                nb_Z = 1;
                char_plane = findstr(detail_aqui , 'plane');
                nb_T = str2double(detail_aqui(char_plane+8:char_comma(2)-1));
        end
        % parcourt des plans en Z
        [H,L] = size(r{1}{1});
        metadata.nb_Z = nb_Z;
        metadata.nb_T = nb_T;
        metadata.H = H;
        metadata.L = L;
        disp(['Image de largeur ',num2str(L),', et de hauteur ',num2str(H),' pixels'])
        disp([num2str(nb_T),' frames trouvées'])
        disp([num2str(nb_Z),' plans trouvées'])
        metadata.mouvement_ok = mouvement_ok;
        metadata.rotation_ok = rotation_ok;
        metadata.shear_ok = shear_ok;
        metadata.sigma_g = sigma_g;
        metadata.taille_m = taille_m;
        % compensation du mouvement
        disp('Calcul compensation drift...')
        if mouvement_ok || rotation_ok || shear_ok
            if mouvement_ok && rotation_ok && shear_ok
                transfo = 'affine';
            elseif mouvement_ok && rotation_ok
                transfo ='rigid' ;
            elseif mouvement_ok
                transfo ='translation' ;
            end
            [optimizer, metric] = imregconfig('monomodal');
            im_raw0_compensation = zeros(nb_Z,H,L,nb_T);
            for k_Z = 1:nb_Z
                for k_T = 1:nb_T
                    im_raw0_compensation(k_Z,:,:,k_T) = r{1}{(k_T-1)*nb_Z+k_Z,1};
                end
            end
            im_raw0_compensation = squeeze(mean(im_raw0_compensation,1));
            %final_warp = zeros(2,nb_T);
            for k_T = 1:nb_T
                tform(k_T) = imregtform(medfilt2(im_raw0_compensation(:,:,k_T),[5 5]),...
                    medfilt2(im_raw0_compensation(:,:,1),[5 5]), transfo, optimizer, metric);
                %  [~, final_warp(:,k_T), ~]=ecc(im_raw0_compensation(:,:,k_T), im_raw0_compensation(:,:,1), 4, [10,2], transfo, [1;1]);
            end
            metadata.transfo = transfo;
        end
        
        
        for k_Z = 1:nb_Z
            disp(['Traitement de la coupe n° ',num2str(k_Z),' sur ',num2str(nb_Z)])
            % récupération des plans temporels
            im_raw0 = zeros(H,L,nb_T);
            for k_T = 1:nb_T
                im_raw0(:,:,k_T) = r{1}{(k_T-1)*nb_Z+k_Z,1};
                if mouvement_ok || rotation_ok || shear_ok
                    sameAsInput = affineOutputView(size(im_raw0(:,:,1)),tform(k_T),'BoundsStyle','SameAsInput');
                    im_raw0(:,:,k_T) = imwarp(im_raw0(:,:,k_T),tform(k_T),'OutputView',sameAsInput);
                    % im_raw0(:,:,k_T) = spatial_interp(im_raw0(:,:,k_T), final_warp(:,k_T), transfo, [1:H], [1:L]);
                end
            end
            
            % flou gaussien ou médian pour l'image de gauche, et image sans
            % fond
            im_raw0 = single(im_raw0);
            im_raw_smooth = imgaussfilt3(im_raw0, [sigma_g,sigma_g,0.5]);
            im_raw_med = medfilt3(im_raw0,[taille_m,taille_m,1]);
            im_raw = im_raw0;
            im_raw_ss_fond = im_raw - repmat(median(im_raw,3),1,1,nb_T);
            im_raw_smooth_ss_fond = im_raw_smooth - repmat(median(im_raw_smooth,3),1,1,nb_T);
            im_raw_med_ss_fond = im_raw_med - repmat(median(im_raw_med,3),1,1,nb_T);
            % calcul des images de droite
            im_std_gaussian  = std(im_raw_smooth,1,3);
            im_std_median  = std(im_raw_med,1,3);
            im_std_raw  = std(im_raw,1,3);
            im_max_gaussian  = max(im_raw_smooth,[],3);
            im_max_median  = max(im_raw_med,[],3);
            im_max_raw  = max(im_raw,[],3);
            im_gliss_raw = critere_grissant(im_raw);
            im_gliss_gaussian = critere_grissant(im_raw_smooth);
            im_gliss_median = critere_grissant(im_raw_med);
            data_gui.metadata = r{4};
            data_gui.im_raw0{k_Z} = im_raw0;
            data_gui.im_raw_smooth{k_Z} = im_raw_smooth;
            data_gui.im_raw{k_Z} = im_raw;
            data_gui.im_raw_ss_fond{k_Z} = im_raw_ss_fond;
            data_gui.im_raw_smooth_ss_fond{k_Z} = im_raw_smooth_ss_fond;
            data_gui.im_raw_med_ss_fond{k_Z} = im_raw_med_ss_fond;
            data_gui.im_raw_med{k_Z} = im_raw_med;
            data_gui.im_std_gaussian{k_Z} = im_std_gaussian;
            data_gui.im_std_median{k_Z} = im_std_median;
            data_gui.im_std_raw{k_Z} = im_std_raw;
            data_gui.im_max_gaussian{k_Z} = im_max_gaussian;
            data_gui.im_max_median{k_Z} = im_max_median;
            data_gui.im_max_raw{k_Z} = im_max_raw;
            data_gui.im_gliss_raw{k_Z} = im_gliss_raw;
            data_gui.im_gliss_gaussian{k_Z} = im_gliss_gaussian;
            data_gui.im_gliss_median{k_Z} = im_gliss_median;
            data_gui.rep = rep;
            data_gui.scaling = scaling;
            data_gui.Z{k_Z} = k_Z;
            data_gui.nb_Z = nb_Z;
            data_gui.Z_loc = 1;
            data_gui.t_loc = 1;
            data_gui.min{k_Z} = [min(im_raw_smooth(:)),min(im_raw_smooth_ss_fond(:));...
                min(im_raw_med(:)),min(im_raw_med_ss_fond(:));...
                min(im_raw(:)),min(im_raw_ss_fond(:))];
            data_gui.max{k_Z} = [max(im_raw_smooth(:)),max(im_raw_smooth_ss_fond(:));...
                max(im_raw_med(:)),max(im_raw_med_ss_fond(:));...
                max(im_raw(:)),max(im_raw_ss_fond(:))];
            data_gui.nb_T = nb_T;
            data_gui.fich = fich;
            data_gui.h_plot_check = [];
            data_gui.h_ligne_seuil = [];
            data_gui.H = H;
            data_gui.L = L;
            data_gui.type_image = {'im_raw_smooth','im_raw_smooth_ss_fond';...
                'im_raw_med','im_raw_med_ss_fond';...
                'im_raw','im_raw_ss_fond'};
        end
        curseur = generate_curseur;
        % création de la figure
        h_fig = figure('WindowButtonMotionFcn', @mouseMove,'units','normalized',...
            'WindowButtonDownFcn',@mouseClick,'GraphicsSmoothing','off',...
            'WindowKeyPressFcn',@keypressed,'WindowStyle','normal','name',...
            ['Outil d''analyse d''imagerie Calcique, ',...
            'Ver 1.6.2, (c) François Gabrielli, Neuro-Dol UCA INSERM UMR 1107']);%,...
        %     'MenuBar','none','ToolBar','none');
        % création des axes de la figure temporelle
        ax_im_t = axes('Position',[0.01 0.2 0.4 0.75]);
        image(ax_im_t,squeeze(data_gui.im_raw{1}(:,:,1)))
        set(ax_im_t,'Tag','axe_image_t')
%         axis square
        axis equal
        axis off
        colormap(gray(65535))
        data_gui.h_image_t = ax_im_t;
        % création de la figure écart-type
        ax_std = axes('Position',[0.4 0.2 0.4 0.75]);
        image(ax_std,data_gui.im_std_gaussian{1})
%         axis square
        axis equal
        axis off
        colormap(gray(max(data_gui.im_std_gaussian{1},[],'all')))
        set(ax_std,'Tag','axe_image_std')
        title('standard deviation over time')
        data_gui.h_std = ax_std;
        % affichage des info
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.12 0.97 0.70 0.03],'String',fich,'Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.01,0.15,0.07,0.02],'String','Z plane','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.01,0.11,0.07,0.02],'String','Frame','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.01,0.07,0.07,0.02],'String','Max','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.01,0.03,0.07,0.02],'String','Min','Fontsize',12);
        % création des axes pour évolution temporelle du pixel en cours
        ax_pix = axes('Position',[0.35 0.02 0.15 0.15]);
        plot(ax_pix,squeeze(mean(mean(data_gui.im_raw_smooth{1},1),2)));
        data_gui.h_pix_tempo = ax_pix;
        h_Z_slider = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','Z_slider',...
            'Position',[0.09 0.15 0.20 0.0250],'value',0.001, 'min',0.001, 'max',data_gui.nb_Z,...
            'SliderStep',[1 1]/data_gui.nb_Z);
        h_t_slider = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','frame_slider',...
            'Position',[0.09 0.11 0.20 0.0250],'value',0.001, 'min',0.001, 'max',data_gui.nb_T,...
            'SliderStep',[1 1]/data_gui.nb_T);
        h_max_slider_t = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','max_slider_t',...
            'Position',[0.09 0.07 0.10 0.0250],'value',1, 'min',0, 'max',1,...
            'SliderStep',[1/50 1/20]);
        h_min_slider_t = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','min_slider_t',...
            'Position',[0.09 0.03 0.10 0.0250],'value',0, 'min',0, 'max',1,...
            'SliderStep',[1/50 1/20]);
        h_max_slider_std = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','max_slider_std',...
            'Position',[0.21 0.07 0.10 0.0250],'value',1, 'min',0, 'max',1,...
            'SliderStep',[1/50 1/20]);
        h_min_slider_std = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','min_slider_std',...
            'Position',[0.21 0.03 0.10 0.0250],'value',0, 'min',0, 'max',1,...
            'SliderStep',[1/50 1/20]);
        
        h_measure = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','mesurer',...
            'Position',[0.82,0.88,0.045,0.03],'String','Measurement');
        
        h_colormap_toggle = uicontrol('Parent',h_fig,'Style','listbox','Units','Normalized','Tag','colormap_toggle',...
            'Position',[0.82,0.8,0.05,0.05],'value',3,'String',{'parula','jet','gray'});
        h_smooth_toggle = uicontrol('Parent',h_fig,'Style','listbox','Units','Normalized','Tag','smooth_toggle',...
            'Position',[0.80,0.7,0.05,0.05],'value',3,'String',{'Gaussian','Median','Raw'});
        h_std_max_toggle = uicontrol('Parent',h_fig,'Style','listbox','Units','Normalized','Tag','std_max_toggle',...
            'Position',[0.86,0.7,0.05,0.05],'value',1,'String',{'STD','Max','Glissant'});
        h_magnet = uicontrol('Parent',h_fig,'Style','radiobutton','Units','Normalized','Tag','magnet',...
            'Position',[0.81,0.65,0.05,0.03],'String','Magnet','Value',0);
        h_fond = uicontrol('Parent',h_fig,'Style','radiobutton','Units','Normalized','Tag','Fond',...
            'Position',[0.81,0.61,0.05,0.03],'String','Fond','Value',1);
        h_scale_Y = uicontrol('Parent',h_fig,'Style','radiobutton','Units','Normalized','Tag','scale_Y',...
            'Position',[0.86,0.65,0.05,0.03],'String','Scale Y','Value',0);
        h_scale_X = uicontrol('Parent',h_fig,'Style','radiobutton','Units','Normalized','Tag','scale_X',...
            'Position',[0.86,0.61,0.05,0.03],'String','Scale X','Value',0);
        
        %%%% Boutons de gestion des cellules
        h_ajouter = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','ajouter',...
            'Position',[0.80,0.55,0.045,0.03],'String','Add Cell');
        h_supprimer = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','supprimer',...
            'Position',[0.80,0.50,0.045,0.03],'String','Delete Cell');
        h_move = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','move',...
            'Position',[0.80,0.45,0.05,0.03],'String','Move ONE','Value',0);
        h_move_all = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','move_all',...
            'Position',[0.80,0.40,0.05,0.03],'String','Move ALL','Value',0);
        h_move_sel = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','move_sel',...
            'Position',[0.80,0.35,0.05,0.03],'String','Move SELECT','Value',0);
        h_check = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','check',...
            'Position',[0.80,0.30,0.05,0.03],'String','Check','Value',0);
        %%% Boutons de gestions des zones anatomiques
        h_ajouter_zone = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','ajouter_zone',...
            'Position',[0.86,0.55,0.045,0.03],'String','Add Area');
        h_supprimer_zone = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','supprimer_zone',...
            'Position',[0.86,0.50,0.045,0.03],'String','Delete Area');
        h_modifier_zone = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','modifier_zone',...
            'Position',[0.86,0.45,0.045,0.03],'String','Modifie Area');
        h_copy_zone = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','modifier_zone',...
            'Position',[0.86,0.40,0.045,0.03],'String','Copy Area');
        h_assign_cell = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','modifier_zone',...
            'Position',[0.86,0.35,0.045,0.03],'String','Assign Cells');
        h_hide_zone = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','modifier_zone',...
            'Position',[0.86,0.30,0.045,0.03],'String','hide areas');
        
        h_renumerote = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','renumerote',...
            'Position',[0.83,0.25,0.045,0.03],'String','Renumeroter');
        %%% bouton d'import export des fichiers et images
        h_export_trans = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','exporter',...
            'Position',[0.86,0.025,0.05,0.04],'String','Export transients');
        h_export_im = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','exporter_image',...
            'Position',[0.80,0.025,0.05,0.04],'String','Export Image');
        h_export = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','exporter',...
            'Position',[0.74,0.025,0.05,0.04],'String','Export file');
        h_import = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','importer',...
            'Position',[0.74,0.1,0.05,0.04],'String','Import file');
        h_raw = uicontrol('Parent',h_fig,'Style','radiobutton','Units','Normalized','Tag','magnet',...
            'Position',[0.74,0.15,0.05,0.04],'String','Export raw','Value',1);
        
        %%% boutons de traitement automatisé
        h_detect_cell = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','detect_cell',...
            'Position',[0.80,0.2,0.05,0.04],'String','Detect Cells');
        h_cells_surface = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','cells_surface',...
            'Position',[0.86,0.2,0.05,0.04],'String','Cells surface');
        h_toggle_cells_surface = uicontrol('Parent',h_fig,'Style','togglebutton','Units','Normalized','Tag','toggle_cells_surface',...
            'Position',[0.86,0.15,0.05,0.04],'String','Show Cells surface');
        h_slider_seuil = uicontrol('Parent',h_fig,'Style','slider','Units','Normalized','Tag','slider_detect',...
            'Position',[0.80 0.15 0.05 0.04],'value',15, 'min',0, 'max',50,...
            'SliderStep',[1/50 1/10]);
        h_text_seuil = uicontrol('Parent',h_fig,'Style','text','Units','Normalized','Tag','text_seuil',...
            'Position',[0.80 0.10 0.05 0.04],'String','15');
        h_valid_cell = uicontrol('Parent',h_fig,'Style','pushbutton','Units','Normalized','Tag','valid_cell',...
            'Position',[0.86,0.08,0.05,0.04],'String','Valid Cells');
        
        %%% boutons de réglage des plages temporelle et delimite du seuil de
        %%% détection automatique
        h_slider_BL_deb = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','slider_BL_deb',...
            'Position',[0.52 0.084 0.025 0.0250],'String','1');
        h_slider_BL_fin = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','slider_BL_fin',...
            'Position',[0.57 0.084 0.025 0.0250],'String','5');
        h_slider_stim_deb = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','slider_stim_deb',...
            'Position',[0.63 0.084 0.025 0.0250],'String','6');
        h_slider_stim_fin = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','slider_stim_fin',...
            'Position',[0.69 0.084 0.025 0.0250],'String','10');
        h_slider_multi_std = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','slider_multi_std',...
            'Position',[0.57 0.022 0.025 0.0250],'String','3');
        h_offset_seuil2 = uicontrol('Parent',h_fig,'Style','edit','Units','Normalized','Tag','edit_offset_seuil2',...
            'Position',[0.69 0.022 0.025 0.0250],'String','20');
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.520 0.022 0.05 0.025],'String','nb STD','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.630 0.022 0.05 0.025],'String','Offset(%)','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.520 0.16 0.065 0.025],'String','BaseLine (BL)','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.520 0.12 0.018 0.025],'String','from','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.570 0.12 0.018 0.025],'String','to','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.630 0.16 0.065 0.025],'String','Stimulation','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.630 0.12 0.018 0.025],'String','from','Fontsize',12);
        uicontrol('Parent',h_fig,'Style','text','Units','Normalized',...
            'Position',[0.690 0.12 0.018 0.025],'String','to','Fontsize',12);
        addlistener(h_renumerote, 'Value', 'PostSet',@renumeroter);
        addlistener(h_Z_slider, 'Value', 'PostSet',@refresh);
        addlistener(h_t_slider, 'Value', 'PostSet',@refresh);
        addlistener(h_smooth_toggle, 'Value', 'PostSet',@refresh);
        addlistener(h_std_max_toggle, 'Value', 'PostSet',@refresh);
        addlistener(h_ajouter, 'Value', 'PostSet',@add_Cell);
        addlistener(h_supprimer, 'Value', 'PostSet',@delete_Cell);
        addlistener(h_import, 'Value', 'PostSet',@import_Cell);
        addlistener(h_export, 'Value', 'PostSet',@export_Cell);
        addlistener(h_export_trans, 'Value', 'PostSet',@export_Transients);
        addlistener(h_move, 'Value', 'PostSet',@move_Cell);
        addlistener(h_move_all, 'Value', 'PostSet',@move_Cell_all);
        addlistener(h_move_sel, 'Value', 'PostSet',@move_Cell_sel);
        addlistener(h_magnet, 'Value', 'PostSet',@select_magnet);
        addlistener(h_fond, 'Value', 'PostSet',@select_fond);
        addlistener(h_colormap_toggle, 'Value', 'PostSet',@change_colormap);
        addlistener(h_max_slider_t, 'Value', 'PostSet',@refresh);
        addlistener(h_min_slider_t, 'Value', 'PostSet',@refresh);
        addlistener(h_max_slider_std, 'Value', 'PostSet',@refresh);
        addlistener(h_min_slider_std, 'Value', 'PostSet',@refresh);
        addlistener(h_export_im, 'Value', 'PostSet',@export_image);
        addlistener(h_check, 'Value', 'PostSet',@check_responder);
        addlistener(h_ajouter_zone, 'Value', 'PostSet',@ajoute_zone);
        addlistener(h_supprimer_zone, 'Value', 'PostSet',@supprime_zone);
        addlistener(h_modifier_zone, 'Value', 'PostSet',@modifie_zone);
        addlistener(h_copy_zone, 'Value', 'PostSet',@copy_zone);
        addlistener(h_assign_cell, 'Value', 'PostSet',@assign_cell);
        addlistener(h_hide_zone, 'Value', 'PostSet',@hide_zone);
        addlistener(h_measure, 'Value', 'PostSet',@draw_measure);
        addlistener(h_valid_cell, 'Value', 'PostSet',@valid_cells);
        addlistener(h_detect_cell, 'Value', 'PostSet',@detect_cells);
        addlistener(h_cells_surface, 'Value', 'PostSet',@calcul_cells_surface);
        addlistener(h_toggle_cells_surface, 'Value', 'PostSet',@toggle_cells_surface);
        addlistener(h_slider_seuil, 'Value', 'PostSet',@update_seuil_detect);
        addlistener(h_slider_multi_std,'String',  'PostSet',@update_multi_std);
        addlistener(h_slider_BL_deb,'String',  'PostSet',@update_patch);
        addlistener(h_slider_BL_fin,'String',  'PostSet',@update_patch);
        addlistener(h_slider_stim_deb,'String',  'PostSet',@update_patch);
        addlistener(h_slider_stim_fin,'String',  'PostSet',@update_patch);
        
        h_liste_Cell = uicontrol('Parent',h_fig,'Style',...
            'listbox','Units','Normalized','Tag','liste_Cell',...
            'String', {},'min',1,'max',1,...
            'Position',[0.92 0.05 0.06 0.9]);
        addlistener(h_liste_Cell, 'Value', 'PostSet',@liste_click);
        liste_Cell = cell(nb_Z,1);
        data_gui.metadata = metadata;
        data_gui.nb_zone = zeros(nb_Z,1);
        data_gui.liste_zone = cell(nb_Z,1);
        data_gui.h_slider_seuil = h_slider_seuil;
        data_gui.h_offset_seuil2 = h_offset_seuil2;
        data_gui.h_text_seuil = h_text_seuil;
        data_gui.seuil_detect = 5;
        data_gui.h_detect_cell = h_detect_cell;
        data_gui.h_valid_cell = h_valid_cell;
        data_gui.h_renumerote = h_renumerote;
        data_gui.fich = fich;
        data_gui.h_cells_surface = h_cells_surface;
        data_gui.h_toggle_cells_surface = h_toggle_cells_surface;
        data_gui.h_liste_Cell = h_liste_Cell;
        data_gui.h_measure = h_measure;
        data_gui.liste_Cell = liste_Cell;
        data_gui.h_Z_slider = h_Z_slider;
        data_gui.h_t_slider = h_t_slider;
        data_gui.h_smooth_toggle = h_smooth_toggle;
        data_gui.h_std_max_toggle = h_std_max_toggle;
        data_gui.h_ajouter = h_ajouter;
        data_gui.h_supprimer = h_supprimer;
        data_gui.h_export = h_export;
        data_gui.h_export_trans = h_export_trans;
        data_gui.h_raw = h_raw;
        data_gui.h_export_im = h_export_im;
        data_gui.h_import = h_import;
        data_gui.h_ajouter_zone = h_ajouter_zone;
        data_gui.h_supprimer_zone = h_supprimer_zone;
        data_gui.h_modifier_zone = h_modifier_zone;
        data_gui.h_copy_zone = h_copy_zone;
        data_gui.h_assign_cell = h_assign_cell;
        data_gui.h_hide_zone = h_hide_zone;
        data_gui.h_check = h_check;
        data_gui.h_move = h_move;
        data_gui.h_move_all = h_move_all;
        data_gui.h_move_sel = h_move_sel;
        data_gui.selected_Cell = [];
        data_gui.h_magnet = h_magnet;
        data_gui.h_fond = h_fond;
        data_gui.h_scale_X = h_scale_X;
        data_gui.h_scale_Y = h_scale_Y;
        data_gui.h_colormap_toggle = h_colormap_toggle;
        data_gui.h_max_slider_t = h_max_slider_t;
        data_gui.h_min_slider_t = h_min_slider_t;
        data_gui.h_max_slider_std = h_max_slider_std;
        data_gui.h_min_slider_std = h_min_slider_std;
        data_gui.h_slider_BL_deb = h_slider_BL_deb;
        data_gui.h_slider_BL_fin = h_slider_BL_fin;
        data_gui.h_slider_stim_deb = h_slider_stim_deb;
        data_gui.h_slider_stim_fin = h_slider_stim_fin;
        data_gui.h_slider_multi_std = h_slider_multi_std;
        data_gui.multi_std = 3;
        data_gui.liste_colormap = {'parula','jet','gray'};
        data_gui.h_plot_cell_surface = [];
        data_gui.h_plot_detect_cell = [];
        data_gui.detect_valid = [];
        data_gui.ligne_temporelle = [];
        data_gui.h_patch_BL = [];
        data_gui.h_patch_stim = [];
        data_gui.BL = [1 5];
        data_gui.stim = [6 10];
        data_gui.hook = [0 0];
        data_gui.fond = 1;
        data_gui.curseur = curseur;
        data_gui.h_fig = h_fig;
        guidata(h_fig,data_gui)
        axes(data_gui.h_image_t)
        title(data_gui.h_image_t, ['Z = ',num2str(1),', t = ',num2str(1),' / ',num2str(data_gui.nb_T)]);
    end
end
end

function renumeroter( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
data_cell = cell2mat(data_gui.liste_Cell{Z_}(:,2));
% num_cell_max = max(data_cell(:,1));
NCell = size(data_gui.liste_Cell{Z_},1);
for k_Cell = 1:NCell
    data_gui.liste_Cell{Z_}{k_Cell,1} = ['Z',num2str(Z_),'-',num2str(k_Cell)];
    data_gui.liste_Cell{Z_}{k_Cell,2}(1) = k_Cell;
end
guidata(data_gui.h_fig,data_gui)
refresh_base(data_gui,'renumerote');
end

function valid_cells( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
N_cell_valid = size(data_gui.detect_valid,1);
data_gui.liste_Cell{Z_} = {};
for k_cell_valid = 1:N_cell_valid
    data_gui.liste_Cell{Z_} = [data_gui.liste_Cell{Z_};...
        {['Z',num2str(Z_),'-',num2str(k_cell_valid)],...
        [k_cell_valid,data_gui.detect_valid(k_cell_valid,2),data_gui.detect_valid(k_cell_valid,1),0],[],[]}];
    x = round(data_gui.liste_Cell{Z_}{end,2}(3));
    y = round(data_gui.liste_Cell{Z_}{end,2}(2));
    activite = squeeze(mean(mean(data_gui.im_raw_smooth{Z_}(...
        x-3:x+3,...
        y-3:y+3,:),1),2));
    data_gui.liste_Cell{Z_}{end,3} = is_responder(activite,data_gui.im_raw_smooth{Z_},data_gui.BL,data_gui.stim,data_gui.multi_std);
end
disp(data_gui.liste_Cell{Z_})
refresh_base(data_gui,'ajouter');
data_gui.detect_valid = [];
guidata(data_gui.h_fig,data_gui)
end

function update_patch( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
data_gui.BL = round([str2double(data_gui.h_slider_BL_deb.String) str2double(data_gui.h_slider_BL_fin.String)]);
data_gui.stim = round([str2double(data_gui.h_slider_stim_deb.String) str2double(data_gui.h_slider_stim_fin.String)]);
set(data_gui.h_patch_BL,'Xdata',[data_gui.BL(1) data_gui.BL(2) data_gui.BL(2) data_gui.BL(1) data_gui.BL(1)]);
set(data_gui.h_patch_stim,'Xdata',[data_gui.stim(1) data_gui.stim(2) data_gui.stim(2) data_gui.stim(1) data_gui.stim(1)]);
disp('ok')
guidata(data_gui.h_fig,data_gui)
end

function update_multi_std( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
data_gui.BL = round([str2double(data_gui.h_slider_BL_deb.String) str2double(data_gui.h_slider_BL_fin.String)]);
data_gui.stim = round([str2double(data_gui.h_slider_stim_deb.String) str2double(data_gui.h_slider_stim_fin.String)]);
data_gui.multi_std = round(str2double(data_gui.h_slider_multi_std.String));
%set(data_gui.h_text_multi_std,'String',num2str(multi_std))
seuil = mean(data_gui.line_temporelle(data_gui.BL(1):data_gui.BL(2)))+...
    data_gui.multi_std*std(data_gui.line_temporelle(data_gui.BL(1):data_gui.BL(2)));
set(data_gui.h_ligne_seuil,'Ydata',[seuil seuil])
ly = ylim(data_gui.h_pix_tempo);
if seuil > max(data_gui.line_temporelle)
    ylim(data_gui.h_pix_tempo,[ly(1) seuil]);
end
guidata(data_gui.h_fig,data_gui)
end

function update_seuil_detect( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
seuil_detect = data_gui.h_slider_seuil.Value;
set(data_gui.h_text_seuil,'String',num2str(round(seuil_detect)))
data_gui.seuil_detect = seuil_detect;
guidata(data_gui.h_fig,data_gui)
end

function detect_cells( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
BW = imregionalmax(data_gui.im_std_gaussian{Z_});
plancher = median(data_gui.im_std_gaussian{Z_}(:));
BW(data_gui.im_std_gaussian{Z_}.*BW<plancher+10)=0;
[x,y] = find(BW);
activite = [];
for k = 1:length(x)
    activite(:,k)=mean(data_gui.im_raw_smooth{Z_}(x(k)-4:x(k)+4,y(k)-4:y(k)+4,:),[1 2]);
end
critere = max(activite(6:10,:)) > mean(activite(1:5,:))+ max([data_gui.seuil_detect*ones(1,length(x));3*std(activite(1:5,:))]) ;%& ...
%  mean(activite(6:10,:)) > mean(activite(11:15,:))+max([data_gui.seuil_detect*ones(1,length(x));3*std(activite(11:15,:))]);
cell_valide = find(critere);
a = y(cell_valide);
b = x(cell_valide);
data_gui.detect_valid = [x(cell_valide) y(cell_valide)];
axes(data_gui.h_std)
%imagesc(data_gui.im_std_gaussian{Z_})
%axis square
hold on
if ~isempty(data_gui.h_plot_detect_cell)
    delete(data_gui.h_plot_detect_cell)
end
data_gui.h_plot_detect_cell = plot(data_gui.h_std,a,b,'rx');
guidata(data_gui.h_fig,data_gui)
end

function calcul_cells_surface( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
f0 = waitbar(0,'Calcul en cours...');
Z_ = data_gui.Z_loc;
N_cells = size(data_gui.liste_Cell{Z_},1);
fenetre = 15;
%h_loc = figure('WindowStyle','normal');
for k1 = 1:N_cells
    x = data_gui.liste_Cell{Z_}{k1,2}(3);
    y = data_gui.liste_Cell{Z_}{k1,2}(2);
    activite_max = round(data_gui.im_std_gaussian{Z_}(x,y));
    %     activite_max = round(max(mean(data_gui.im_raw_smooth{Z_}(x-3:x+3,y-3:y+3,:),[1 2])));
    im_loc = data_gui.im_std_gaussian{Z_}(max(1,x-fenetre):min(data_gui.L,x+fenetre),...
        max(1,y-fenetre):min(data_gui.H,y+fenetre));
    taille = zeros(1,activite_max);
    n_cell = zeros(1,activite_max);
    for k = 1:activite_max
        im_trav = imclearborder(imquantize(im_loc,k));
        im_trav = bwareaopen(im_trav, 9);
        L0 = bwselect(im_trav,fenetre,fenetre);
        [L,n] = bwlabel(im_trav);
        n_cell(k) = n;
        taille(k)=sum(L0(:)==1);
    end
    index = find(taille>0);
    taille_pos = taille(index);
    % par défaut, le seuil est l'indice pour lequelle la cellule est la
    % plus grosse
    [~,seuil_max_taille] = max(taille);
    index2 = find(diff(taille_pos)<-10);
    if ~isempty(index2) % au moins un saut de taille >10 pix
        for k_step = 1:length(index2)
            if n_cell(index(index2(k_step))+1) ~= n_cell(index(index2(k_step))) % on a absorbé une cellule, on remplace l'indice
                seuil_max_taille = index(index2(k_step)+1);
            end
        end
    end
    [L0,n0] = bwselect(imclearborder(imquantize(im_loc,seuil_max_taille)),fenetre,fenetre);
    B = bwboundaries(L0);
    if ~isempty(B)
        data_gui.liste_Cell{Z_}{k1,4} = [B{1}(:,2)+y-fenetre-1,B{1}(:,1)+x-fenetre-1];
    else
        disp('surface nulle')
    end
    waitbar(k1 / N_cells,f0,'Calcul en cours...');
    %     axis(data_gui.h_std);
    %     plot(B{1}(:,2)+y-fenetre-1,B{1}(:,1)+x-fenetre-1,'r','linewidth',2)
    %     axis(data_gui.h_image_t);
    %     hold on
    %     plot(B{1}(:,2)+y-fenetre-1,B{1}(:,1)+x-fenetre-1,'r','linewidth',2)
    %     imagesc(im_loc)
    %     hold on
    %     if ~isempty(B)
    %         plot(B{1}(:,2),B{1}(:,1),'r','linewidth',2)
    %         disp('ok')
    %     else
    %         disp('ko')
    %     end
end
close(f0)
data_gui.h_plot_cell_surface = [];
guidata(data_gui.h_fig,data_gui)
end

function toggle_cells_surface( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
if data_gui.h_toggle_cells_surface.Value
    set(data_gui.h_toggle_cells_surface,'BackgroundColor',[0.94 0.05 0.05])
    axes(data_gui.h_image_t);
    hold on;
    for k_cell = 1:size(data_gui.liste_Cell{Z_},1)
        if ~isempty(data_gui.liste_Cell{Z_}{k_cell,4})
            data_gui.h_plot_cell_surface(k_cell) = ...
                plot(data_gui.h_image_t,data_gui.liste_Cell{Z_}{k_cell,4}(:,1),...
                data_gui.liste_Cell{Z_}{k_cell,4}(:,2),'r','linewidth',2);
        end
    end
    axes(data_gui.h_std);
    hold on;
    for k_cell = 1:size(data_gui.liste_Cell{Z_},1)
        if ~isempty(data_gui.liste_Cell{Z_}{k_cell,4})
            data_gui.h_plot_cell_surface(k_cell+size(data_gui.liste_Cell{Z_},1)) = ...
                plot(data_gui.h_std,data_gui.liste_Cell{Z_}{k_cell,4}(:,1),...
                data_gui.liste_Cell{Z_}{k_cell,4}(:,2),'r','linewidth',2);
        end
    end
else
    set(data_gui.h_toggle_cells_surface,'BackgroundColor',[0.94 0.94 0.94])
    delete(data_gui.h_plot_cell_surface)
end
guidata(data_gui.h_fig,data_gui)
end

function draw_measure( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_measure.Value
    set(data_gui.h_measure,'BackgroundColor',[0.94 0.05 0.05])
    ligne_mesure = drawline;
    longueur = norm([diff(ligne_mesure.Position(:,1)) diff(ligne_mesure.Position(:,2))]) * ...
        data_gui.scaling * 1e6;
    data_gui.ligne_mesure = ligne_mesure;
    set(ligne_mesure,'Label',[num2str(longueur,'%3.0f'),'µm'])
else
    delete(data_gui.ligne_mesure)
    set(data_gui.h_measure,'BackgroundColor',[0.94 0.94 0.94])
end
guidata(data_gui.h_fig,data_gui)
end

function export_Transients( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
disp('export des transients')
% interrogation pour l'echelle
[reponse,echelle] = echelle_pop();
k_plot = 1;
k_fig = 1;
h_fig = [];
time_stamp = datestr(datetime,'yyyymmddHHMMSS');
save_file =  [data_gui.fich(1:end-4),'_transients_',time_stamp,'.tiff'];
h_fig(1) = figure('name','transients 1','WindowStyle','docked');
couleur = {'r','g'};

% boucle de calcul
activite_plot = [];
for k_Z = 1:data_gui.nb_Z
    for k_Cell = 1 : size(data_gui.liste_Cell{k_Z},1)
        x = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(3));
        y = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(2));
        if data_gui.h_raw.Value == 1
            activite = squeeze(mean(mean(data_gui.im_raw0{k_Z}(...
                x-3:x+3,...
                y-3:y+3,:),1),2));
        else
            activite = squeeze(mean(mean(data_gui.im_raw_smooth{k_Z}(...
                x-3:x+3,...
                y-3:y+3,:),1),2));
        end        
        data_BL = activite(data_gui.BL(1):data_gui.BL(2));
        activite = ( activite - mean(data_BL)) / mean(data_BL);
        activite_plot(k_Z,k_Cell,:) = activite;
    end
end
% calcul du max pour mise à l'échelle
% boucle d'affichage
if reponse == 1
activite_max = max(activite_plot(:));
else
    activite_max = str2double(echelle);
end
for k_Z = 1:data_gui.nb_Z
    for k_Cell = 1 : size(data_gui.liste_Cell{k_Z},1)
        ax = subplot(4,6,k_plot);
        refresh_ligne_temporelle(data_gui,ax,squeeze(activite_plot(k_Z,k_Cell,:)),[x,y])
        box off
        ylim([0 activite_max*1.05])
        % ajouter la gestion de l'echelle et du fond, les lignes BL/STIM et
        % les seuils
        title(data_gui.liste_Cell{k_Z}{k_Cell,1},'color',couleur{data_gui.liste_Cell{k_Z}{k_Cell,3}+1})
        k_plot = k_plot + 1;
        if k_plot > 24
            drawnow;
            F = getframe(gcf);
            [A, Map] = frame2im(F);
            if k_fig == 1
                imwrite(A,save_file)
            else
                imwrite(A,save_file,'WriteMode','append')
            end
            k_plot = 1;
            k_fig = k_fig+1;
            h_fig(k_fig) = figure('name',['transients ',num2str(k_fig)],'WindowStyle','docked');
        end
    end
end
if k_fig >= 1
    F = getframe(gcf);
    [A, Map] = frame2im(F);
    imwrite(A,save_file,'WriteMode','append')
end
end

function export_image( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
[back,type] = gui_pop();
% Z_ = ceil(data_gui.h_Z_slider.Value);
Z_ = data_gui.Z_loc;
% frame_ = ceil(data_gui.h_t_slider.Value);
frame_ = data_gui.t_loc;
time_stamp = datestr(datetime,'yyyymmddHHMMSS');
save_file_t = [data_gui.fich(1:end-4),'_Z',num2str(Z_),'_t',num2str(frame_),'_',time_stamp];
save_file_std = [data_gui.fich(1:end-4),'_Z',num2str(Z_),'_STD_',time_stamp];
smooth_type = data_gui.h_smooth_toggle.Value;
if strcmp(type,'bioformat')
    save_file =  [data_gui.fich(1:end-4),'_',time_stamp,'.tiff'];
    %save_file2 =  [data_gui.fich(1:end-4),'2_',time_stamp,'.tiff'];
    
    %std_max_type = data_gui.h_std_max_toggle.Value;
    data_save = zeros(data_gui.H,data_gui.L,data_gui.nb_Z,1,data_gui.nb_T, 'uint16');
    for k_Z = 1:data_gui.nb_Z
        data_save(:,:,k_Z,1,:) = uint16(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){k_Z});
    end
    bfsave(data_save, save_file, 'dimensionOrder', 'XYZCT');
    %bfsave(data_save, save_file2, 'dimensionOrder', 'XYZCT');
    %  bfsave(data_save, save_file, 'metadata', data_gui.metadata);
elseif strcmp(type,'MAXPROJ')
    save_file_BL =  [data_gui.fich(1:end-4),'_',time_stamp,'_BL.tiff'];
    save_file_ST =  [data_gui.fich(1:end-4),'_',time_stamp,'_ST.tiff'];
    data_gui.stim;
    data_gui.BL;
    data_save = zeros(data_gui.H,data_gui.L,data_gui.nb_Z,data_gui.nb_T, 'uint16');
    for k_Z = 1:data_gui.nb_Z
        data_save(:,:,k_Z,:) = uint16(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){k_Z});
    end
    data_save_BL = uint16(max(data_save(:,:,:,data_gui.BL(1):data_gui.BL(2)),[],[3 4]));
    data_save_ST = uint16(max(data_save(:,:,:,data_gui.stim(1):data_gui.stim(2)),[],[3 4]));
    imwrite(data_save_BL,save_file_BL)
    imwrite(data_save_ST,save_file_ST)
elseif strcmp(type,'STD_PROJ')
    save_file_BL =  [data_gui.fich(1:end-4),'_Z',num2str(Z_),'_',time_stamp,'STD_BL.tiff'];
    save_file_ST =  [data_gui.fich(1:end-4),'_Z',num2str(Z_),'_',time_stamp,'STD_ST.tiff'];
    data_gui.stim;
    data_gui.BL;
    %data_save = zeros(data_gui.H,data_gui.L,data_gui.nb_T, 'uint16');
    data_save = uint16(squeeze(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_}));    
    data_save_BL = uint16(std(double(data_save(:,:,data_gui.BL(1):data_gui.BL(2))),0,3));
    data_save_ST = uint16(std(double(data_save(:,:,data_gui.stim(1):data_gui.stim(2))),0,3));
    imwrite(data_save_BL,save_file_BL)
    imwrite(data_save_ST,save_file_ST)
elseif strcmp(type,'DFF_MAX_PROJ')
    N_stim = data_gui.BL(2)-data_gui.BL(1) + 1;
    save_file =  [data_gui.fich(1:end-4),'_Z',num2str(Z_),'_',time_stamp,'_DFF_MAX_PROJ.png'];
    data_save = zeros(data_gui.H,data_gui.L,N_stim, 'single');
    F0 = mean(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_}(:,:,data_gui.BL(1):data_gui.BL(2)),3);    
    for k_stim = 1:N_stim
        data_save(:,:,k_stim) = (single(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_}(:,:,data_gui.stim(1)+k_stim-1)) - ...
           F0 )./F0;
    end
    data_save = max(data_save,[],3);
    imwrite(data_save,save_file)
else
    if back
        imwrite(frame2im(getframe(data_gui.h_image_t)),[save_file_t,type])
        imwrite(frame2im(getframe(data_gui.h_std)),[save_file_std,type])
    else
        Im = get(data_gui.h_image_t.Children(end),'CData');
        set(data_gui.h_image_t.Children(end),'CData',[]);
        imwrite(frame2im(getframe(data_gui.h_image_t)),[save_file_t,type])
        set(data_gui.h_image_t.Children(end),'CData',Im);
        Im = get(data_gui.h_std.Children(end),'CData');
        set(data_gui.h_std.Children(end),'CData',[]);
        imwrite(frame2im(getframe(data_gui.h_std)),[save_file_std,type])
        set(data_gui.h_std.Children(end),'CData',Im);
    end
end
disp('save images ok')
end

function ajoute_zone ( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
axes(data_gui.h_image_t);
data_gui.nb_zone(Z_) = data_gui.nb_zone(Z_) +1;
zone = drawpolygon('FaceAlpha',0,'FaceSelectable',0,'Deletable',0,...
    'InteractionsAllowed','all','label',num2str(data_gui.nb_zone(Z_)));
if size(zone.Position,1) == 1
    delete(zone);
else
    hold on;
    zone.InteractionsAllowed='none';
    %data_gui.liste_zone{Z_} = [data_gui.liste_zone{Z_};{num2str(data_gui.nb_zone(Z_)),zone.Position}];
    data_gui.liste_zone{Z_} = [data_gui.liste_zone{Z_};zone];
    guidata(data_gui.h_fig,data_gui)
end

end

function copy_zone( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
for k_zone = 1:data_gui.nb_zone(Z_)
    for k_Z = 1:data_gui.nb_Z
        if k_Z ~= Z_
            zone = images.roi.Polygon('Parent',data_gui.h_image_t,...
                'FaceAlpha',0,'FaceSelectable',0,'Deletable',0,...
                'InteractionsAllowed','none','label',data_gui.liste_zone{Z_}(k_zone).Label,...
                'Position',data_gui.liste_zone{Z_}(k_zone).Position,'Visible','off');
            data_gui.liste_zone{k_Z} = [data_gui.liste_zone{k_Z};zone];
            data_gui.nb_zone(k_Z) = data_gui.nb_zone(Z_);
        end
    end
end
guidata(data_gui.h_fig,data_gui)
end

function modifie_zone( ~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
if data_gui.h_modifier_zone.Value
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).InteractionsAllowed='all';
    end
    set(data_gui.h_modifier_zone,'BackgroundColor',[0.94 0.05 0.05])
else
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).InteractionsAllowed='none';
    end
    set(data_gui.h_modifier_zone,'BackgroundColor',[0.94 0.94 0.94])
end
guidata(data_gui.h_fig,data_gui)
end

function supprime_zone (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
Z_ = data_gui.Z_loc;
if data_gui.h_supprimer_zone.Value
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).InteractionsAllowed='all';
        data_gui.liste_zone{Z_}(k_zone).Deletable=1;
        data_gui.liste_zone{Z_}(k_zone).FaceSelectable=1;
    end
    set(data_gui.h_supprimer_zone,'BackgroundColor',[0.94 0.05 0.05])
else
    % il faut retirer la zone effacée de la liste, et renuméroter les zones
    % avant de les rendre non selectionnables !!
    ID_deleted  = 0;
    for k_zone = 1:data_gui.nb_zone(Z_)
        try
            h_tmp = data_gui.liste_zone{Z_}(k_zone).Label;
        catch ME
            % c'est la zone effacée !
            ID_deleted  = k_zone;
        end
    end
    if ID_deleted ~= 0
        data_gui.liste_zone{Z_} = data_gui.liste_zone{Z_}([1:data_gui.nb_zone(Z_)]~=ID_deleted,:);
        data_gui.nb_zone(Z_) = data_gui.nb_zone(Z_) - 1;
    end
    %et lister les zones restantes pour les renumétorer
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).InteractionsAllowed='none';
        data_gui.liste_zone{Z_}(k_zone).Deletable=0;
        data_gui.liste_zone{Z_}(k_zone).FaceSelectable=0;
        data_gui.liste_zone{Z_}(k_zone).Label = num2str(k_zone);
    end
    set(data_gui.h_supprimer_zone,'BackgroundColor',[0.94 0.94 0.94])
end
guidata(data_gui.h_fig,data_gui);
end

function assign_cell(~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
for k_Z = 1:data_gui.nb_Z
    for k_cell = 1:size(data_gui.liste_Cell{k_Z},1)
        data_gui.liste_Cell{k_Z}{k_cell,2}(4) = 0;
        for k_zone = 1:data_gui.nb_zone(k_Z)
            if inROI(data_gui.liste_zone{k_Z}(k_zone),...
                    data_gui.liste_Cell{k_Z}{k_cell,2}(2),...
                    data_gui.liste_Cell{k_Z}{k_cell,2}(3))
                data_gui.liste_Cell{k_Z}{k_cell,2}(4) = ...
                    str2double(data_gui.liste_zone{k_Z}(k_zone).Label);
            end
        end
        
    end
end
% Z_ = ceil(data_gui.h_Z_slider.Value);
Z_ = data_gui.Z_loc;
refresh_liste_Cell(data_gui.h_liste_Cell,data_gui.liste_Cell{Z_})
guidata(data_gui.h_fig,data_gui);
end

function hide_zone (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_hide_zone.Value
    set(data_gui.h_hide_zone,'BackgroundColor',[0.05 0.94 0.05])
    Z_ = data_gui.Z_loc;
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).Visible = 'off';
    end
else
    Z_ = data_gui.Z_loc;
    set(data_gui.h_hide_zone,'BackgroundColor',[0.94 0.94 0.94])
    for k_zone = 1:data_gui.nb_zone(Z_)
        data_gui.liste_zone{Z_}(k_zone).Visible = 'on';
    end
end
end


function change_colormap (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
smooth_type = data_gui.h_smooth_toggle.Value;
std_max_type = data_gui.h_std_max_toggle.Value;
Z_ = data_gui.Z_loc;
axes(data_gui.h_image_t);
val_max =  ceil(max(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_},[],'all'));
switch data_gui.h_colormap_toggle.Value
    case 1
        colormap(data_gui.h_image_t,parula(val_max));
    case 2
        colormap(data_gui.h_image_t,jet(val_max));
    case 3
        colormap(data_gui.h_image_t,gray(val_max));
end
axes(data_gui.h_std);
switch std_max_type
    case 1
        val_max2 = ceil(max(data_gui.im_std_gaussian{Z_}(:)));
    case 2
        val_max2 = ceil(max(data_gui.im_max_raw{Z_}(:)));
end
switch data_gui.h_colormap_toggle.Value
    case 1
        colormap(data_gui.h_std,parula(val_max2));
    case 2
        colormap(data_gui.h_std,jet(val_max2));
    case 3
        colormap(data_gui.h_std,gray(val_max2));
end

end

function liste_click (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
tag_liste_Cell = findobj(h_f,'Tag','liste_Cell');
C = get (tag_liste_Cell);
disp(C.Value);
end

function select_magnet (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_magnet.Value
    disp('Mode magnet ON')
else
    disp('Mode magnet OFF')
end
end

function select_fond (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_fond.Value
    disp('Fond ON')
    data_gui.fond = 1;
else
    disp('Fond OFF')
    data_gui.fond = 0;
end
guidata(data_gui.h_fig,data_gui);
refresh_base(data_gui,'fond');
end

function move_Cell (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_move.Value
    set(data_gui.h_fig,'Pointer','hand')
    set(data_gui.h_move,'BackgroundColor',[0.94 0.05 0.05])
    set(data_gui.h_ajouter,'Enable','off')
    set(data_gui.h_supprimer,'Enable','off')
    set(data_gui.h_move_all,'Enable','off')
else
    set(data_gui.h_fig,'Pointer','Arrow')
    set(data_gui.h_move,'BackgroundColor',[0.94 0.94 0.94])
    set(data_gui.h_ajouter,'Enable','on')
    set(data_gui.h_supprimer,'Enable','on')
    set(data_gui.h_move_all,'Enable','on')
end
end

function move_Cell_all (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
% Z_ = ceil(data_gui.h_Z_slider.Value);
Z_ = data_gui.Z_loc;
data_gui.selected_Cell = [1:size(data_gui.liste_Cell{Z_},1)];
if data_gui.h_move_all.Value
    set(data_gui.h_move_all,'BackgroundColor',[0.94 0.05 0.05])
    set(data_gui.h_ajouter,'Enable','off')
    set(data_gui.h_supprimer,'Enable','off')
    set(data_gui.h_move,'Enable','off')
else
    set(data_gui.h_move_all,'BackgroundColor',[0.94 0.94 0.94])
    set(data_gui.h_ajouter,'Enable','on')
    set(data_gui.h_supprimer,'Enable','on')
    set(data_gui.h_move,'Enable','on')
    for k_Cell_loc = 1:size(data_gui.liste_Cell{Z_},1)
        % ajout du test de responder
        x = round(data_gui.liste_Cell{Z_}{k_Cell_loc,2}(3));
        y = round(data_gui.liste_Cell{Z_}{k_Cell_loc,2}(2));
        activite = squeeze(median(median(data_gui.im_raw0{Z_}(...
            x-3:x+3,...
            y-3:y+3,:),1),2));
        data_gui.liste_Cell{Z_}{k_Cell_loc,3} = is_responder(activite,data_gui.im_raw0{Z_},data_gui.BL,data_gui.stim,data_gui.multi_std);
    end
    refresh_base(data_gui,'move_all')
end
guidata(data_gui.h_fig,data_gui)
end

function move_Cell_sel (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
disp(data_gui.h_liste_Cell.Value);
data_gui.selected_Cell = data_gui.h_liste_Cell.Value;
if data_gui.h_move_all.Value
    set(data_gui.h_move_sel,'BackgroundColor',[0.94 0.05 0.05])
    set(data_gui.h_ajouter,'Enable','off')
    set(data_gui.h_supprimer,'Enable','off')
    set(data_gui.h_move,'Enable','off')
    set(data_gui.h_move_all,'Enable','off')
else
    set(data_gui.h_move_sel,'BackgroundColor',[0.94 0.94 0.94])
    set(data_gui.h_ajouter,'Enable','on')
    set(data_gui.h_supprimer,'Enable','on')
    set(data_gui.h_move,'Enable','on')
    set(data_gui.h_move_all,'Enable','on')
end
refresh_base(data_gui,'move_sel');
guidata(data_gui.h_fig,data_gui)
end

function export_Cell (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
set(data_gui.h_export,'BackgroundColor',[0.4 0.9 0.1])
texte_save = cell(1,4);
texte_save(1,:) = {'Z','ID','X','Y'};
for k_t = 1:data_gui.nb_T
    texte_save = [texte_save,{['Frame_',num2str(k_t)]}]; %#ok<*AGROW>
end
texte_save = [texte_save,{'Responder'}];
for k_Z = 1:data_gui.nb_Z
    for k_Cell = 1 : size(data_gui.liste_Cell{k_Z},1)
        x = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(3));
        y = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(2));
        if data_gui.h_raw.Value == 1
            activite = squeeze(mean(mean(data_gui.im_raw0{k_Z}(...
                x-3:x+3,...
                y-3:y+3,:),1),2));
        else
            activite = squeeze(mean(mean(data_gui.im_raw_smooth{k_Z}(...
                x-3:x+3,...
                y-3:y+3,:),1),2));
        end
        ID_cell = data_gui.liste_Cell{k_Z}{k_Cell,1};
        if  length(data_gui.liste_Cell{k_Z}{k_Cell,2}) == 4
            ID_cell = [ID_cell,...
                ' (',num2str(data_gui.liste_Cell{k_Z}{k_Cell,2}(4)),')'];
        else
            ID_cell = [ID_cell,...
                ' ()'];
        end
        ligne_save = {k_Z...%{num2str(k_Z,'%2.0f'),...
            ID_cell,...
            x,...%num2str(x,'%6.0f'),...
            y};...%num2str(y,'%6.0f')};
            for k_t = 1:data_gui.nb_T
            %             ligne_save = [ligne_save,{num2str(activite(k_t),'%6.0f')}];
            ligne_save = [ligne_save,{activite(k_t)}];
            end
            %         ligne_save = [ligne_save,{num2str(data_gui.liste_Cell{k_Z}{k_Cell,3})}];
            ligne_save = [ligne_save,{double(data_gui.liste_Cell{k_Z}{k_Cell,3})}];
            texte_save = [texte_save;ligne_save];
    end
end
save_file = [data_gui.fich(1:end-4),'_Cell_',datestr(datetime,'yy_mm_dd_HH_MM_SS'),'.xlsx'];
% warning('off','MATLAB:xlswrite:AddSheet')
try
    %xlswrite(save_file,texte_save,'Sheet','cells')
    writecell(texte_save,save_file,'Sheet','cells')
catch ME
    disp('Erreur sur la sauvegarde, changement de nom')
    save_file = ['_Cell_',datestr(datetime,'yy_mm_dd_HH_MM_SS'),'.xlsx'];
    %xlswrite(save_file,texte_save,'cells')
    writecell(texte_save,save_file,'Sheet','cells')
end
% sauvegarde du DF/F
texte_save1 = texte_save;
for k_cell = 1:size(texte_save1,1)-1
    data_BL = [];
    data_stim = [];
    data_tot = [];
    for k_BL = 1:diff(data_gui.BL)+1
        data_BL(k_BL) = (texte_save1{k_cell+1,4+data_gui.BL(1)+k_BL-1});
    end
    for k_stim = 1:diff(data_gui.stim)+1
        data_stim(k_stim) = (texte_save1{k_cell+1,4+data_gui.stim(1)+k_stim-1});
    end
    for k_tot = 1:size(texte_save1,2)-5
        data_tot(k_tot) = (texte_save1{k_cell+1,4+k_tot});
    end
    DF_F = ( data_tot - mean(data_BL)) / mean(data_BL)*100;
    for k_tot = 1:size(texte_save1,2)-5
        texte_save1{k_cell+1,4+k_tot} = (DF_F(k_tot));
    end
end
% xlswrite(save_file,texte_save1,'dF_F')
writecell(texte_save1,save_file,'Sheet','dF_F')
% sauvegarde des zones s'il y en a
texte_save2 = cell(1,100);
texte_save2(1:4) = {'Z','ID','N_vertex','Coord'};
for k_Z = 1:data_gui.nb_Z
    for k_zone = 1:data_gui.nb_zone(k_Z)
        ligne_save1 = {num2str(k_Z,'%2.0f'),...
            data_gui.liste_zone{k_Z}(k_zone).Label,...
            num2str(size( data_gui.liste_zone{k_Z}(k_zone).Position,1),'%2.0f')};
        ligne_save2 =  {'','',''};
        for k_vertex = 1:size( data_gui.liste_zone{k_Z}(k_zone).Position,1)
            ligne_save1 = [ligne_save1,...
                {data_gui.liste_zone{k_Z}(k_zone).Position(k_vertex,1)}];
            ligne_save2 = [ligne_save2,...
                {data_gui.liste_zone{k_Z}(k_zone).Position(k_vertex,2)}];
        end
        for k_vertex = size( data_gui.liste_zone{k_Z}(k_zone).Position,1)+4:100
            ligne_save1(k_vertex) = {''};
            ligne_save2(k_vertex) = {''};
        end
        texte_save2 = [texte_save2;ligne_save1;ligne_save2];
    end
end
% xlswrite(save_file,texte_save2,'Zones')
writecell(texte_save2,save_file,'Sheet','Zones')
option_texte = {'No','Yes'};
texte_save3 = {'Version',num2str(data_gui.metadata.version);...
    'N Stack',num2str(data_gui.metadata.nb_Z);...
    'N Frames',num2str(data_gui.metadata.nb_T);...
    'BaseLine',['[',num2str(data_gui.BL(1)),'-',num2str(data_gui.BL(2)),']'] ;
    'Stimulation',['[',num2str(data_gui.stim(1)),'-',num2str(data_gui.stim(2)),']'];
    'Nb StD',num2str(data_gui.multi_std);...
    'Offset(%)',data_gui.h_offset_seuil2.String;...
    'Image Height',num2str(data_gui.metadata.H);...
    'Image Length',num2str(data_gui.metadata.L);...
    'Drift',option_texte{data_gui.metadata.mouvement_ok+1};...
    'Rotation',option_texte{data_gui.metadata.rotation_ok+1};...
    'Shear',option_texte{data_gui.metadata.shear_ok+1};...
    'Gaussian size',num2str(data_gui.metadata.sigma_g);...
    'Median size',num2str(data_gui.metadata.taille_m);...
    };
% xlswrite(save_file,texte_save3,'MetaData')
writecell(texte_save3,save_file,'Sheet','MetaData')
% warning('on','MATLAB:xlswrite:AddSheet')
% pause(0.5)
set(data_gui.h_export,'BackgroundColor',[0.94 0.94 0.94])
disp('sauvegarde cells OK')
end

function import_Cell (~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
[fich_load,rep_load] = uigetfile({'*.xlsx;*.xls'});
data_cells = readcell([rep_load,fich_load],'sheet','Cells');
data_zones = readcell([rep_load,fich_load],'sheet','Zones');
data = [cell2mat(data_cells(2:end,1)),nan(size(data_cells,1)-1,1),cell2mat(data_cells(2:end,3:end))];
textdata = cell(size(data_cells));
textdata(1,:) = data_cells(1,:);
textdata(:,2) = data_cells(:,2);
%data_save = importdata([rep_load,fich_load]);
for k_Z = 1:data_gui.nb_Z
    % récupération des cellules
    
    %     if isstruct(data_save.data)
    %         data = data_save.data.cells;
    %         textdata = data_save.textdata.cells;
    %     else
    %         data = data_save.data;
    %         textdata = data_save.textdata;
    %     end
    index = find(data(:,1) == k_Z);
    
    if ~isempty(index)
        data_gui.liste_Cell{k_Z} = cell(length(index),4);
        for k_Cell = 1:length(index)
            index_par1 = find(textdata{index(k_Cell)+1,2} == '(');
            index_par2 = find(textdata{index(k_Cell)+1,2} == ')');
            id_zone = textdata{index(k_Cell)+1,2}(index_par1+1:index_par2-1);
            if isempty(id_zone)
                data_gui.liste_Cell{k_Z}{k_Cell,1} = textdata{index(k_Cell)+1,2};
            else
                data_gui.liste_Cell{k_Z}{k_Cell,1} = textdata{index(k_Cell)+1,2}(1:index_par1-2);
            end
            data_gui.liste_Cell{k_Z}{k_Cell,2} = [k_Cell data(index(k_Cell),4:-1:3)];
            
            if data(index(k_Cell),end) == 1 || data(index(k_Cell),end) == 0
                data_gui.liste_Cell{k_Z}{k_Cell,3} = data(index(k_Cell),end) == 1;
            else
                % ajout du test de responder à travailler
                x = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(3));
                y = round(data_gui.liste_Cell{k_Z}{k_Cell,2}(2));
                activite = squeeze(mean(mean(data_gui.im_raw_smooth{k_Z}(...
                    x-3:x+3,...
                    y-3:y+3,:),1),2));
                data_gui.liste_Cell{k_Z}{k_Cell,3} = is_responder(activite,data_gui.im_raw_smooth{k_Z},data_gui.BL,data_gui.stim,data_gui.multi_std);
            end
            if ~isempty(id_zone)
                data_gui.liste_Cell{k_Z}{k_Cell,2}(4) = str2double(id_zone);
            end
        end
    end
    % récupération des zones
    %     if isstruct(data_save.data)
    if size(data_zones,1) >1
        data_gui.liste_zone{k_Z} = {};
        %         if isfield(data_save.data,'Zones')
        data_zone1 = data_zones;%data_save.data.Zones;
        for k1 = 1:size(data_zone1,1)
            for k2 = 1:size(data_zone1,2)
                if ismissing(data_zone1{k1,k2})
                    if isnumeric(data_zone1{2,1}) % vieux fichier
                        data_zone1{k1,k2} = 0;
                    else
                        data_zone1{k1,k2} = '';
                    end
                    
                end
            end
        end
        if isnumeric(data_zone1{2,1}) % vieux fichier
            index = find(cell2mat(data_zone1(2:end,1))==k_Z);
        else
            index = find(contains(data_zone1(:,1) ,num2str(k_Z)));
        end
        if ~isempty(index)
            for k_zone = 1:length(index)
                if isnumeric(data_zone1{2,1}) % vieux fichier
                    Position = cell2mat(data_zone1(1+index(k_zone):index(k_zone)+2,...
                        4:4+data_zone1{1+index(k_zone),3}-1));
                    zone = images.roi.Polygon('Parent',data_gui.h_image_t,...
                        'FaceAlpha',0,'FaceSelectable',0,'Deletable',0,...
                        'InteractionsAllowed','none','label',num2str(data_zone1{1+index(k_zone),2}),...
                        'Position',Position','Visible','off');
                else
                    Position = cell2mat(data_zone1(index(k_zone):index(k_zone)+1,...
                        4:4+str2double(data_zone1{index(k_zone),3})-1));
                    zone = images.roi.Polygon('Parent',data_gui.h_image_t,...
                        'FaceAlpha',0,'FaceSelectable',0,'Deletable',0,...
                        'InteractionsAllowed','none','label',data_zone1{index(k_zone),2},...
                        'Position',Position','Visible','off');
                end
                
                
                data_gui.liste_zone{k_Z} = [data_gui.liste_zone{k_Z};zone];
                data_gui.nb_zone(k_Z) = data_gui.nb_zone(k_Z)+1;
            end
            set(data_gui.h_liste_Cell,'string',data_gui.liste_Cell{k_Z}(:,1))
        end
        
        %data_gui.nb_zone = zeros(nb_Z,1);
        %data_gui.liste_zone = cell(nb_Z,1);
        %         end
        %     else
        % vieux fichier, pas de cellule
        
    end
    
end
guidata(data_gui.h_fig,data_gui)
refresh_base(data_gui,eventdata.AffectedObject.Tag);
refresh_zone(data_gui,1);
end

function add_Cell(~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_ajouter.Value
    %set(gcf,'Pointer','cross')
    set(data_gui.h_fig,'Pointer','custom','PointerShapeCData',data_gui.curseur,...
        'PointerShapeHotSpot',[8.5 8.5])
    set(data_gui.h_ajouter,'BackgroundColor',[0.94 0.05 0.05])
    set(data_gui.h_move,'Enable','off')
    set(data_gui.h_supprimer,'Enable','off')
    set(data_gui.h_move_all,'Enable','off')
    set(data_gui.h_move_sel,'Enable','off')
else
    set(data_gui.h_fig,'Pointer','Arrow')
    set(data_gui.h_ajouter,'BackgroundColor',[0.94 0.94 0.94])
    set(data_gui.h_move,'Enable','on')
    set(data_gui.h_supprimer,'Enable','on')
    set(data_gui.h_move_all,'Enable','on')
    set(data_gui.h_move_sel,'Enable','on')
end
%guidata(gcf,data_gui)
end

function delete_Cell(~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_supprimer.Value
    set(data_gui.h_fig,'Pointer','crosshair')
    set(data_gui.h_supprimer,'BackgroundColor',[0.94 0.05 0.05])
    set(data_gui.h_ajouter,'Enable','off')
    set(data_gui.h_move,'Enable','off')
    set(data_gui.h_move_all,'Enable','off')
    set(data_gui.h_move_sel,'Enable','off')
else
    set(data_gui.h_fig,'Pointer','Arrow')
    set(data_gui.h_supprimer,'BackgroundColor',[0.94 0.94 0.94])
    set(data_gui.h_ajouter,'Enable','on')
    set(data_gui.h_move,'Enable','on')
    set(data_gui.h_move_all,'Enable','on')
    set(data_gui.h_move_sel,'Enable','on')
end
%guidata(gcf,data_gui)
end

function mouseClick (src,~)
data_gui =  guidata(src);
C0 = get (data_gui.h_image_t, 'CurrentPoint');
C1 = get (data_gui.h_std, 'CurrentPoint');
click_type = get(src,'SelectionType');
%disp(click_type)
if C0(1,1) > 1 && C0(1,1) < data_gui.L && C0(1,2) > 1 && C0(1,2) < data_gui.H
    C2 = C0;
    dessine = 1;
elseif C1(1,1) > 1 && C1(1,1) < data_gui.L  && C1(1,2) > 1 && C1(1,2) < data_gui.H
    C2 = C1;
    dessine = 1;
else
    dessine = 0;
end
%
if dessine
    p = round(C2(1,2));
    n = round(C2(1,1));
    %Z_ = ceil(data_gui.h_Z_slider.Value);
    Z_ = data_gui.Z_loc;
    if isempty(data_gui.liste_Cell{Z_})
        ID_Cell_max = 0;
    else
        data_cell = cell2mat(data_gui.liste_Cell{Z_}(:,2));
        ID_Cell_max = max(data_cell(:,1));
    end
    
    NCell = size(data_gui.liste_Cell{Z_},1);
    if data_gui.h_ajouter.Value && strcmp(click_type,'normal')
        disp('ajout d''un Cell')
        if data_gui.h_magnet.Value
            im_loc = data_gui.im_std_gaussian{Z_}(p-5:p+5,n-5:n+5);
            maxValue = max(im_loc(:));
            [rowsOfMaxes,colsOfMaxes] = find(im_loc == maxValue);
            p = p + (rowsOfMaxes - 6);
            n = n + (colsOfMaxes - 6);
            data_gui.liste_Cell{Z_} = [data_gui.liste_Cell{Z_};...
                {['Z',num2str(Z_),'-',num2str(ID_Cell_max+1)],[ID_Cell_max+1,n,p,0],[],[]}];
        else
            data_gui.liste_Cell{Z_} = [data_gui.liste_Cell{Z_};...
                {['Z',num2str(Z_),'-',num2str(ID_Cell_max+1)],[ID_Cell_max+1,n+1,p+1,0],[],[]}];
        end
        % ajout du test de responder
        x = round(data_gui.liste_Cell{Z_}{end,2}(3));
        y = round(data_gui.liste_Cell{Z_}{end,2}(2));
        activite = squeeze(median(median(data_gui.im_raw0{Z_}(...
            x-3:x+3,...
            y-3:y+3,:),1),2));
        data_gui.liste_Cell{Z_}{end,3} = is_responder(activite,data_gui.im_raw0{Z_},data_gui.BL,data_gui.stim,data_gui.multi_std);
        
        guidata(data_gui.h_fig,data_gui)
        refresh_base(data_gui,'ajouter');
    elseif data_gui.h_supprimer.Value
        disp('suppression d''un Cell')
        coord = cell2mat(data_gui.liste_Cell{Z_}(:,2));
        [~,ID_Cell_delete] = min(norme_ligne(coord(:,2:3) - repmat([n,p],NCell,1)));
        data_gui.liste_Cell{Z_} = data_gui.liste_Cell{Z_}([1:NCell]~=ID_Cell_delete,:);
        set(data_gui.h_liste_Cell,'Value',1);
        guidata(data_gui.h_fig,data_gui)
        refresh_base(data_gui,'supprimer');
    elseif data_gui.h_move.Value && strcmp(click_type,'normal')
        disp(data_gui.liste_Cell{Z_})
        if data_gui.hook(1)
            if data_gui.h_magnet.Value
                im_loc = data_gui.im_std_gaussian{Z_}(p-5:p+5,n-5:n+5);
                maxValue = max(im_loc(:));
                [rowsOfMaxes,colsOfMaxes] = find(im_loc == maxValue);
                p = p + (rowsOfMaxes - 6);
                n = n + (colsOfMaxes - 6);
                data_gui.liste_Cell{Z_}{data_gui.hook(2),2}(2:3) = [n,p];
                disp(data_gui.liste_Cell{Z_})
                h_text = findobj(data_gui.h_fig,'type','text');
                h_line = findobj(data_gui.h_fig,'type','line');
                XData = h_line(1).XData;
                XData(data_gui.hook(2)) = n;
                YData = h_line(1).YData;
                YData(data_gui.hook(2)) = p;
                set(h_line(1),'XData',XData,'YData',YData);
                set(h_line(2),'XData',XData,'YData',YData);
                NCell = size(data_gui.liste_Cell{Z_},1);
                set(h_text(NCell+1-data_gui.hook(2)),'Position',[n,p]+[4 -10])
                set(h_text(2*NCell+1-data_gui.hook(2)),'Position',[n,p]+[4 -10])
                drawnow
                disp(data_gui.liste_Cell{Z_})
            else
                data_gui.liste_Cell{Z_}{data_gui.hook(2),2}(2:3) = [n,p];
                drawnow
                disp(data_gui.liste_Cell{Z_})
            end
            % ajout du test de responder
            x = round(data_gui.liste_Cell{Z_}{data_gui.hook(2),2}(3));
            y = round(data_gui.liste_Cell{Z_}{data_gui.hook(2),2}(2));
            activite = squeeze(median(median(data_gui.im_raw0{Z_}(...
                x-3:x+3,...
                y-3:y+3,:),1),2));
            data_gui.liste_Cell{Z_}{data_gui.hook(2),3} = is_responder(activite,data_gui.im_raw0{Z_},data_gui.BL,data_gui.stim,data_gui.multi_std);
            %disp(data_gui.liste_Cell{Z_})
            data_gui.hook(1) = 0;
            % unselect Cell, update values
            disp('fin déplacement d''une Cellule')
        else
            coord = cell2mat(data_gui.liste_Cell{Z_}(:,2));
            [~,ID_Cell_delete] = min(norme_ligne(coord(:,2:3) - repmat([n,p],NCell,1)));
            data_gui.hook = [1 ID_Cell_delete];
            disp(['Déplacement de la cellule ',data_gui.liste_Cell{Z_}{ID_Cell_delete,1}])
        end
        
        guidata(data_gui.h_fig,data_gui)
        refresh_base(data_gui,'move');
    elseif data_gui.h_check.Value || strcmp(click_type,'extend')
        % si on clic pas trop loin d'un ROI, on bascule son état de
        % reponder
        coord = cell2mat(data_gui.liste_Cell{Z_}(:,2));
        [~,ID_Cell_toggle] = min(norme_ligne(coord(:,2:3) - repmat([n,p],NCell,1)));
        data_gui.liste_Cell{Z_}{ID_Cell_toggle,3} = ~data_gui.liste_Cell{Z_}{ID_Cell_toggle,3};
        %delete(data_gui.h_plot_check);
        guidata(data_gui.h_fig,data_gui)
        %check_responder();
        % donc effaçage des points et replot
        refresh_base(data_gui,'check');
        %refresh_base(data_gui,'move');
    end
end

end

function check_responder(~,eventdata)
h_f = eventdata.AffectedObject.Parent;
data_gui =  guidata(h_f);
if data_gui.h_check.Value
    set(data_gui.h_check,'BackgroundColor',[0.94 0.05 0.05])
else
    set(data_gui.h_check,'BackgroundColor',[0.94 0.94 0.94])
end
end

function etat = is_responder(F_in,im_in,BL,stim,multi_std)
%data_gui =  guidata(gcf);
L = length(F_in);
seuil1 = multi_std*std(F_in(BL(1):BL(2)));
%seuil2 = 3*std(F_in(11:end));
%  etat = max(F_in(6:10)) > seuil1 & max(F_in(6:10)) > seuil2;
seuil0 = mean(std(im_in(:,:,[[BL(1):BL(2)],[stim(2)+1:L]]),[],3),'all');
if seuil1 == 0
    seuil1 = seuil0;
end
% if seuil2 == 0
%     seuil2 = seuil0;
% end
etat = max(F_in(stim(1):stim(2))) > mean(F_in(BL(1):BL(2)))+seuil1 ;%& ...
%max(F_in(6:10)) > mean(F_in(11:L))+seuil2;
end

function refresh_ligne_temporelle(data_gui,cible,activite,C2)
Z_ = data_gui.Z_loc;
% C0 = get (data_gui.h_image_t, 'CurrentPoint');
% C1 = get (data_gui.h_std, 'CurrentPoint');
% if C0(1,1) > 1 && C0(1,1) < data_gui.L  && C0(1,2) > 1 && C0(1,2) < data_gui.H
%     C2 = C0;
% elseif C1(1,1) > 1 && C1(1,1) < data_gui.L  && C1(1,2) > 1 && C1(1,2) < data_gui.H
%     C2 = C1;
% end
data_gui.BL = round([str2double(data_gui.h_slider_BL_deb.String) str2double(data_gui.h_slider_BL_fin.String)]);
data_gui.stim = round([str2double(data_gui.h_slider_stim_deb.String) str2double(data_gui.h_slider_stim_fin.String)]);
limite_x = xlim(data_gui.h_pix_tempo);
multi_std = round(str2double(data_gui.h_slider_multi_std.String));
cla(data_gui.h_pix_tempo);
hold(data_gui.h_pix_tempo,'on')
% data_gui.line_temporelle = squeeze(data_gui.(data_gui.type_image{data_gui.h_smooth_toggle.Value,2-data_gui.fond}){Z_}(round(C2(1,2)),round(C2(1,1)),:));
[M,I] = max(activite(data_gui.stim(1):data_gui.stim(2)));
seuil = mean(activite(data_gui.BL(1):data_gui.BL(2))) + ...
    multi_std*std(activite(data_gui.BL(1):data_gui.BL(2)));
seuil2 = max(activite(data_gui.BL(1):data_gui.BL(2))) * ...
    (1+str2double(data_gui.h_offset_seuil2.String)/100);
plot(cible,activite)
grid(cible,'on')
if data_gui.h_scale_Y.Value
    ylim(cible,[data_gui.min{Z_}(data_gui.h_smooth_toggle.Value,2-data_gui.fond)...
        data_gui.max{Z_}(data_gui.h_smooth_toggle.Value,2-data_gui.fond)]);
    ly = [data_gui.min{Z_}(data_gui.h_smooth_toggle.Value,2-data_gui.fond) data_gui.max{Z_}(data_gui.h_smooth_toggle.Value,2-data_gui.fond)];
else
    ylim(cible,[min(activite) max([seuil;seuil2;activite])]);
    ly = ylim(cible);
end
data_gui.h_patch_BL = patch(cible,[data_gui.BL(1) data_gui.BL(2) data_gui.BL(2) data_gui.BL(1) data_gui.BL(1)],...
    ly([1 1 2 2 1]),'b','FaceAlpha',0.2,'EdgeColor','none');
data_gui.h_patch_stim = patch(cible,[data_gui.stim(1) data_gui.stim(2) data_gui.stim(2) data_gui.stim(1) data_gui.stim(1)],...
    ly([1 1 2 2 1]),'m','FaceAlpha',0.2,'EdgeColor','none');
if data_gui.h_scale_X.Value
    xlim(cible,limite_x)
else
    xlim(cible,[1 data_gui.nb_T])
end

if M > seuil
    couleur = 'g';
else
    couleur = 'r';
end
data_gui.h_ligne_seuil = line(cible,[1 data_gui.nb_T],[seuil seuil],'linewidth',2,'color',couleur );
if M > seuil2
    couleur2 = 'y';
else
    couleur2 = 'k';
end
data_gui.h_ligne_seuil2 = line(cible,[1 data_gui.nb_T],[seuil2 seuil2],'linewidth',2,'color',couleur2 );
hold on
plot(cible,I+data_gui.stim(1)-1,M,'k*')
%set(data_gui.h_pix_tempo,'YTick',[])

set(cible,'YTickmode','auto')
grid(cible,'minor')
title(cible, ['(X,Y) = (', num2str(round(C2(1,1))), ', ',num2str(round(C2(1,2))), ')']);
end

function mouseMove (object, ~)
% disp(object.Number)
data_gui =  guidata(object);
% disp(data_gui.fich)
% Z_ = ceil(data_gui.h_Z_slider.Value);
Z_ = data_gui.Z_loc;
C0 = get (data_gui.h_image_t, 'CurrentPoint');
C1 = get (data_gui.h_std, 'CurrentPoint');
if C0(1,1) > 1 && C0(1,1) < data_gui.L  && C0(1,2) > 1 && C0(1,2) < data_gui.H
    C2 = C0;
    dessine = 1;
elseif C1(1,1) > 1 && C1(1,1) < data_gui.L  && C1(1,2) > 1 && C1(1,2) < data_gui.H
    C2 = C1;
    dessine = 1;
else
    dessine = 0;
end
%
if dessine %&& C2(1,1) > 1 && C2(1,1) < 512 && C2(1,2) > 1 && C2(1,2) < 512
    data_gui.line_temporelle = squeeze(data_gui.(data_gui.type_image{data_gui.h_smooth_toggle.Value,2-data_gui.fond}){Z_}(round(C2(1,2)),round(C2(1,1)),:));
    refresh_ligne_temporelle(data_gui,data_gui.h_pix_tempo,data_gui.line_temporelle,C2)
    if data_gui.hook(1)
        p = round(C2(1,2));
        n = round(C2(1,1));
        h_text = findobj(data_gui.h_fig,'type','text');
        h_line = findobj(data_gui.h_fig,'type','line');
        % mettre à jour les data du Cell
        % on ne met plus à jour les valeurs, seulement les XData
        %data_gui.liste_Cell{Z_}{data_gui.hook(2),2}(2:3) = [n,p];
        %mettre à jour les XData des lines
        XData = h_line(1).XData;
        XData(data_gui.hook(2)) = n;
        YData = h_line(1).YData;
        YData(data_gui.hook(2)) = p;
        set(h_line(1),'XData',XData,'YData',YData);
        set(h_line(2),'XData',XData,'YData',YData);
        NCell = size(data_gui.liste_Cell{Z_},1);
        ID_text = [];
        for k_h_text = 1:NCell
            if str2double(h_text(k_h_text).String) == data_gui.hook(2)
                ID_text = k_h_text;
            end
        end
        set(h_text(ID_text),'Position',[n,p]+[4 -10])
        set(h_text(NCell+ID_text),'Position',[n,p]+[4 -10])
        drawnow
        %disp( data_gui.liste_Cell{Z_}{data_gui.hook(2),2})
        %guidata(gcf,data_gui)
    end
end
guidata(data_gui.h_fig,data_gui)
end

function keypressed(src,callbackdata)
touche = callbackdata.Key;
data_gui =  guidata(src);
if data_gui.h_move_all.Value || data_gui.h_move_sel.Value
    %     Z_ = ceil(data_gui.h_Z_slider.Value);
    Z_ = data_gui.Z_loc;
    switch touche
        case 'uparrow'
            var_x = 0;
            var_y = -1;
        case 'downarrow'
            var_x = 0;
            var_y = 1;
        case 'rightarrow'
            var_x = 1;
            var_y = 0;
        case 'leftarrow'
            var_x = -1;
            var_y = 0;
    end
    NCell = size(data_gui.liste_Cell{Z_},1);
    h_text = findobj(data_gui.h_fig,'type','text');
    for k_Cell = 1:length(data_gui.selected_Cell)
        k_Cell_loc = data_gui.selected_Cell(k_Cell);
        index_text = find(str2double({h_text.String})==data_gui.liste_Cell{Z_}{k_Cell_loc,2}(1));
        %     for k_Cell = 1:size(data_gui.liste_Cell{Z_},1)
        data_gui.liste_Cell{Z_}{k_Cell_loc,2}(2:3) = ...
            data_gui.liste_Cell{Z_}{k_Cell_loc,2}(2:3) + [var_x var_y];
        h_text(index_text(1)).Position = h_text(index_text(1)).Position + [var_x var_y 0];
        h_text(index_text(2)).Position =  h_text(index_text(2)).Position + [var_x var_y 0];
        %         h_text(NCell+1-k_Cell_loc).Position = h_text(NCell+1-k_Cell_loc).Position + [var_x var_y 0];
        %         h_text(2*NCell+1-k_Cell_loc).Position = ...
        %             h_text(2*NCell+1-k_Cell_loc).Position + [var_x var_y 0];
        
    end
    h_line = findobj(data_gui.h_fig,'type','line');
    vect_select = zeros(1,NCell);
    vect_select(data_gui.selected_Cell) = 1;
    set(h_line(1),'XData',h_line(1).XData + var_x* vect_select);
    set(h_line(2),'XData',h_line(2).XData + var_x* vect_select);
    set(h_line(1),'YData',h_line(1).YData + var_y* vect_select);
    set(h_line(2),'YData',h_line(2).YData + var_y* vect_select);
    guidata(data_gui.h_fig,data_gui)
else
    %     T_ = ceil(data_gui.h_t_slider.Value);
    T_ = data_gui.t_loc;
    if  strcmp(touche,'rightarrow') && T_ < data_gui.nb_T
        data_gui.h_t_slider.Value = T_+1;
        data_gui.t_loc = T_+1 ;
    elseif strcmp(touche,'leftarrow') && T_ > 1
        data_gui.h_t_slider.Value = T_-1;
        data_gui.t_loc = T_-1 ;
    end
end
end

function refresh_image(data_gui_,h,data,n_max,n_min,val_max)
% if option
%    % data_loc = (data - n_min)/(n_max - n_min)*255;
set(h.Children(end),'CData',data+n_min*val_max)
%colormap(jet(ceil(max(data_loc,[],'all'))))
%image(h,(data - n_min)/(n_max - n_min)*255);
% else
%     set(h.Children(end),'CData',data)
%colormap(jet(ceil(max(data,[],'all'))))
% end
if ~isempty(val_max)
    switch data_gui_.h_colormap_toggle.Value
        case 1
            colormap(h,parula(round(val_max*n_max)));
        case 2
            colormap(h,jet(round(val_max*n_max)));
        case 3
            colormap(h,gray(round(val_max*n_max)));
    end
end
% axis square
axis equal
axis off
end

function refresh_zone(data_gui,Z_)
h_roi = findobj(data_gui.h_fig,'type','images.roi.polygon');
for k_roi = 1:length(h_roi)
    h_roi(k_roi).Visible = 'off';
end
if ~data_gui.h_hide_zone.Value
    for k_roi = 1:length(data_gui.liste_zone{Z_})
        data_gui.liste_zone{Z_}(k_roi).Visible = 'on';
    end
end
end

function refresh_liste_Cell(h,data_Cell)
if ~isempty(data_Cell)
    texte_cell = data_Cell(:,1);
    for k_cell = 1:size(texte_cell,1)
        if  length(data_Cell{k_cell,2}) == 4
            texte_cell{k_cell} = [texte_cell{k_cell},...
                ' (',num2str(data_Cell{k_cell,2}(4)),')'];
        else
            texte_cell{k_cell} = [texte_cell{k_cell},...
                ' ()'];
        end
    end
    %set(h,'string',data_Cell(:,1));
    set(h,'value',1);
    set(h,'string',texte_cell);
    set(h,'max',size(data_Cell,1));
else
    set(h,'string',{})
end
end

function refresh_Cell(h,data_Cell)
delete(findobj(h,'Type','Text'))
delete(findobj(h,'Type','Line'))
if ~isempty(data_Cell)
    data_plot_Cell = cell2mat(data_Cell(:,2));
    is_responder = cell2mat(data_Cell(:,3)) == 1;
    hold on;
    plot(h,data_plot_Cell(:,2),data_plot_Cell(:,3),'ro','markersize',8)
    text(h,data_plot_Cell(is_responder,2)+4,data_plot_Cell(is_responder,3)-10,...
        num2str(data_plot_Cell(is_responder,1)),'color','g','fontsize',6,...
        'HorizontalAlignment','left',...
        'VerticalAlignment','cap','fontweight','normal')
    text(h,data_plot_Cell(~is_responder,2)+4,data_plot_Cell(~is_responder,3)-10,...
        num2str(data_plot_Cell(~is_responder,1)),'color','r','fontsize',6,...
        'HorizontalAlignment','left',...
        'VerticalAlignment','cap','fontweight','normal')
end
end

function refresh_base(data_gui,tag_source)
Z_ = data_gui.Z_loc;
frame_ = data_gui.t_loc;
smooth_type = data_gui.h_smooth_toggle.Value;
std_max_type = data_gui.h_std_max_toggle.Value;
switch tag_source
    case 'Z_slider'
        axes(data_gui.h_image_t);
        refresh_image(data_gui,data_gui.h_image_t,...
            squeeze(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_}(:,:,frame_)),...
            data_gui.h_max_slider_t.Value,data_gui.h_min_slider_t.Value,...
            ceil(max(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_},[],'all')))
        drawnow
        refresh_Cell(data_gui.h_image_t,data_gui.liste_Cell{Z_})
        axes(data_gui.h_std);
        switch std_max_type
            case 1
                refresh_image(data_gui,data_gui.h_std,data_gui.im_std_gaussian{Z_},...
                    data_gui.h_max_slider_std.Value,data_gui.h_min_slider_std.Value,...
                    ceil(max(data_gui.im_std_gaussian{Z_}(:))))
                %colormap(data_gui.h_image_t,jet(ceil(max(data_gui.im_std_gaussian{Z_}(:)))))
            case 2
                refresh_image(data_gui,data_gui.h_std,data_gui.im_max_raw{Z_},...
                    data_gui.h_max_slider_std.Value,data_gui.h_min_slider_std.Value,...
                    ceil(max(data_gui.im_max_raw{Z_}(:))))
                %colormap(data_gui.h_image_t,jet(ceil(max(data_gui.im_max_raw{Z_}(:)))))
        end
        %         switch data_gui.h_colormap_toggle.Value
        %              case 1
        %                  colormap(data_gui.h_std,parula(ceil(max(data_gui.im_max_raw{Z_}(:)))));
        %              case 2
        %                  colormap(data_gui.h_std,jet(ceil(max(data_gui.h_std.Children.CData(:)))));
        %              case 3
        %                 colormap(data_gui.h_std,gray(ceil(max(data_gui.h_std.Children.CData(:)))));
        %          end
        refresh_Cell(data_gui.h_std,data_gui.liste_Cell{Z_})
        refresh_liste_Cell(data_gui.h_liste_Cell,data_gui.liste_Cell{Z_})
        title(data_gui.h_image_t, ['Z = ',num2str(Z_),', t = ',num2str(frame_),' / ',num2str(data_gui.nb_T)]);
        refresh_zone(data_gui,Z_);
    case {'std_max_toggle','max_slider_std','min_slider_std'}
        axes(data_gui.h_std);
        switch std_max_type
            case 1
                refresh_image(data_gui,data_gui.h_std,data_gui.im_std_gaussian{Z_},...
                    data_gui.h_max_slider_std.Value,data_gui.h_min_slider_std.Value,...
                    ceil(max(data_gui.im_std_gaussian{Z_}(:))))
            case 2
                refresh_image(data_gui,data_gui.h_std,data_gui.im_max_raw{Z_},...
                    data_gui.h_max_slider_std.Value,data_gui.h_min_slider_std.Value,...
                    ceil(max(data_gui.im_max_raw{Z_}(:))))
                %             case 3
                %                refresh_image(data_gui,data_gui.h_std,data_gui.im_max_raw{Z_},...
                %                     data_gui.h_max_slider_std.Value,data_gui.h_min_slider_std.Value,...
                %                         ceil(max(data_gui.im_max_raw{Z_}(:))))
        end
        
    case {'frame_slider','smooth_toggle','max_slider_t','min_slider_t','fond'}
        axes(data_gui.h_image_t);
        refresh_image(data_gui,data_gui.h_image_t,...
            squeeze(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_}(:,:,frame_)),...
            data_gui.h_max_slider_t.Value,data_gui.h_min_slider_t.Value,...
            ceil(max(data_gui.(data_gui.type_image{smooth_type,2-data_gui.fond}){Z_},[],'all')))
        
        title(data_gui.h_image_t, ['Z = ',num2str(Z_),', t = ',num2str(frame_),' / ',num2str(data_gui.nb_T)]);
    case {'ajouter','importer','supprimer','check','move_all','renumerote'}
        h_text = findobj(data_gui.h_fig,'type','text');
        delete(h_text);
        h_line = findobj(data_gui.h_fig,'type','line');
        delete(h_line);
        axes(data_gui.h_image_t);
        refresh_Cell(data_gui.h_image_t,data_gui.liste_Cell{Z_})
        axes(data_gui.h_std);
        refresh_Cell(data_gui.h_std,data_gui.liste_Cell{Z_})
        refresh_liste_Cell(data_gui.h_liste_Cell,data_gui.liste_Cell{Z_})
    case 'move'
        if data_gui.hook(1)
            h_text = findobj(data_gui.h_fig,'type','text');
            %h_line = findobj('type','line');
            NCell = size(data_gui.liste_Cell{Z_},1);
            ID_text = [];
            for k_h_text = 1:NCell
                if str2double(h_text(k_h_text).String) == data_gui.hook(2)
                    ID_text = k_h_text;
                end
            end
            disp(h_text(ID_text).String)
            if data_gui.hook(1)
                set(h_text(ID_text),'Color','c','FontWeight','bold','fontsize',9)
                set(h_text(NCell+ID_text),'Color','c','FontWeight','bold','fontsize',9)
                %         else
                %             set(h_text(NCell+1-data_gui.hook(2)),'Color','r','FontWeight','normal','fontsize',6)
                %             set(h_text(2*NCell+1-data_gui.hook(2)),'Color','r','FontWeight','normal','fontsize',6)
            end
        else
            %             h_text = findobj(gcf,'type','text');
            %             delete(h_text);
            %             h_line = findobj(gcf,'type','line');
            %             delete(h_line);
            axes(data_gui.h_image_t);
            refresh_Cell(data_gui.h_image_t,data_gui.liste_Cell{Z_})
            axes(data_gui.h_std);
            refresh_Cell(data_gui.h_std,data_gui.liste_Cell{Z_})
            refresh_liste_Cell(data_gui.h_liste_Cell,data_gui.liste_Cell{Z_})
        end
    case 'move_sel'
        h_text = findobj(data_gui.h_fig,'type','text');
        %h_line = findobj('type','line');
        NCell = size(data_gui.liste_Cell{Z_},1);
        if data_gui.h_move_sel.Value
            for k_Cell = 1:length(data_gui.selected_Cell)
                index_text = find(str2double({h_text.String})==data_gui.liste_Cell{Z_}{data_gui.selected_Cell(k_Cell),2}(1));
                %                 set(h_text(NCell+1-data_gui.selected_Cell(k_Cell)),'Color','g','FontWeight','bold','fontsize',8)
                %                 set(h_text(2*NCell+1-data_gui.selected_Cell(k_Cell)),'Color','g','FontWeight','bold','fontsize',8)
                set(h_text(index_text(1)),'Color','g','FontWeight','bold','fontsize',8)
                set(h_text(index_text(2)),'Color','g','FontWeight','bold','fontsize',8)
            end
        else
            for k_Cell = 1:length(data_gui.selected_Cell)
                index_text = find(str2double({h_text.String})==data_gui.liste_Cell{Z_}{data_gui.selected_Cell(k_Cell),2}(1));
                set(h_text(index_text(1)),'Color','r','FontWeight','normal','fontsize',6)
                set(h_text(index_text(2)),'Color','r','FontWeight','normal','fontsize',6)
                %                 set(h_text(NCell+1-data_gui.selected_Cell(k_Cell)),'Color','r','FontWeight','normal','fontsize',6)
                %                 set(h_text(2*NCell+1-data_gui.selected_Cell(k_Cell)),'Color','r','FontWeight','normal','fontsize',6)
            end
        end
end
end

function [] = refresh(~, eventdata)
hf = eventdata.AffectedObject.Parent;
%disp(eventdata.AffectedObject.Parent.Number)
data_gui =  guidata(hf);
Z_ = ceil(data_gui.h_Z_slider.Value);
t_ = ceil(data_gui.h_t_slider.Value);
if strcmp(eventdata.AffectedObject.Tag,'Z_slider') || strcmp(eventdata.AffectedObject.Tag,'frame_slider')
    if Z_ ~= data_gui.Z_loc || t_ ~= data_gui.t_loc
        data_gui.t_loc = t_;
        data_gui.Z_loc = Z_;
        refresh_base(data_gui,eventdata.AffectedObject.Tag);
    end
else
    refresh_base(data_gui,eventdata.AffectedObject.Tag);
end
guidata(hf,data_gui)
end

function curseur = generate_curseur()
curseur = [...
    NaN,NaN,NaN,NaN,2,2,2,2,2,2,2,2,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    2,2,2,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,2,2,2;...
    2,2,2,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,2,2,2;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    2,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,2;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,NaN,NaN,NaN,2,2,NaN,NaN,NaN,NaN,NaN,NaN,NaN;...
    NaN,NaN,NaN,NaN,2,2,2,2,2,2,2,2,NaN,NaN,NaN,NaN];
end

% function im_out = normalise_image(im_in,max_in)
% if nargin == 1
%     max_val = max(im_in(:));
% else
%     max_val = max_in;
% end
% im_out =  1+ 255 * (im_in-min(im_in(:)))./(max_val-min(im_in(:)));
% end

function im_out = critere_grissant(im_in)
im_tmp = zeros(size(im_in));
for k = 15+1:size(im_in,3)-15
    im_tmp0 = im_in(:,:,k-15:k+15);
    im_tmp(:,:,k) = std(im_tmp0,[],3);
end
im_out =  (max(im_tmp,[],3)-median(im_tmp(:,:,16:end-15),3));
end

function [back,ext] = gui_pop()
% Help goes here.
ext = '.tiff';
back = 1;
S.fh = figure('WindowStyle','normal',...
    'units','pixels',...
    'position',[300 300 400 300],...
    'menubar','none',...
    'name','export menu',...
    'numbertitle','off',...
    'resize','off');
S.file_type = uipanel(S.fh,...
    'Units','Pixels',...
    'Title','File type','FontSize',12,...
    'Position',[230 50 160 200]);
S.back = uicontrol('String','Background?','Fontsize',12,'Value',1,...
    'Style','radiobutton','Position',[15 100 160 20]);
S.filetype = uicontrol('Parent',S.file_type,...
    'Style','listbox','Position',[5 5 120 150],...
    'Value',1,...
    'String',{'.tiff','.png','.jpg','bioformat','MAXPROJ','STD_PROJ','DFF_MAX_PROJ'});
S.pb = uicontrol('style','push',...
    'unit','pix',...
    'position',[10 15 380 20],...
    'fontsize',12,...
    'fontweight','bold',...
    'string','SAVE',...
    'callback',@pb_call);
guidata(S.fh,S)
movegui('center')
uiwait(S.fh)
    function [] = pb_call(varargin)
        back = S.back.Value;
        ext = S.filetype.String{S.filetype.Value};
        close(S.fh)
    end
end
function [mouvement,rotation,shear,sigma_g,taille_m] = gui_pop_filtre()
% Help goes here.
sigma_g = 1.5;
taille_m = 5;
mouvement = 0;
rotation = 0;
shear = 0;

S2.fh = figure('WindowStyle','normal',...
    'units','pixels',...
    'position',[300 300 300 200],...
    'menubar','none',...
    'name','Filter menu',...
    'numbertitle','off',...
    'resize','off');
S2.mouvement = uicontrol('String','Compensate drift?','Fontsize',12,'Value',0,...
    'Style','radiobutton','Position',[15 170 200 20]);
S2.rotation = uicontrol('String','Compensate rotation?','Fontsize',12,'Value',0,...
    'Style','radiobutton','Position',[15 150 200 20]);
S2.shear = uicontrol('String','Compensate shear?','Fontsize',12,'Value',0,...
    'Style','radiobutton','Position',[15 130 200 20]);
S2.sigma_g = uicontrol(...
    'Style','edit','Position',[100 50 50 15],...
    'String',{'1.5'});
uicontrol(...
    'Style','text','Position',[5 50 80 15],...
    'String','Gaussian size');
S2.taille_m = uicontrol(...
    'Style','edit','Position',[100 100 50 15],...
    'String',{'5'});
uicontrol(...
    'Style','text','Position',[5 100 80 15],...
    'String','Median size');
S2.pb = uicontrol('style','push',...
    'unit','pix',...
    'position',[10 15 180 25],...
    'fontsize',12,...
    'fontweight','bold',...
    'string','Proceed',...
    'callback',@pb_call2);
guidata(S2.fh,S2)
movegui('center')
uiwait(S2.fh)
    function [] = pb_call2(varargin)
        mouvement = S2.mouvement.Value;
        rotation = S2.rotation.Value;
        shear = S2.shear.Value;
        sigma_g = str2double(S2.sigma_g.String);
        taille_m = str2double(S2.taille_m.String);
        
        close(S2.fh)
    end
end
function [reponse,echelle] = echelle_pop()
% Help goes here.
reponse = 0;
echelle = 1;
S3.fh = figure('WindowStyle','normal',...
    'units','pixels',...
    'position',[300 300 300 200],...
    'menubar','none',...
    'name','export menu',...
    'numbertitle','off',...
    'resize','off');
S3.reponse = uicontrol('String','Echelle auto ?','Fontsize',12,'Value',1,...
    'Style','radiobutton','Position',[15 150 150 20]);
uicontrol(...
    'Style','text','Position',[5 80 100 30],...
    'Fontsize',12,'String','Echelle max : ');
S3.echelle = uicontrol(...
    'Style','edit','Position',[110 80 50 30],...
    'Fontsize',12,'String',{'5'});
S3.pb = uicontrol('style','push',...
    'unit','pix',...
    'position',[10 15 80 20],...
    'fontsize',12,...
    'fontweight','bold',...
    'string','OK',...
    'callback',@pb_call);
guidata(S3.fh,S3)
movegui('center')
uiwait(S3.fh)
    function [] = pb_call(varargin)
        reponse = S3.reponse.Value;
        echelle = S3.echelle.String{1};
        close(S3.fh)
    end
end