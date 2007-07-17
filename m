From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 12:09:58 -0400
Message-ID: <87hco3ypt5.fsf__20100.5475516014$1184688792$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171640.39955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707171640.39955.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue\, 17 Jul 2007 16\:40\:38 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[snip]

> I'm afraid of one thing, though.

> If we create a framework without ACPI (well, ACPI needs to be enabled in the
> kernel anyway for other reasons, like the ability to suspend to RAM) and then
> it turns out that we have to add some ACPI hooks to it, that might be difficult
> to do cleanly.

> Thus, it seems reasonable to think of the ACPI handling in advance.

As far as I understand, ACPI support is only useful for hibernate to the
extent that it allows some or all of the following features:

 - possibly shows a nice looking "hibernate" LED
 - possibly allows the BIOS to show something about hibernate
 - possibly allows the lid or keyboard to "wake up" (turn on) the system

Note that properly restoring device state (or even properly determining
whether on external/mains power vs. battery) on resume is not something
that should require special hibernate ACPI support, since it should be
possible to make hibernate (and in general it will be the case that
hibernate will) look exactly like a reboot to the BIOS/ACPI/devices.
The problem that you mentioned on your system regarding power source
information would seem to just be a problem with how ACPI is
reinitialized after resuming from hibernation, which is not at all
surprising since we know it (the use of driver calls for hibernate) is
currently broken in many ways.

It seems that enabling S4 mode should just be treated as a special
shutdown mode, independent of hibernate.  In practice, it may likely
only be useful in conjunction with hibernate, but there doesn't seem to
be any reason it needs to be coupled.

It would be useful to determine whether it is necessary to initialize
ACPI specially after "resuming" from S4 mode, though, or whether they
can be initialized normally (i.e. by a normal kernel for instance,
completely unaware of hibernate).  If they can be initialized normally,
then it seems that it is unnecessary to have any ACPI S4 mode support in
the resume path, and it can merely exist as a special shutdown mode.
Note that it seems a bit odd if ACPI can't be initialized normally after
resume from S4 (and still work), since the "load image" kernel
initializes everything normally before attempting to resume the
hibernated system.

-- 
Jeremy Maitin-Shepard
