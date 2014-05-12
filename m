From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / suspend: Always use deepest C-state in the "freeze" sleep state
Date: Tue, 13 May 2014 01:53:49 +0200
Message-ID: <1675732.Zj8pe2mRTV@vostro.rjw.lan>
References: <2548502.zJ1no3NhRc@vostro.rjw.lan> <5370D85C.3090505@linux.intel.com> <5370E026.5040105@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54677 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751708AbaELXhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 19:37:04 -0400
In-Reply-To: <5370E026.5040105@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aubrey Li <aubrey.li@intel.com>

On Monday, May 12, 2014 04:52:22 PM Daniel Lezcano wrote:
> On 05/12/2014 04:19 PM, Li, Aubrey wrote:
> > On 2014/5/12 22:08, Daniel Lezcano wrote:
> >> On 05/05/2014 12:51 AM, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> If freeze_enter() is called, we want to bypass the current cpuidle
> >>> governor and always use the deepest available (that is, not disabled)
> >>> C-state, because we want to save as much energy as reasonably possible
> >>> then and runtime latency constraints don't matter at that point, since
> >>> the system is in a sleep state anyway.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> This is on top of https://patchwork.kernel.org/patch/4071541/ .
> >>>
> >>
> >> Wouldn't make sense to revisit play_dead instead ?
> >>
> > play_dead() is broken.
> >
> > Even if it works, we still should rely on cpuidle driver to place the
> > CPUs into the deepest c-state, because there is no architectural way to
> > enter deepest c-state and what play_dead() does is a bad assumption.
> 
> Ok, let me rephrase it. Why not revisiting cpuidle_play_dead instead ?

Many drivers don't implement the ->enter_dead() callback.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
