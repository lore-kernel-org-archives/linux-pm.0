From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Mon, 17 Nov 2014 13:51:42 +0100
Message-ID: <20141117135142.6692c9d5@amdc2363>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
 <5465DDC5.6090301@kapsi.fi> <20141114122437.6742ea68@amdc2363>
 <20141117115743.GG25699@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58008 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbaKQMwG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Nov 2014 07:52:06 -0500
In-reply-to: <20141117115743.GG25699@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thierry,

> On Fri, Nov 14, 2014 at 12:24:37PM +0100, Lukasz Majewski wrote:
> > Hi Mikko,
> > 
> > > Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> > 
> > Thanks for testing.
> > 
> > > 
> > > One potential issue I can see is that if the cpufreq driver fails
> > > to probe then you'll never get the thermal driver either. For
> > > example, Tegra124 currently has no cpufreq driver, so if
> > > CONFIG_CPU_THERMAL was enabled, then the soctherm driver would
> > > never be able to probe.
> > 
> > Yes, this is a potential issue. However, this option in
> > tegra_defconfig is by default disabled when thermal is enabled.
> 
> Not everybody uses tegra_defconfig for their kernel builds. In fact
> I'd imagine that the majority of kernels use a variant of
> multi_v7_defconfig and therefore CPU_THERMAL might get enabled
> irrespective of any Tegra support.

I see your point. 

> 
> I think a better solution would be to add this check only when proper
> support for CPU frequency based cooling is added. That is, when a call
> to cpufreq_cooling_register() (or a variant thereof) is added.

For the above reason the code is only compiled in when user enable
CONFIG_CPU_THERMAL.

> 
> But while at it, why not make it so that cpufreq_cooling_register()
> detects if a cpufreq driver has been registered yet and propagate
> -EPROBE_DEFER if necessary?

cpufreq_cooling_register() may be a good place to add check for
deferred probe.

The problem with cpufreq_cooling_register() is that it may be called
late in the probe function (as it is done now in Exynos).


> 
> Thierry



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
