From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Register the driver with reboot notifier
Date: Thu, 21 Aug 2014 11:56:52 +0530
Message-ID: <CAKohpon8ANWoy52B=_nSuNyHALrsQOLX4cA+690E=CifnVRFtg@mail.gmail.com>
References: <1408015178-21745-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<CAKohponDNHYrD9b==cp+pVmAi2ygA9-HcLZWqr4w3DDivB=-Ng@mail.gmail.com>
	<53F57E51.4060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51011 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbaHUG0w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Aug 2014 02:26:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so7217725oag.33
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2014 23:26:52 -0700 (PDT)
In-Reply-To: <53F57E51.4060200@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpabhatppc@gmail.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21 August 2014 10:36, Shilpasri G Bhat <shilpabhatppc@gmail.com> wrote:
> The intention here is stop the cpufreq governor and then to set the cpus to
> nominal frequency so as to ensure that the frequency won't be changed later.
>
> The .suspend callback of the driver is not called during reboot/kexec.
> So we need an explicit reboot notifier to call cpufreq-suspend() to
> suffice the requirement.

Hi Shilpa,

No, we can't allow any platform driver to misuse cpufreq_suspend().
Platform drivers aren't *allowed* to call this routine.

Now the deal is how do we move to nominal frequency on reboot..
@Rafael: Any suggestions? How do we ensure that governors
are stopped on these notifiers, or if there is some other solution here?
