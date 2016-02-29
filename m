From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on device tree
Date: Mon, 29 Feb 2016 15:39:37 +0100
Message-ID: <2383054.EjbA6kk0Xz@wuerfel>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com> <8056913.EWiGLtcdOV@wuerfel> <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57909 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcB2OkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 09:40:01 -0500
In-Reply-To: <CAJZ5v0joCpaPNxPzW2xpJ5Vt4MYgWdCvXE0PZb90S46pFhJH8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Li Yang <leoli@freescale.com>, Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jia Hongtao <hongtao.jia@freescale.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday 29 February 2016 15:33:37 Rafael J. Wysocki wrote:
> >
> > Note the check on !CPU_THERMAL rather than !THERMAL in my patch, that
> > part was correct. I think the line should be
> >
> >         depends on !CPU_THERMAL || THERMAL
> >
> > as some other drivers do. I must have copied the line
> > from ARM_MT8173_CPUFREQ, which is a 'bool' symbol, when
> > it should have been the same as ARM_BIG_LITTLE_CPUFREQ and
> > CPUFREQ_DT.
> 
> OK, so any chance to update the patch?
> 

I've committed the update locally now, and will follow up tomorrow
with a new patch, unless it causes another build-time regression.

I'll also send the respective update for the mediatek driver, making
that a tristate option.

	Arnd
