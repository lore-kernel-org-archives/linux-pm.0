From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCI PM: Read device power state from
	register after updating it
Date: Thu, 11 Jun 2009 21:53:16 +0200
Message-ID: <200906112153.16853.rjw__16677.3822544657$1244750013$gmane$org@sisk.pl>
References: <200905182246.41129.rjw@sisk.pl> <200905262152.29489.rjw@sisk.pl>
	<20090611115458.66650e04@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090611115458.66650e04@jbarnes-g45>
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
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 11 June 2009, Jesse Barnes wrote:
> On Tue, 26 May 2009 21:52:29 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Monday 18 May 2009, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > After attempting to change the power state of a PCI device
> > > pci_raw_set_power_state() doesn't check if the value it wrote into
> > > the device's PCI_PM_CTRL register has been stored in there.  Still,
> > > it modifies the device's current_state field as though that's the
> > > case.  This may cause the driver of the device to think that its
> > > power state has been changed while in fact it hasn't.
> > > 
> > > To prevent such situations from happening modify
> > > pci_raw_set_power_state() so that it reads the device's PCI_PM_CTRL
> > > register after writing into it and uses the value read from the
> > > register to update the device's current_state field.  Also make it
> > > return -EIO if the new state of the device is not equal to the state
> > > requested by the called.
> > > 
> > > To distinguish this error condition from the other ones make
> > > pci_raw_set_power_state() return -ENOSYS instead of -EIO when it is
> > > impossible to change the power state of the device, because it
> > > doesn't support the native PCI PM at all or the requested target
> > > state is not supported by it.
> > 
> > Having reconsidered it I think that -ENODEV is probably better than
> > -ENOSYS for this purpose.  Updated patch follows.
> 
> Applied to linux-next, thanks Rafael.

Please drop.  It has been reported by Jiri to cause a regression to happen.

Best,
Rafael
