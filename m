From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Sun, 01 Nov 2009 22:53:17 +0100
Message-ID: <87iqdtvrn6.fsf__27801.6401840889$1257112489$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu>
	<9b2b86520910310502p7fe8e0edmff09220632fab5e2@mail.gmail.com>
	<874opfwtde.fsf@tac.ki.iif.hu> <200910312011.04005.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910312011.04005.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 31 Oct 2009 20:11:03 +0100")
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

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Saturday 31 October 2009, Ferenc Wagner wrote:
>
>> Heh, maybe, but the version compiled from Rafael's git tree prints the
>> ratio all right, and its value is even positive and less than 1.  So I
>> confirm that the ratio issue is fixed.  I'll be running with this
>> version from now on, and if it exhibits the same original issue, I'll
>> switch to shutdown mode and gather some experience running that.
>
> Well, the problem you reported is a kernel issue and switching to the newer
> user space is not likely to help.

Well, I haven't had my hopes overly high, but wanted to have a concrete
baseline.  So: with the new s2disk I got a freeze again after S|.  After
a manual power off and a successful resume, I switched to shutdown mode
and hibernated again, and got the exact same freeze (apart from a
slightly different image size).  Power off, resume, switch to reboot
mode, hibernate, and this worked.  Switch back to shutdown, now that
worked as well...  Eh.  In my earlier bug report I think I noted that
after such a hibernation failure a straight shutdown didn't power off
the computer as it otherwise does, which feels consistent with the
above.

With the uswsusp 0.7, a typical freeze looked like this:

s2disk: Snapshotting system
s2disk: System snapshot ready. Preparing to write
s2disk: Image size: 240872 kilobytes
s2disk: Free swap: 1333596 kilobytes
s2disk: Saving 60217 image data pages (press backspace to abort) ... 100% done (60217 pages)
s2disk: Compression ratio -63208.85
S|

With the new version the ratio is 0.42 with similar numbers, which
sounds sane at least.  However, 60217 * 4 = 240868 = 240872 - 4, wasn't
the number of saved pages one off?  The new version seems to get this
right, though.

Now something else, which may or may not be related.  I supervise a
computing farm running a very old OS: Debian Sarge.  The kernel was
somewhat newer: 2.6.24 until recently, when new machines arrived to the
lab, which couldn't boot that 2.6.24 kernel.  So I upgraded to 2.6.31,
which works quite well, apart from one thing: halt doesn't power off the
machines anymore.  All the same under 2.6.32-rc5: they simply freeze
after reaching halt -d -f -i -h -p in the shutdown sequence.

I'm pretty much stumped here, but will try to get some SysRq dumps out
of these machines at least.
-- 
Thanks,
Feri.
