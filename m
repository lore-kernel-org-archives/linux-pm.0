From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH RFC 01/12] Documentation: Introduce Linux Kernel Thermal
 Framework DocBook
Date: Wed, 18 Feb 2015 11:13:08 +0000
Message-ID: <20150218111308.GC2990@e104805>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
 <1423517653-11359-2-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:43926 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbBRLNU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 06:13:20 -0500
Content-Disposition: inline
In-Reply-To: <1423517653-11359-2-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>, "hongbo.zhang@linaro.com" <hongbo.zhang@linaro.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "peter@piie.net" <peter@piie.net>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "aaron.lu@intel.com" <aaron.lu@intel.com>, "caesar.wang@rock-chips.com" <caesar.wang@rock-chips.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "vincenzo.frascino@st.com" <vincenzo.frascino@st.com>, "mperttunen@nvidia.com" <mperttunen@nvidia.com>, "mikko.perttunen@kapsi.fi" <mikko.perttunen@kapsi.fi>, srinivas.pandruvada@lin

On Mon, Feb 09, 2015 at 09:34:02PM +0000, Eduardo Valentin wrote:
> This patch adds a book about the Linux Kernel Thermal Framework.
> In this change, only a brief introduction is added together with
> Makefile changes.
> 
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  Documentation/DocBook/Makefile     |  3 +-
>  Documentation/DocBook/thermal.tmpl | 88 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/DocBook/thermal.tmpl
> 
> diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
> index 9c7d92d..8163508 100644
> --- a/Documentation/DocBook/Makefile
> +++ b/Documentation/DocBook/Makefile
> @@ -15,7 +15,8 @@ DOCBOOKS := z8530book.xml device-drivers.xml \
>  	    80211.xml debugobjects.xml sh.xml regulator.xml \
>  	    alsa-driver-api.xml writing-an-alsa-driver.xml \
>  	    tracepoint.xml drm.xml media_api.xml w1.xml \
> -	    writing_musb_glue_layer.xml crypto-API.xml
> +	    writing_musb_glue_layer.xml crypto-API.xml thermal.xml
> +	    writing_musb_glue_layer.xml

Duplicated writing_musb_glue_layer.xml ?  Looks like the second line
should be removed.

>  
>  include Documentation/DocBook/media/Makefile
>  
> diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook/thermal.tmpl
> new file mode 100644
> index 0000000..f8fb8a2
> --- /dev/null
> +++ b/Documentation/DocBook/thermal.tmpl
> @@ -0,0 +1,88 @@
> +<?xml version="1.0" encoding="UTF-8"?>
> +<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
> +	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
> +
> +<book id="thermal-api">
> + <bookinfo>
> +  <title>Linux Kernel Thermal Framework API</title>
> +
> +  <authorgroup>
> +   <author>
> +    <firstname>Eduardo</firstname>
> +    <surname>Valentin</surname>
> +    <affiliation>
> +     <address>
> +      <email>evalenti@kernel.org</email>
> +     </address>
> +    </affiliation>
> +   </author>
> +  </authorgroup>
> +
> +  <copyright>
> +   <year>2008-2014</year>
> +   <holder>Eduardo Valentin</holder>
> +   <holder>Sujith Thomas</holder>
> +   <holder>Zhang Rui</holder>
> +  </copyright>
> +  <legalnotice>
> +   <para>
> +     This documentation is free software; you can redistribute
> +     it and/or modify it under the terms of the GNU General Public
> +     License version 2 as published by the Free Software Foundation.
> +   </para>
> +
> +   <para>
> +     This program is distributed in the hope that it will be
> +     useful, but WITHOUT ANY WARRANTY; without even the implied
> +     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +     See the GNU General Public License for more details.
> +   </para>
> +
> +   <para>
> +     For more details see the file COPYING in the source
> +     distribution of Linux.
> +   </para>
> +  </legalnotice>
> + </bookinfo>
> +
> +<toc></toc>
> +
> +	<chapter id="introduction">
> +		<title>Introduction</title>
> +		<para>Thermal management is any method or technique implied to
> +		mitigate emergencies caused by operating devices within
> +		unsupported temperatures. The challenge consists of designing a
> +		product keeping the junction temperature of the IC components.
> +		The operating temperature of IC components used on products must
> +		operate within their design limits. Besides, temperature towards
> +		device enclosure must be in a comfort level for the user.
> +		Therefore, thermal management, by the time of this writing,
> +		starts in very early device design phase. Managing thermal may
> +		involve different disciplines, at different stages, such as
> +		temperature monitoring, floorplanning, microarchitectural
> +		techniques, compiler techniques, OS techniques, liquid cooling,
> +		and thermal reliability or security. This document covers what
> +		the Linux Kernel Thermal Framework provides as abstraction to
> +		users with respect to thermal management.  
> +		</para>
> +		<para>One of the first proposals to provide a solution to cover
> +		the thermal problem appears in the Advanced Configuration and
> +		Power Interface (ACPI) specification. ACPI provides an open
> +		standard for device configuration and power management by the
> +		operating system. However, several computing devices which may
> +		have thermal issues in the market disregard the ACPI standard.
> +		Therefore, the Linux Kernel Thermal Framework has been designed
> +		to serve as abstraction for ACPI and non-ACPI systems. The core
> +		concepts applies in both types of systems. 
> +		</para>
> +		<para>The Linux Kernel Thermal Framework has a design which
> +		represents the different thermal constraints found in an
> +		end-products. The thermal constraints exist to serve different
> +		purposes. There two major types of thermal constraints. The
                                are

> +		first is related to components junction temperature. The second
> +		is related to the level of comfort while end users are handling
> +		devices.
> +		</para>
> +
> +  </chapter>
> +</book>

Cheers,
Javi
