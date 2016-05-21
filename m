From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Sat, 21 May 2016 03:31:59 +0200
Message-ID: <CAJZ5v0i3h9Jepcxq5xZd1juCWxgOhT1-NBhV9zUXGz4A_j=XeA@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
	<CAOMZO5DjgXuYiuOrUdbap3x2PVyUXbp2V1VGnU=2THRSM8Hfow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37597 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbcEUBcC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 21:32:02 -0400
Received: by mail-wm0-f46.google.com with SMTP id v200so5149774wmv.0
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 18:32:00 -0700 (PDT)
In-Reply-To: <CAOMZO5DjgXuYiuOrUdbap3x2PVyUXbp2V1VGnU=2THRSM8Hfow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Sat, May 21, 2016 at 3:22 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, May 20, 2016 at 10:19 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Running a 4.6 kernel with this patch applied allows me to reboot the
>> system, thanks.
>>
>> 'echo performance >
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor' works fine now.
>
> and as a bonus point suspend/resume works fine now too :-)

OK, thanks for the confirmation!

The patch is just a workaround for a problem in the arch code showing
up on your platform, though.
