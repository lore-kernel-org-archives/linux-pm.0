From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 17:27:34 -0400
Message-ID: <871wf6g1q1.fsf__6000.01281495697$1184707832$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707171416120.3728-100000@iolanthe.rowland.org>
	<200707172217.01890.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171328450.2467@asgard.lang.hm>
	<200707172323.51702.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171414370.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707171414370.2467@asgard.lang.hm>
	(david@lang.hm's message of "Tue\,
	17 Jul 2007 14\:17\:35 -0700 \(PDT\)")
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

>> How do you guarantee that no tasks are scheduled when you get back to the
>> hibernated kernel?

> just don't schedule any userspace tasks. all you need to do is to execute the
> ACPI sleep functions. you normally do that after stopping userspace
> anyway.

What does "stopping userspace" mean?  You already said it does not mean
disabling interrupts.  But using the freezer is also not an option,
since the avoidance of that is the main reason for the kexec approach in
the first place.

[snip]

>> Well, not exactly.  If your battery runs out of power while you're suspended,
>> but you have the image saved, it's still better to restore from the image,
> even
>> if something may not work correctly after the restore, than to risk a loss of
>> data.

> if things don't work correctly you are still risking the loss of data, the user
> just doesn't know it.

It should be possible on any system to do a hibernate followed by a
shutdown (and then resume properly, without any problems).  Thus, for
handling suspend to both, you resume as if the system had been shutdown,
rather than resuming as if the system came from S4.

-- 
Jeremy Maitin-Shepard
