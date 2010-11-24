From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezes on resume from S2R
Date: Wed, 24 Nov 2010 21:01:08 +0100
Message-ID: <201011242101.08157.rjw@sisk.pl>
References: <20101124095618.GC5982@denkmatte.mittag-leffler.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101124095618.GC5982@denkmatte.mittag-leffler.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 24, 2010, Thomas Kahle wrote:
> Hi,

Hi,

> I'm trying to debug freezes upon resume from suspend-to-RAM on my
> Thinkpad X61s.  The userland is a mostly stable x86 Gentoo Linux with
> recent X stack.  The freeze does not occur always, but it is
> reproducable after a few successful suspend-resume cycles.  I can
> reproduce it because affected kernels will not complete 10
> suspend-resume cycles, so this has been my criterion for all the tests I
> have done.  When the freeze occurs I have seen various things happening.
> In most instances the X screen comes up in the state before the resume
> works for a few milliseconds and then freezes.  In this state the
> computer is not reachable by ssh and the only option is to reboot.  In
> other instances I have also seen X crashing, dropping me to a console
> and then freezing.  In one inctance (still with gentoo-sources, before I
> started testing with mainline) I was able to ssh into the system and
> found spurious things in the log.  Please see the attachad file
> 'messages'.  On 12:08:33 I connect via ssh as root.  I see the process X
> occupying 100% CPU and it cannot be killed (kill -9 has no effect).  I
> tried to reboot the machine with init x6, but this failed.  Browsing the
> list archive it might be related to what Linus reported here:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-November/029299.html

This warning means that resume took more that 10 s, which is suspicious, but
not a bug by itself.

> These problems appear to me as a regression since everything is
> reproducibly fine with kernels <=2.6.34, and 2.6.35 seems to be fine too
> (although I have tested that less).  I started a bisect, see below.

Well, it would be good if you could find the commit that broke things for
you, but it might be a few different things - ACPI, PCI, graphics driver, etc.

Please check if you can reproduce the symptom using pm_test:

# echo core > /sys/power/pm_test
# echo mem > /sys/power/state

(it should simulate a suspend-resume cycle and get back to the command prompt
in 5-10 sec).  You can try to run that in a loop and see if that breaks things.

Thanks,
Rafael
