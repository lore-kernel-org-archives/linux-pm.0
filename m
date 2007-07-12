From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 16:05:31 -0400
Message-ID: <87y7hl2xro.fsf__42122.4357829944$1184270846$gmane$org@jbms.ath.cx>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121446.14170.rjw@sisk.pl> <469631FA.2070405@rtr.ca>
	<200707121735.40077.rjw@sisk.pl> <469650DE.4000901@rtr.ca>
	<46965837.8030907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46965837.8030907@rtr.ca> (Mark Lord's message of "Thu\, 12 Jul
	2007 12\:35\:03 -0400")
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
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Mark Lord <lkml@rtr.ca> writes:

[snip]

> Whoops.. wrong half of the script.
> For TuxOnIce in 10 seconds, it does this:

[snip]

I'd argue that for most usage patterns, it doesn't matter all that much
how long it takes to hibernate and power off the system.  What really
matter is that it is extremely reliable, and how fast it takes to
resume.

The reason for this is as follows:

A typical usage pattern of hibernate on a laptop is to shut the lid,
causing the system to start to hibernate, and to place the machine in
the bag.  This is fine, as long as you aren't too rough moving it into
the bag, and the hibernation is extremely reliable (i.e. there is no
chance that it fails to hibernate, and remains powered on.)  Presumably
some additional userspace logic could help here, like start beeping
loudly if the hibernate fails, or perhaps just initiate a shut down, to
avoid the machine overheating in the bag.

Note that in this usage pattern, it doesn't matter how long it takes to
hibernate, because you don't actually wait for it to finish.  The only
waiting occurs when you turn it on, and the resume path should be
essentially exactly the same under kexec hibernate as with the existing
hibernate.

Thus, if kexec hibernate improves reliability (as it might, given that
it eliminates the need for the freezer), it may be worth the slightly
increased hibernate time.  I think the actual amount of extra time it
will take may be very small; a stripped down kernel may only take a
second or two to initialize.

-- 
Jeremy Maitin-Shepard
