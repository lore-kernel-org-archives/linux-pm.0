From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 6 Aug 2011 12:37:13 +0900
Message-ID: <20110806033711.GA18987__26327.2820426666$1312601922$gmane$org@opensource.wolfsonmicro.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<201108042115.30983.rjw@sisk.pl>
	<20110805161147.GA3438@opensource.wolfsonmicro.com>
	<201108052137.37011.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108052137.37011.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 05, 2011 at 09:37:36PM +0200, Rafael J. Wysocki wrote:
> On Friday, August 05, 2011, Mark Brown wrote:

> > Do you have any examples of this that aren't better expressed in device
> > specific terms?

> I'm not sure what you mean exactly, but if you take two PC-like systems
> with similar hardware configurations, but different BIOS-es and motherboard
> layouts, it's very likely that on one of them PCI PME won't be routed
> correctly, for example.  In that case the kernel has no way to figure out
> that that system is broken, the problem can only be worked around from user
> space by diabling runtime PM on the affected PCI devices.  I expect similar
> problems to appear for the PM QoS settings.

I wouldn't say we've got to rely on userspace here - it seems like we
ought to be able to use DMI or other system data to identify the
affected systems and activate the workarounds.

> > It's not that users don't know what they're doing, it's
> > that working around system integration and stability issues in userspace
> > isn't really progressing things well or helping with maintainability.

> No, it's not, but sometimes we simply don't have the choice.  Besides,
> in the particular case of PM QoS, the constraints set by user space will
> simply be added to the constraints set by kernel subsystems.  Thus they
> won't prevent any kernel subsystem from specifying its own constraints,
> but they will give user space the option to override the constraints
> originating from the kernel.

You're right that it doesn't stop the kernel doing anything, the concern
is that people just won't bother making the kernel work properly and
will just do their power management in userspace and not bother fixing
the kernel.  Punting to userspace seems like it is creating the
expectation that we can't make the kernel work and isn't great from a
usability perspective since users shouldn't really be worrying about bus
performance or so on, it's not something that's visible at the level
applications work at.

> > Generally if the user has sufficient access to be able to do anything
> > with this stuff they've got just as much access to the kernel as to
> > userspace.

> Do you mean they may rebuild the kernel?  That isn't always possible.

I'm not sure I can see a lot of cases where you'd have root access and
not be able to do kernel updates if required?  Having stuff in debugfs
for diagnostics doesn't strike me as a problem if that's the issue.
