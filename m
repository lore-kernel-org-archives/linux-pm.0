From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RFC 01/12] Documentation: Introduce Linux Kernel Thermal
 Framework DocBook
Date: Tue, 10 Feb 2015 14:50:36 -0800
Message-ID: <54DA8B3C.9040607@infradead.org>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com> <1423517653-11359-2-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33867 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbbBJWu5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Feb 2015 17:50:57 -0500
In-Reply-To: <1423517653-11359-2-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On 02/09/15 13:34, Eduardo Valentin wrote:

> +	<chapter id="introduction">
> +		<title>Introduction</title>
> +		<para>Thermal management is any method or technique implied to
> +		mitigate emergencies caused by operating devices within
> +		unsupported temperatures. The challenge consists of designing a

I would flip the ending of that sentence:
		                     caused by operating devices outside of
		supported temperatures.

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

drop:		                                                      an^^

> +		end-products. The thermal constraints exist to serve different
> +		purposes. There two major types of thermal constraints. The

		          There are two

> +		first is related to components junction temperature. The second
> +		is related to the level of comfort while end users are handling
> +		devices.
> +		</para>
> +
> +  </chapter>
> +</book>
> 


-- 
~Randy
