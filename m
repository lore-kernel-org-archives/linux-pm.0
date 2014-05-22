From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5] PM/OPP: discard duplicate OPPs
Date: Thu, 22 May 2014 09:35:52 +0530
Message-ID: <CAKohpokovwiU2DF=BJQsfZR3E_c-w9t5yV1HE-Ji88QziTWnUA@mail.gmail.com>
References: <7cb6e0e039e0935e37c81d0f23d26b0b81ad8cda.1400597170.git.viresh.kumar@linaro.org>
	<1555967.8fxByr2j83@vostro.rjw.lan>
	<CAKohponU2feK9+9sUn4tu0t4fhwSy6PZuaAO3zkF7qRejCwM1Q@mail.gmail.com>
	<5258228.rMTDJps2Fm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:55809 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEVEFx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 00:05:53 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so3380788oag.6
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 21:05:52 -0700 (PDT)
In-Reply-To: <5258228.rMTDJps2Fm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Chander Kashyap <k.chander@samsung.com>

On 22 May 2014 05:18, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> The case in which we want to return 0.  Never mind, it's OK.

Ahh yes, It was wrong earlier and fixed during this patch only :)

> The parens are still not necessary, though.

Already got rid of them and so didn't bother replying :)
