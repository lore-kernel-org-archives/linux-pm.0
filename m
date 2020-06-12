Return-Path: <SRS0=T5KG=7Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3397C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 12 Jun 2020 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15C120791
	for <linux-pm@archiver.kernel.org>; Fri, 12 Jun 2020 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591999256;
	bh=6LBKHs+VNKPb4CJw/dS5f7p5NZnEEacy0r1tl784jxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q1g3OseNy1+LwffoQB/X29jRG/+d3tTqrSWZ0SZcdWL3wq+XbmpsO3N1aGArxvll4
	 3zhCBH72Isi+2Fr9LyaP1rDcRETERyKzpaHdc01wp8PWQ4llSR8y+DKmuUD3m+ONuX
	 +Vatuiyk1dupj9iHBv0Up7ixMEhQaDO1ZoJFrzK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLWA4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:00:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37913 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 18:00:55 -0400
Received: by mail-io1-f67.google.com with SMTP id w18so11843638iom.5;
        Fri, 12 Jun 2020 15:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MVYilwkoefHudKenRN/nVcNY1QPjAdZCE41bLbrB/E8=;
        b=Q7zZ/Qj+lT4twpEafHCl+fb7fnUIW7kXG3s5NAzHkkfZwV/Tb9b8LkeTVVP30xXyVB
         GcBActCJHuFKbc5uVWKj2YBmb25AnfbKRDyUALw/r/yN7C7BYN4vzR+tOP21TVRf/L+1
         G7Dk5IL7S1f8nAtnElmfwzO8MRT/AN4/SJInC38cHta9JbHxHOB1VEDieWKwwpPYSmb/
         R5HZysXf2Sfd+KqozYd1EvVJpZLjrEVQEp/K9aaymiFNU2Qt/wLBYKxnGSPZl7FihQPK
         lfXiqqKvZ1+QVDn/isvU8Z0dPzO8H+JKDugB2pR9ZsJLMMFYwYYYNVi7/dYDkxqgpusI
         Q3uQ==
X-Gm-Message-State: AOAM530zTYLSahkXmOTj4gq/5h7JtRy8pZWt7iaVpbNESXlCiE28gz4k
        Z1UeUK4P5cO5hBKSAme4Lw==
X-Google-Smtp-Source: ABdhPJwhdWnMCgLiUaas7wxRI8FCl4P0N2r3gJ1XXsTJkeWy2DeQWF7AcCrsuc3oaevbdMP3G5NWUg==
X-Received: by 2002:a05:6638:5b9:: with SMTP id b25mr9644346jar.68.1591999253627;
        Fri, 12 Jun 2020 15:00:53 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m5sm3592589ioj.52.2020.06.12.15.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 15:00:52 -0700 (PDT)
Received: (nullmailer pid 3889698 invoked by uid 1000);
        Fri, 12 Jun 2020 22:00:51 -0000
Date:   Fri, 12 Jun 2020 16:00:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2 v2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
Message-ID: <20200612220051.GA3888887@bogus>
References: <2886932.VqVLtP53aq@tool>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2886932.VqVLtP53aq@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 11 Jun 2020 22:29:22 +0200, Daniel González Cabanelas wrote:
> Add Linkstation poweroff bindings documentation.
> 
> Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
> ---
> Changes in v2:
>   - Changed the required properties and description to adjust to the new
>     driver now enabling the WoL feature on the device.
> 
>  .../power/reset/linkstation-poweroff.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.example.dt.yaml: poweroff: 'phy-handle,intn' does not match any of the regexes: '^#.*', '^(at25|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio|gpmc|hdmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(pinctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*', '^GEFanuc,.*', '^ORCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$', '^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abilis,.*', '^abracon,.*', '^acme,.*', '^actions,.*', '^active-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh,.*', '^adi,.*', '^advantech,.*', '^aeroflexgaisler,.*', '^al,.*', '^allegro,.*', '^allo,.*', '^allwinner,.*', '^alphascale,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampire,.*', '^
 ams,.*', '^amstaos,.*', '^analogix,.*', '^andestech,.*', '^anvo,.*', '^apm,.*', '^aptina,.*', '^arasan,.*', '^archermind,.*', '^arctic,.*', '^arcx,.*', '^aries,.*', '^arm,.*', '^armadeus,.*', '^arrow,.*', '^artesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^aspeed,.*', '^asus,.*', '^atlas,.*', '^atmel,.*', '^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^bananapi,.*', '^beacon,.*', '^bhf,.*', '^bitmain,.*', '^boe,.*', '^bosch,.*', '^boundary,.*', '^brcm,.*', '^broadmobi,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^calaosystems,.*', '^calxeda,.*', '^capella,.*', '^cascoda,.*', '^catalyst,.*', '^cavium,.*', '^cdns,.*', '^cdtech,.*', '^ceva,.*', '^chipidea,.*', '^chipone,.*', '^chipspark,.*', '^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cloudengines,.*', '^cnm,.*', '^cnxt,.*', '^colorfly,.*', '^compulab,.*', '^coreriver,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^cre
 ative,.*', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^cubietech,.*', '^cypress,.*', '^cznic,.*', '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', '^denx,.*', '^devantech,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digilent,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*', '^dragino,.*', '^dserve,.*', '^dynaimage,.*', '^ea,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', '^edt,.*', '^eeti,.*', '^einfochips,.*', '^elan,.*', '^elgin,.*', '^elida,.*', '^embest,.*', '^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ettus,.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^exar,.*', '^excito,.*', '^ezchip,.*', '^facebook,.*', '^fairphone,.*', '^faraday,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^feiyang,.*', '^firefly,.*', '^focaltech,.*', '
 ^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^fujitsu,.*', '^gardena,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^gef,.*', '^gemei,.*', '^geniatech,.*', '^giantec,.*', '^giantplus,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*', '^goodix,.*', '^google,.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^haoyu,.*', '^hardkernel,.*', '^hideep,.*', '^himax,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*', '^holt,.*', '^holtek,.*', '^honeywell,.*', '^hoperun,.*', '^hp,.*', '^hsg,.*', '^hugsun,.*', '^hwacom,.*', '^hydis,.*', '^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^ifi,.*', '^ilitek,.*', '^img,.*', '^incircuit,.*', '^inet-tek,.*', '^infineon,.*', '^inforce,.*', '^ingenic,.*', '^innolux,.*', '^inside-secure,.*', '^inspur,.*', '^intel,.*', '^intercontrol,.*', '^invensense,.*', '^inversepath,.*', '^iom,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*', '^itead,.*', '^iwave,.*', '^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jianda,.*', '
 ^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*', '^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^koe,.*', '^kontron,.*', '^kosagi,.*', '^kyo,.*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', '^lenovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^linaro,.*', '^linksprite,.*', '^linksys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '^loongson,.*', '^lsi,.*', '^lwn,.*', '^macnica,.*', '^mapleboard,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^mellanox,.*', '^memsic,.*', '^menlo,.*', '^merrii,.*', '^micrel,.*', '^microchip,.*', '^microcrystal,.*', '^micron,.*', '^microsoft,.*', '^mikroe,.*', '^miniand,.*', '^minix,.*', '^miramems,
 .*', '^mitsubishi,.*', '^mosaixtech,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl,.*', '^mscc,.*', '^msi,.*', '^mti,.*', '^multi-inno,.*', '^mundoreader,.*', '^murata,.*', '^mxicy,.*', '^myir,.*', '^national,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlogic,.*', '^netron-dy,.*', '^netxeon,.*', '^neweast,.*', '^newhaven,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^nintendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novtech,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*', '^nxp,.*', '^oceanic,.*', '^okaya,.*', '^oki,.*', '^olimex,.*', '^olpc,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.*', '^opencores,.*', '^openrisc,.*', '^option,.*', '^oranth,.*', '^orisetech,.*', '^ortustech,.*', '^osddisplays,.*', '^overkiz,.*', '^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*'
 , '^pixcir,.*', '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^pni,.*', '^pocketbook,.*', '^polaroid,.*', '^portwell,.*', '^poslab,.*', '^pov,.*', '^powervr,.*', '^primux,.*', '^probox2,.*', '^pulsedlight,.*', '^purism,.*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua,.*', '^qnap,.*', '^radxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^renesas,.*', '^rervision,.*', '^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riscv,.*', '^rockchip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^seagate,.*', '^seirobotics,.*', '^semtech,.*', '^sensirion,.*', '^sensortek,.*', '^sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shimafuji,.*', '^si-en,.*', '^si-linux,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.*', '^silead,.*', '^silergy,.*', '^siliconmit
 us,.*', '^simtek,.*', '^sinlinx,.*', '^sinovoip,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skyworks,.*', '^smsc,.*', '^snps,.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony,.*', '^spansion,.*', '^sprd,.*', '^sst,.*', '^st,.*', '^st-ericsson,.*', '^starry,.*', '^startek,.*', '^ste,.*', '^stericsson,.*', '^summit,.*', '^sunchip,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^technexion,.*', '^technologic,.*', '^techstar,.*', '^tempo,.*', '^terasic,.*', '^tfc,.*', '^thine,.*', '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^toumaz,.*', '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^tyan,.*', '^u-blox,.*', '^ubnt,.*', '^ucrobotics,.*', '^udoo,.*', '^ugoos,.*', '^uniwest,.*', '^upisemi,.*', '^urt,.*', '^usi,.*', '^utoo,.*', '^v3,.*', '^vamrs,.*', '^variscite,.*', '^
 via,.*', '^videostrong,.*', '^virtio,.*', '^vishay,.*', '^vitesse,.*', '^vivante,.*', '^vocore,.*', '^voipac,.*', '^vot,.*', '^vxt,.*', '^waveshare,.*', '^wd,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi,.*', '^winbond,.*', '^winstar,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*', '^x-powers,.*', '^xes,.*', '^xiaomi,.*', '^xillybus,.*', '^xinpeng,.*', '^xlnx,.*', '^xunlong,.*', '^xylon,.*', '^yna,.*', '^yones-toptech,.*', '^ysoft,.*', '^zarlink,.*', '^zeitec,.*', '^zidoo,.*', '^zii,.*', '^zte,.*', '^zyxel,.*'


See https://patchwork.ozlabs.org/patch/1307790

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

