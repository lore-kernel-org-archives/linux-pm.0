From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Sat, 07 Dec 2013 20:17:16 +0100
Message-ID: <1386443836.5335.38.camel@marge.simpson.net>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
	 <1386405590.5673.96.camel@marge.simpson.net>
	 <CAJvTdKkQUKFhwswK64PDNgPOMxP4s2X1GYKzWLW0G6gWxhdWtA@mail.gmail.com>
	 <CAJvTdK=9DVxY9xWCo=SSF-Rx3dFfZtkrubhtcgxxowj-rbi8LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64689 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab3LGTRW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 14:17:22 -0500
In-Reply-To: <CAJvTdK=9DVxY9xWCo=SSF-Rx3dFfZtkrubhtcgxxowj-rbi8LQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Sat, 2013-12-07 at 11:45 -0500, Len Brown wrote: 
> >> It fixes that, except for my Q6600 box.  Too bad mwait_idle() went away,
> >> beloved old box doesn't play hints game, so it continues to flog itself.
> 
> 
> Thanks for pointing this out, Mike!
> 
> A Q6600 is a Kentsfield.  I dug one of those up.
> Indeed, the only idle capabilities it has are  HALT
> and old style MWAIT, and the latter is much more effective.
> running 3.8 it idles at 75 watts.
> running 3.8 with idle=nomwait it idles at 100 watts,
> which is what it will do with 3.9 and later due to the patch below.
> 
> commit 69fb3676df3329a7142803bb3502fa59dc0db2e3
> Author: Len Brown <len.brown@intel.com>
> Date:   Sun Feb 10 01:38:39 2013 -0500
> 
>     x86 idle: remove mwait_idle() and "idle=mwait" cmdline param
> 
> Kentsfield proves that patch was based on a fault assumption.
> Sweet box in its day, ECC memory and everything -- probably still
> a fair number of them running...
> 
> Plus, I've found another machine that depends on having an idle=mwait
> idle loop (A Sony Vaio BIOS SMM code apparently assumes we use it in
> https://bugzilla.kernel.org/show_bug.cgi?id=60770)
> 
> So it looks like I need to (also) restore the simple idle=mwait idle loop
> to make some machines happy.

Cool, box will definitely be happier.

-Mike

