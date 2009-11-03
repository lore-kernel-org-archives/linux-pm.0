From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Tue, 03 Nov 2009 12:02:32 +0100
Message-ID: <87fx8veurb.fsf__39609.9882586443$1257246475$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu>
	<9b2b86520910310502p7fe8e0edmff09220632fab5e2@mail.gmail.com>
	<874opfwtde.fsf@tac.ki.iif.hu> <200910312011.04005.rjw@sisk.pl>
	<87iqdtvrn6.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87iqdtvrn6.fsf@tac.ki.iif.hu> (Ferenc Wagner's message of "Sun,
	01 Nov 2009 22:53:17 +0100")
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ferenc Wagner <wferi@niif.hu> writes:

A)

> So: with the new s2disk I got a freeze again after S|.  After a manual
> power off and a successful resume, I switched to shutdown mode and
> hibernated again, and got the exact same freeze (apart from a slightly
> different image size).  Power off, resume, switch to reboot mode,
> hibernate, and this worked.  Switch back to shutdown, now that worked
> as well...  Eh.  In my earlier bug report I think I noted that after
> such a hibernation failure a straight shutdown didn't power off the
> computer as it otherwise does, which feels consistent with the above.

B)

> Now something else, which may or may not be related.  I supervise a
> computing farm running a very old OS: Debian Sarge.  The kernel was
> somewhat newer: 2.6.24 until recently, when new machines arrived to the
> lab, which couldn't boot that 2.6.24 kernel.  So I upgraded to 2.6.31,
> which works quite well, apart from one thing: halt doesn't power off the
> machines anymore.  All the same under 2.6.32-rc5: they simply freeze
> after reaching halt -d -f -i -h -p in the shutdown sequence.

Hi,

so now I've got three ACPI and/or PM related problems: A) and B) above
with hibernation and halt/poweroff, and the C) graphics and suspend
related described at http://bugs.freedesktop.org/show_bug.cgi?id=22126
(which turned out to be ACPI related recently).

B) and C) are 100% reproducible, although the machines exhibiting C) are
at a different geographic location, so I have to bug a remote admin for
power switching.

A) and C) are exhibited by my laptop.

I'd be grateful for debugging tips for any of the above.  While A) is
not reproducible, it happens often enough with the platform method (I
haven't got enough data with the shutdown method yet).  I'm willing to
recompile kernels, read up on documentation and code and have parallel
port LEDs handy (for the laptop).  But I've got no experience with ACPI
or PM, sadly.  However, 2.6.32 is currently nominated as more than a
couple of distros' choice for long term stable support, so I'm willing
to invest substantial effort into fixing these issues.

If anybody has debugging tips, please share (and note if further
questions aren't welcome).
-- 
Thanks,
Feri.
