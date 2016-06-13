From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Linux panics when suspend cannot offline the secondary cores
Date: Mon, 13 Jun 2016 22:02:13 +0100
Message-ID: <20160613210213.GZ1041@n2100.armlinux.org.uk>
References: <575ADFAC.4090009@free.fr> <2922940.3xeChLaYeK@vostro.rjw.lan>
 <575EBA40.4000803@free.fr> <2041686.H4Vc2p72PV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2041686.H4Vc2p72PV@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sebastian Frias <sf84@laposte.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Mason <slash.tmp@free.fr>, Stephen Boyd <sboyd@codeaurora.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 13, 2016 at 10:49:32PM +0200, Rafael J. Wysocki wrote:
> I guess all of the existing implementations of smp_ops.cpu_die() don't return
> to the caller no matter what, so the caller did not have to consider anything
> else.

Existing implementations for hardware which implements CPU hotplug
takes the requested CPU down in such a way that smp_ops.cpu_die()
*never* returns.

We have a number of evaluation boards where its desirable to emulate
CPU hotplug.  These boards have no power management abilities, and
have no way to power down or reset a CPU from software.  For these,
we implement CPU hotplug by taking the CPU down gracefully, taking
it out of coherency, and then placing it in a loop waiting for the
CPU up event to arrive.  At that point (and this is the only legal
time) smp_ops.cpu_die() returns - at which point you get the
resuscitating kernel message, and the CPU re-enters the kernel.

This path is _only_ for these evaluation platforms which have no
hardware support for CPU hotplug, and therefore no PM and no kexec.

The *only* solution to having working PM support Mason's platform is
a properly implemented CPU hotplug correctly - which means ensuring
that the CPU is either powered down or placed in reset during the
smp_ops.cpu_die() call.  Everything else (even the simulation of it)
is not good enough.

That can be done either by the dying CPU when it calls into
smp_ops.cpu_die(), or the CPU requesting the death of the CPU via
smp_ops.cpu_kill().

Either way, it's up to the platform code to implement these, and as
I say, a correct and proper implementation of this is a fundamental
requirement for system power management (like suspend) and kexec in
a SMP system.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
