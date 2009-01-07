From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 5/10] PCI PM: Avoid touching devices
	behind bridges in unknown state (rev. 2)
Date: Thu, 8 Jan 2009 00:02:54 +0100
Message-ID: <200901080002.55603.rjw__15653.9903408431$1231369777$gmane$org@sisk.pl>
References: <200812190049.34343.rjw@sisk.pl> <200901051430.55649.rjw@sisk.pl>
	<20090107223225.GE2101@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090107223225.GE2101@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 January 2009, Pavel Machek wrote:
> On Mon 2009-01-05 14:30:54, Rafael J. Wysocki wrote:
> > On Monday 05 January 2009, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Subject: PCI PM: Avoid touching devices behind bridges in unknown state (rev. 2)
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > It generally is better to avoid accessing devices behind bridges that
> > > > may not be in the D0 power state, because in that case the bridges'
> > > > secondary buses may not be accessible.  For this reason, during the
> > > > early phase of resume (ie. with interrupts disabled), before
> > > > restoring the standard config registers of a device, check the power
> > > > state of the bridge the device is behind and postpone the restoration
> > > > of the device's config space, as well as any other operations that
> > > > would involve accessing the device, if that state is not D0.
> > > 
> > > I'm not sure if this is good idea.
> > > 
> > > Either pci config space needs to be restored early, or it can wait.
> > > 
> > > Sometimes restoring it early and sometimes restoring it late seems
> > > harmful: it will make code harder to understand and harder to test.
> > 
> > Unfortunately, we need to restore it early at least for some devices (bridges
> > and PCI Express ports) and I don't think it is generally safe to go and restore
> > it early for every device (as explained in this changelog).
> 
> Could we make it so that it is restored early exactly on bridges and
> PCIe ports?
> 
> Idea that restore of one specific device is called early or late
> depending if it is connected directly or behind bridge scares me...

There's nothing scary in it IMO and in fact the device's config space is
always restored as soon as reasonably possible.

It will be restored early even if it is behind a bridge, unless that bridge
itself is in a low power state, in which case clearly we _can't_ restore it
early.

Thanks,
Rafael
