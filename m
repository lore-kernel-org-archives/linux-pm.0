From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC][PATCH 3/4] PCI / ACPI PM: Platform support for
 PCI PME wake-up
Date: Tue, 6 Oct 2009 10:32:13 -0700
Message-ID: <20091006103213.1803cb65@jbarnes-g45>
References: <200909132320.05077.rjw@sisk.pl> <200909140053.05779.rjw@sisk.pl>
	<20090913225518.GA31787@srcf.ucam.org>
	<200909210226.10671.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909210226.10671.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Sep 2009 02:26:10 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday 14 September 2009, Matthew Garrett wrote:
> > On Mon, Sep 14, 2009 at 12:53:05AM +0200, Rafael J. Wysocki wrote:
> > > On Monday 14 September 2009, Matthew Garrett wrote:
> > > > On Sun, Sep 13, 2009 at 11:24:03PM +0200, Rafael J. Wysocki
> > > > wrote:
> > > > > +	} else if (!dev->wakeup.flags.run_wake) {
> > > > > +		acpi_set_gpe_type(dev->wakeup.gpe_device,
> > > > > +
> > > > > dev->wakeup.gpe_number,
> > > > > +					ACPI_GPE_TYPE_WAKE);
> > > > 
> > > > Is this going to work for cases where we have multiple devices
> > > > attached to the same GPE? The common one is EHCI, where both
> > > > EHCI HCDs will be one a single GPE. If we wake one, that'll
> > > > then disable the GPE for the other. Further wakeup events will
> > > > then be lost.
> > > 
> > > You're right, I overlooked that.  Some kind of refcounting is
> > > needed here.
> > 
> > I've sent patches to implement this at the GPE level, which also
> > change the API for requesting them. I'm waiting on feedback from
> > Bob Moore.
> 
> In the meantime I realized there's one more thing we need to take
> care of. Namely, if a wake-up GPE is shared between multiple devices,
> it need not be necessary to install notify handlers for all of them.
> For example, if one of these devices is the root bridge, we will walk
> all of the hierarchy under it looking for devices that have PME set,
> so we need not install notify handlers for any devices that share the
> wake-up GPE with the root bridge.  Similarly, there's no need to
> install a notify handler for a device that shares the wake-up GPE
> with a bridge (non-root) it is under.
> 
> Taking that into account I have prepared another version of the
> @subject patch which is appended below.  It also takes the PM vs
> hotplug issue into account.  The idea is pretty straightforward,
> everything should be clear from the changelog and the comments within
> the patch.
> 

What's the latest on this set?  Is this the final version?  Anyone have
issues with this version?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
