From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
Date: Wed, 17 Dec 2014 10:28:47 -0800
Message-ID: <7hvbla9lls.fsf@deeprootsystems.com>
References: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
	<2757282.fj6z18fAYb@vostro.rjw.lan>
	<7h1to0iw76.fsf@deeprootsystems.com>
	<CAGo_u6oO+Tou2XSVr3dxn94hV0HTdYMZWz-XKK_aydwusaRBvg@mail.gmail.com>
	<CAKohpomS1PAO1zyQJ9bkK6eYo4vM-GMTrYwDnPcFfpvB3a+b2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64916 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaLQS2u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 13:28:50 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so16701180pde.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 10:28:50 -0800 (PST)
In-Reply-To: <CAKohpomS1PAO1zyQJ9bkK6eYo4vM-GMTrYwDnPcFfpvB3a+b2g@mail.gmail.com>
	(Viresh Kumar's message of "Wed, 17 Dec 2014 21:58:26 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "arm@kernel.org" <arm@kernel.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@linaro.org>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 17 December 2014 at 21:31, Nishanth Menon <nm@ti.com> wrote:
>> Any chance of the following being queued for the .19 window or do we
>> wait to go through Tony?
>> https://patchwork.kernel.org/patch/5484401/
>
> I think I have seen that as part of Arnd pull request sent today to Linus.
>
> https://lkml.org/lkml/2014/12/16/439

Right, this was initially planned for v3.19-rc, but since we were
sending another round of pull requests, arm-soc/fixes was included.

Kevin
