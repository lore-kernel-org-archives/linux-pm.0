From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
Date: Thu, 31 Oct 2013 00:25:35 +0100
Message-ID: <44629257.8AhBlXWpZK@vostro.rjw.lan>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org> <7822477.lBueQHUY4E@vostro.rjw.lan> <CAKohpom-Oo81U_J5sC8qG7uzjW=yRJLvAPDpNyV6Sst7uw=hag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55493 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751369Ab3J3XN0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2013 19:13:26 -0400
In-Reply-To: <CAKohpom-Oo81U_J5sC8qG7uzjW=yRJLvAPDpNyV6Sst7uw=hag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Dave P Martin <dave.martin@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>

On Thursday, October 31, 2013 04:01:13 AM Viresh Kumar wrote:
> 
> --047d7b33ce860f693404e9fce430
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On 31 October 2013 03:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Queued up for 3.13, thanks!
> 
> Hmm.. thanks for applying this but there was a minor bug here which
> is fixed by below commit.. You don't really need to merge this with
> the original commit and so can go as a separate commit..
> 
> Attached for applying.. Tested by Nico.

I've just fixed it up manually, please check the result in bleeding-edge.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
