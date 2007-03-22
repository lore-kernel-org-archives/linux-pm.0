From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 23:35:56 +0900
Message-ID: <20070322143556.GA22798@linux-sh.org>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<20070322142437.GB21954@linux-sh.org>
	<20070322143313.GA7963@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070322143313.GA7963@elf.ucw.cz>
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

On Thu, Mar 22, 2007 at 03:33:13PM +0100, Pavel Machek wrote:
> On Thu 2007-03-22 23:24:37, Paul Mundt wrote:
> > On Thu, Mar 22, 2007 at 02:31:17PM +0100, Pavel Machek wrote:
> > > Hohum, perhaps it can suspend to SD card? Or perhaps it can suspend
> > > over network?
> > > =

> > > Suspend code will properly fail if there's not enough swap space.
> > > =

> > > ...plus you are allowed to return -EINVAL from arch_prepare_suspend()
> > > or how is it called.
> > =

> > So then how exactly is this helping anything? It's pointless to have the
> > sysfs file visible for platforms that are never going to support suspend
> > to disk, and -EINVAL'ing out in another path is simply moving the
> > problem.
> =

> Platforms that are never going to support s2disk =

> =

> a) should be fixed
> =

> b) do not have CONFIG_SOFTWARE_SUSPEND.

Ah, that's the part I was missing. Ok, As long as the memory-only thing
is explicit, then I don't see any problem with these.

Acked-by: Paul Mundt <lethal@linux-sh.org>
