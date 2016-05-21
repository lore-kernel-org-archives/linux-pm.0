From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 22:22:19 -0300
Message-ID: <CAOMZO5DjgXuYiuOrUdbap3x2PVyUXbp2V1VGnU=2THRSM8Hfow@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35498 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbcEUBWU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 21:22:20 -0400
Received: by mail-io0-f174.google.com with SMTP id p64so71133069ioi.2
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 18:22:20 -0700 (PDT)
In-Reply-To: <CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Fri, May 20, 2016 at 10:19 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Running a 4.6 kernel with this patch applied allows me to reboot the
> system, thanks.
>
> 'echo performance >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor' works fine now.

and as a bonus point suspend/resume works fine now too :-)
