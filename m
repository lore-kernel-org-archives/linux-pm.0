From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 18:37:38 -0300
Message-ID: <CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
	<4080948.V5DMHR9bsk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34150 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcETVhj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 17:37:39 -0400
Received: by mail-io0-f182.google.com with SMTP id 190so160040979iow.1
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 14:37:38 -0700 (PDT)
In-Reply-To: <4080948.V5DMHR9bsk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

On Fri, May 20, 2016 at 6:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> If I rebuilt a kernel with SMP=n then the reboot command works as expected.
>
> Does it work if you boot with maxcpus=1 or nosmp in the kernel command line?

No, it does not help.

> Also, please try if the appended patch makes any difference.

I tried it, and the console shows "Requesting system reboot" and stays
there forever. No more messages after that and the system does not
reboot.
