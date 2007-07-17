From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 17:53:26 -0400
Message-ID: <87wswyelyh.fsf__9438.28927488557$1184709277$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707172257.22959.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171345270.2467@asgard.lang.hm>
	<200707172337.24683.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171430050.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171430050.2467@asgard.lang.hm>
	(david@lang.hm's message of "Tue\,
	17 Jul 2007 14\:42\:58 -0700 \(PDT\)")
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
 
>> There are NO ACPI LIMITS!  There only are things that you need to implement
>> if you're going to support ACPI, but they need not be used ALWAYS, no?

> yes there are limits. the fact that you can't remove the battery in S4 mode
> without messing things up is a limit,

You won't mess things up as long as the resuming kernel knows that it
should resume as if the system were shutdown, rather than sent to S4
state.  Maybe it is even possible to detect what type of resuming is
needed automatically.  Similarly, booting another OS shouldn't be a
problem, except that if you do it without powering off the system first,
some devices might not work under the other OS if the other OS doesn't
initialize them properly.

[snip]

-- 
Jeremy Maitin-Shepard
