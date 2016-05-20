From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 18:55:24 -0300
Message-ID: <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
	<4080948.V5DMHR9bsk@vostro.rjw.lan>
	<CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
	<CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33388 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcETVzZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 17:55:25 -0400
Received: by mail-io0-f176.google.com with SMTP id t40so68148101ioi.0
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 14:55:25 -0700 (PDT)
In-Reply-To: <CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, May 20, 2016 at 6:48 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:

> So what about if you comment out the cpufreq_suspend() line in
> device_shutdown() (after applying the patch)?

Then it reboots fine :-) Thanks
