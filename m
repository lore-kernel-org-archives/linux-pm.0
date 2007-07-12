From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to
	kexec	base	hibernation
Date: Thu, 12 Jul 2007 12:05:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707121204200.25614__37725.3659106374$1184267618$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707112345250.28090@asgard.lang.hm>
	<1184260683.9346.91.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707120247230.25614@asgard.lang.hm>
	<469632C7.5000903@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469632C7.5000903@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Mark Lord wrote:

> david@lang.hm wrote:
>>
>>  actually, I think that while you may be able to get away with only one
>>  kernel, you are probably better off with two. on the hibernate kernel you
>>  can choose many 'embedded' options that don't make sense for the normal
>>  kernel (no high mem, no SMP support, no SELinux, no network routing, not
>>  netfilter, use SLOB not SLAB/SLUB, etc). also keep in mind that each
>>  module that you load wastes apartial page of memory.
>
> No highmem?  No thanks.
>
> I really want hibernate to save stuff from above 1GB as well
> as the stuff below 1GB.

oops, good point. I was thinking that the hibernate kernel wouldn't need 
that much ram for it's own operation and forgetting that it needed to 
access everything the main system had.

David Lang
