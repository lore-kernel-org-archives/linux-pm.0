From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 18:38:31 -0300
Message-ID: <CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<20160523182807.GY19428@n2100.arm.linux.org.uk>
	<CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
	<CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
	<CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
	<20160523210738.GZ19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37796 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbcEWVic (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:38:32 -0400
Received: by mail-it0-f48.google.com with SMTP id z123so681602itg.0
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 14:38:32 -0700 (PDT)
In-Reply-To: <20160523210738.GZ19428@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 6:07 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Read the code again.  There's three states:
>
> 1. CONFIG_SMP=n - it always returns false.
> 2. CONFIG_SMP=y, CONFIG_SMP_ON_UP=n - it always returns true.  Such a
>    kernel can _only_ be run on SMP capable systems.
> 3. CONFIG_SMP=y, CONFIG_SMP_ON_UP=y - it returns depending on whether
>    we detect that the CPU is SMP capable.

Yes, I meant that on imx6ul we have option 2 above with imx_v6_v7_defconfig.

Also tested option 3 and is_smp() returns true as well.

I will try to see why GIC on this SoC cannot work in SMP.
