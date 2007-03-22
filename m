From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 23:24:37 +0900
Message-ID: <20070322142437.GB21954@linux-sh.org>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070322133117.GC6050@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 22, 2007 at 02:31:17PM +0100, Pavel Machek wrote:
> > > No, once SOFTWARE_SUSPEND is configured there's *no way* to disable it
> > > after the fact via pm_ops. Read valid_state() in kernel/power/main.c.
> > =

> > So how does a platform with only flash (and an insufficient amount of
> > flash at that) tell the suspend code that suspend-to-disk is not
> > supported?
> =

> Hohum, perhaps it can suspend to SD card? Or perhaps it can suspend
> over network?
> =

> Suspend code will properly fail if there's not enough swap space.
> =

> ...plus you are allowed to return -EINVAL from arch_prepare_suspend()
> or how is it called.

So then how exactly is this helping anything? It's pointless to have the
sysfs file visible for platforms that are never going to support suspend
to disk, and -EINVAL'ing out in another path is simply moving the
problem.

The platforms already have a good idea of what sort of suspend they can
cope with, and while I don't see anything against allowing other forms of
suspend to be enabled by the users that really want it, forcing it on
everyone because it's a possibility is nonsense.
