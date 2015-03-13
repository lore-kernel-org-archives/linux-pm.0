From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] cpuidle: 4.0-rc3 fixes
Date: Fri, 13 Mar 2015 22:56:59 +0100
Message-ID: <2429393.iDkfxR0R07@vostro.rjw.lan>
References: <55032186.3000306@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58453 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751250AbbCMVdL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 17:33:11 -0400
In-Reply-To: <55032186.3000306@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sebastien Rannou <mxs@sbrk.org>, Gregory Clement <gregory.clement@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Friday, March 13, 2015 06:42:30 PM Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> this pull request contains a couple of fixes:
> 
>   - Fix the cpu_pm_enter/exit symmetry in the mvebu driver (Gregory Clement)
> 
>   - Fix the mvebu drivers latency/residency values to reach an 
> acceptable tradeoff between perf / power (Sebastian Rannou)
> 
> Thanks !

Pulled, but this is a bit too late for 4.0-rc4, so I'll queue it up for -rc5.

> ps: I took the opportunity to double check the other drivers have their 
> cpu_pm_entry/exit symmetry correct (everything ok).

OK, thanks!

BTW, please update the dead linux-pm address you have in your scripts.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
