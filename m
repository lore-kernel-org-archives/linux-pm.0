From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 14:13:29 -0300
Message-ID: <CAOMZO5Cry5WNnMZ+WYRJNt0i8WHBXViZwijWHaYeJ=GACaWcLA@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
	<CAOMZO5DjgXuYiuOrUdbap3x2PVyUXbp2V1VGnU=2THRSM8Hfow@mail.gmail.com>
	<CAJZ5v0i3h9Jepcxq5xZd1juCWxgOhT1-NBhV9zUXGz4A_j=XeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37937 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbcEWRNb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 13:13:31 -0400
Received: by mail-ig0-f175.google.com with SMTP id fh2so26418287igd.1
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 10:13:30 -0700 (PDT)
In-Reply-To: <CAJZ5v0i3h9Jepcxq5xZd1juCWxgOhT1-NBhV9zUXGz4A_j=XeA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Fri, May 20, 2016 at 10:31 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:

> The patch is just a workaround for a problem in the arch code showing
> up on your platform, though.

Not sure where the problem in the arch code is located though.

Ping, Shawn, Sascha, any ideas?

Thanks
