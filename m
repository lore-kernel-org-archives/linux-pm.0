From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 5/7] cpufreq: Calculate number of busy CPUs
Date: Thu, 27 Jun 2013 16:46:44 +0530
Message-ID: <CAKohpo=JKg17YWjTrOh25hHW=sXn8-TW=D8rhrovonwZBDarBg@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-6-git-send-email-l.majewski@samsung.com>
	<CAKohpo=EwapTp8epok30=_ZYLPeCR8_LhpBF5H724dE=+SwMLg@mail.gmail.com>
	<20130627125819.5c90da30@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47303 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3F0LQp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 07:16:45 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so588068obc.27
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2013 04:16:45 -0700 (PDT)
In-Reply-To: <20130627125819.5c90da30@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocky" <rjw@sisk.pl>, Lukasz Majewski <l.majewski@samsung.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

@Rafael: We need you to jump into this discussion now, I don't
have a good idea about what we should do :)

On 27 June 2013 16:28, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Do you have any idea of how to precisely set the load threshold?

I thought we are talking about cpu being in idle state.

> As a side note:
>
> I've thought about this patch for some time and for me it looks like we
> are mixing policy (number of busy CPUs) with abilities, which shall be
> provided by the driver (boost).
> Additionally, we can only roughly "estimate" [*] when boost shall run
> and when it shall be turned off.

This is another problem in the patch you sent. User would simply
enable or disable boost feature from userspace only once.

Now, if you disable it at high temperatures then its responsibility
to enable it again. Which you are missing.

> I think that, we shall leave this management [*] to the thermal
> framework. This framework is designed exactly to protect from over
> heating (it uses the same freq_table for passive CPU cooling) with
> several trip points -> e.g. 40 deg (disable boost), 75 deg (impose max
> freq as 1.0 GHz to cool down, 90 deg (shutdown immediately).
> Please refer to PATH v4 7/7.

There might be platforms where overheating isn't a issue with boost,
if it is only enabled while only one cpu is in use.

> Unfortunately, since we dropped Kconfig flag for BOOST we cannot
> impose "select THERMAL_FRAMEWORK", when flag for BOOST is enabled at
> Kconfig.

Not a big deal, we can get that in if required.

> Ideally kernel shall not even build when CONFIG_CPUFREQ_BOOST Kconfig
> flag is set and thermal for target architecture is not correctly
> configured (including proper trip points).
