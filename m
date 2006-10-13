From: Adam Belay <abelay@MIT.EDU>
Subject: Re: Bug in PCI core
Date: Fri, 13 Oct 2006 04:50:27 -0400
Message-ID: <1160729427.26091.98.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
	<1160701263.4792.179.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1160701263.4792.179.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-10-13 at 11:01 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2006-10-11 at 16:41 -0400, Alan Stern wrote:
> > When a PCI device is suspended, its driver calls pci_save_state() so th=
at
> > the config space can be restored when the device is resumed.  Then the
> > driver calls pci_set_power_state().
> > =

> > However pci_set_power_state() calls pci_block_user_cfg_access(), and th=
at =

> > routine calls pci_save_state() again.  This overwrites the saved state =

> > with data in which memory, I/O, and bus master accesses are disabled.  =
As =

> > a result, when the device is resumed it doesn't work.
> > =

> > Obviously pci_block_user_cfg_access() needs to be fixed.  I don't know =
the =

> > right way to fix it; hopefully somebody else does.
> =

> Well, blocking user cfg access snapshots the config space to be able to
> respond to user space while the device is offline. Maybe it should be
> done from a separate config space image buffer ? ugh....
> =

> Ben.

Personally, I don't think exposing a cached version of the PCI config
space when direct device access is prohibited is the right approach
here.  We really shouldn't be lying about the internal state of PCI
devices (the cached version could be quite inaccurate).  After all, if
the device is in D3cold, then the spec claims it's perfectly valid for
it to not respond to PCI configuration access.

I can only assume this hack was done to satisfy some terribly broken
userspace app.  It's not surprising that even reading PCI config can
easily crash systems.  However, it's the responsibility of those apps
with permission to access the PCI sysfs interface, not the kernel, to be
aware of these constraints.

The PCI configuration space cache was originally introduced to support
power management.  However, it's mostly incorrect, as it unnecessarily
stores the values of read only registers (and even BIST which is
potentially dangerous).  A while back I posted a series of patches that
address this issue, and the net result was that the config cache stays
around wasting memory because of the pci_block_user_cfg_access()
dependency despite being useless to PCI PM.

I'd like to propose that we have the pci config sysfs interface return
-EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
reflects the state of the device to userspace, reduces complexity, and
could potentially save some memory per PCI device instance.

Thanks,
Adam
