From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] cpuidle: 4.0-rc3 fixes
Date: Tue, 17 Mar 2015 03:37:05 +0100
Message-ID: <1477703.PhCcfT3r53@vostro.rjw.lan>
References: <55032186.3000306@linaro.org> <2429393.iDkfxR0R07@vostro.rjw.lan> <CAMuHMdWtu3f9S0aXGGdnoO4JSu+9FN1zvEO6goWGSo3wEbQXrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58167 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751036AbbCQCNN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 22:13:13 -0400
In-Reply-To: <CAMuHMdWtu3f9S0aXGGdnoO4JSu+9FN1zvEO6goWGSo3wEbQXrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastien Rannou <mxs@sbrk.org>, Gregory Clement <gregory.clement@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, March 16, 2015 10:24:27 AM Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Fri, Mar 13, 2015 at 10:56 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, March 13, 2015 06:42:30 PM Daniel Lezcano wrote:
> >> this pull request contains a couple of fixes:
> >>
> >>   - Fix the cpu_pm_enter/exit symmetry in the mvebu driver (Gregory Clement)
> >>
> >>   - Fix the mvebu drivers latency/residency values to reach an
> >> acceptable tradeoff between perf / power (Sebastian Rannou)
> >>
> >> Thanks !
> >
> > Pulled, but this is a bit too late for 4.0-rc4, so I'll queue it up for -rc5.
> 
> Please note commit 43b68879de27b199 ("cpuidle: mvebu: Fix the CPU PM
> notifier usage") has a "Cc: stable@vger.kernel.org" tag.

Yes, it does, and that's why I've queued it up for 4.0-rc5 and not for 4.1.

Does it require any extra care or something?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
