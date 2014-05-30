From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 0/4] intel_pstate fixes for v3.16
Date: Fri, 30 May 2014 03:04:02 +0300
Message-ID: <5387CAF2.9030508@semaphore.gr>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com> <CADmjqpNoRjhO=BaRBXxONCWd8-i9tzDLGVF4fTBs4jfRtHbdxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:54840 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbaE3AEJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 May 2014 20:04:09 -0400
In-Reply-To: <CADmjqpNoRjhO=BaRBXxONCWd8-i9tzDLGVF4fTBs4jfRtHbdxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>

On Thu, May 29, 2014 at 7:32 PM,  <dirk.brandewie@gmail.com> wrote:
> 
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Based on Rafael's linux-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> Commit 0c932c3ecbba60bc5f9e08d579891cdbedfdd1c1
> 
> Fixes the regression where intel_pstate was being too reactive
> reducing the P state caused by the C0 tracking which was added to
> ensure that on an idle system intel_pstate converge on the lowest
> reasonable P state.  The C0 tracking mechanism is replaced with a
> mechanism that looks at sample time and scales the busy calculation
> only if the sample time is *much* larger than the requested sample time.
> 
> Reference:
>    https://bugzilla.kernel.org/show_bug.cgi?id=75121
>    https://lkml.org/lkml/2014/5/6/597
> 
> Dirk Brandewie (3):
>   intel_pstate: Remove C0 tracking
>   intel_pstate: Correct rounding in busy calculation
>   intel_pstate: add sample time scaling
> 
> Doug Smythies (1):
>   intel_pstate: Improve initial busy calculation
> 
>  drivers/cpufreq/intel_pstate.c | 52 +++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 

Hi,

I tested the patch set, run some benchmarks and I would like
to post the results:

CPU: Core i7-3770

			    TIME (sec)			ENERGY(J)
			Without	With	Diff	Without		With	  Diff
Phoronix kernel build	265.37	260.33	 -1.9%	15349.99	15437.57  +0.57%
Phoronix Apache		293.69	193.61	-34.8%	 9016.28	 8544.00  -5.24%
mp3 decoding 		245.64	245.91		 5057.73	 5046.07  -0.23%
Idle system (turbostat)  60	 60		 1210.80	 1211.40  +0.05%


In case you want to, you may add

Tested-by: Stratos Karafotis <stratosk@semaphore.gr>


Thanks,
Stratos
