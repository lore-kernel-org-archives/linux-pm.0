From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 16:39:17 -0400
Message-ID: <87k5syg3yi.fsf__33374.1802409806$1184704826$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171802.30903.rjw@sisk.pl>
	<Pine.LNX.4.64.0707170959160.2467@asgard.lang.hm>
	<200707172150.44417.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
	(david@lang.hm's message of "Tue\,
	17 Jul 2007 13\:18\:13 -0700 \(PDT\)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

david@lang.hm writes:

[snip]

> the non-ACPI hibernate behaves very differently, and for some people (and I
> think I am one of them) it will meet their needs better then _any_ of the ACPI
> suspends.

It may have certain differences from the user point of view, but from
the implementation view, it seems that it is nearly exactly the same.
The only differences seem to be: 

 - rather than shutting down, do whatever is necessary to stick the
   system in S4 state.

 - make sure ACPI isn't initialized by the "load image" kernel

 - rather than "resume from hibernate" ACPI by initializing it normally,
   issue the special hibernate-related methods.

Thus, it seems that supporting ACPI S4 will have a very minimal affect
on the hibernate implementation.

-- 
Jeremy Maitin-Shepard
