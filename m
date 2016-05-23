From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 19:25:28 -0300
Message-ID: <CAOMZO5D8-GF-0MDExM=2si1yNcqwO07pNWUkjRz0uuzkdYka_Q@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<20160523182807.GY19428@n2100.arm.linux.org.uk>
	<CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
	<CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
	<CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
	<20160523210738.GZ19428@n2100.arm.linux.org.uk>
	<CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
	<20160523220514.GB19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36290 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbcEWWZ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 18:25:29 -0400
Received: by mail-io0-f170.google.com with SMTP id f8so1318337ioe.3
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 15:25:29 -0700 (PDT)
In-Reply-To: <20160523220514.GB19428@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 7:05 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> I don't think so, unless you specifically turn off CONFIG_SMP_ON_UP.
> It defaults to 'y', so imx_v6_v7_defconfig should result in this being
> 'y'.

Sorry, you are right: option 3 (CONFIG_SMP=y and CONFIG_SMP_ON_UP=y)
is the default one with imx_v6_v7_defconfig.
