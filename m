From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 12:51:44 +0200
Message-ID: <20150518105144.GD21418@twins.programming.kicks-ass.net>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <670732402.598272.1431943820988.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54333 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbERKwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 06:52:13 -0400
Content-Disposition: inline
In-Reply-To: <670732402.598272.1431943820988.JavaMail.zimbra@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Michal Hocko <mhocko@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Trim emails already.. this seems a spreading disease.

On Mon, May 18, 2015 at 06:10:20AM -0400, Ulrich Obergfell wrote:
> Michal,
> 
> if I understand you correctly, Peter's patch solves the problem for you.
> I would like to make you aware of a patch that Don and I posted in April.
> 
>   https://lkml.org/lkml/2015/4/22/306
> 
> watchdog_nmi_enable_all() should not use 'watchdog_user_enabled' at all.
> It should rather check the NMI_WATCHDOG_ENABLED bit in 'watchdog_enabled'.
> The patch is also in Andrew Morton's queue.
> 
>   http://ozlabs.org/~akpm/mmots/broken-out/watchdog-fix-watchdog_nmi_enable_all.patch
> 
> Peter's patch introduces the same change in watchdog_nmi_enable_all(),
> plus some synchronization. However, I'm not sure if we actually need the
> synchronization. It is my understanding that {en,dis}able_all() are only
> called early during kernel startup via initcall 'fixup_ht_bug':
> 
>   kernel_init
>   {
>     kernel_init_freeable
>     {
>       lockup_detector_init
>       {
>         watchdog_enable_all_cpus
>           smpboot_register_percpu_thread(&watchdog_threads)
>       }
> 
>       do_basic_setup
>         do_initcalls
>           do_initcall_level
>             do_one_initcall
>               fixup_ht_bug // subsys_initcall(fixup_ht_bug)
>               {
>                 watchdog_nmi_disable_all
> 
>                 watchdog_nmi_enable_all
>               }
>     }
>   }
> 
> Peter,
> 
> do we really need the synchronization here?

Well, those are the only current usage sites, but the interface is
exposed and should be fully and correctly implemented, otherwise a next
user might stumble upon sudden unexpected behaviour.

But yes, it appears superfluous for this particular usage.
