From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 08/17] thermal: exynos: dts: Add default definition of
 the TMU sensor parameter
Date: Mon, 12 Jan 2015 15:42:28 +0100
Message-ID: <20150112154228.733b851f@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-9-git-send-email-l.majewski@samsung.com>
 <20150102181139.GA12130@developer> <20150102182625.GB12310@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31057 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbALOnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 09:43:24 -0500
In-reply-to: <20150102182625.GB12310@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo,

> On Fri, Jan 02, 2015 at 02:11:41PM -0400, Eduardo Valentin wrote:
> > Lukasz,
> > 
> > On Wed, Dec 10, 2014 at 01:09:47PM +0100, Lukasz Majewski wrote:
> > > Exynos 4 and 5 family of SoCs uses almost identical TMU sensor to
> > > measure the on chip temperature. For this reason it is possible
> > > to group TMU configuration parameters in one dts file.
> > > 
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > ---
> > > Changes for v2:
> > > - None
> > > ---
> > >  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 24
> > > +++++++++++++++++++++++ 1 file changed, 24 insertions(+)
> > >  create mode 100644
> > > arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> > > b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi new file mode
> > > 100644 index 0000000..ee6d8bb
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> > > @@ -0,0 +1,24 @@
> > > +/*
> > > + * Device tree sources for Exynos4412 TMU sensor configuration
> > > + *
> > > + * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > modify
> > > + * it under the terms of the GNU General Public License version
> > > 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + */
> > > +
> > > +#include <dt-bindings/thermal/thermal_exynos.h>
> > > +
> > > +#thermal-sensor-cells = <0>;
> > > +gain = <8>;
> > > +reference_voltage = <16>;
> > > +noise_cancel_mode = <4>;
> > > +efuse_value = <55>;
> > > +min_efuse_value = <40>;
> > > +max_efuse_value = <100>;
> > > +first_point_trim = <25>;
> > > +second_point_trim = <85>;
> > > +default_temp_offset = <50>;
> > > +cal_type = <TYPE_ONE_POINT_TRIMMING>;
> > 
> > Are the above properties specific to exynos? 

Yes, they are specific for Exynos.

> > For specific DT
> > entries, they need to be marked with a prefix. Please read the
> > 'Device Specific Data' section of Device tree Documentation [1].

Ok, I will. Thanks for tip.

> > 
> > [1] - http://devicetree.org/Device_Tree_Usage
> 
> 
> BTW, you have to update:
> Documentation/devicetree/bindings/thermal/exynos-thermal.txt

I've forgotten to update this entry. Will be fixed at v3.

> 
> 
> > > -- 
> > > 2.0.0.rc2
> > > 
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
