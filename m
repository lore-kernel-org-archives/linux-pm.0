From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 17:12:34 +0200
Message-ID: <200709281712.35721.rjw__10976.4310800985$1190991560$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709281011540.4062-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709281011540.4062-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Friday, 28 September 2007 16:33, Alan Stern wrote:
> On Fri, 28 Sep 2007, Oliver Neukum wrote:
> 
> > > > > What exactly would you like to do?
> > > > 
> > > > Put the stuff into struct device and move the autosuspend code into
> > > > driver core.
> 
> Moving some of the data fields might be acceptable.  Moving the code is 
> premature at best.  You must always bear in mind that the autosuspend 
> model used by USB is not suitable for every type of device.  Each 
> subsystem needs to implement its own form of runtime PM; the core 
> should contain only the lowest-denominator common parts.

Well, that's what I've been always thinking.

> > > Well, I thought that it would be nicer if drivers handled autosuspend in a
> > > transparent (from the point of view of the core) way.
> > 
> > That is possible only for drivers which are leaves in the device tree.
> 
> Not true.  For example, the USB hub driver handles autosuspend 
> perfectly well.  The main issue is what to do when the autosuspend 
> notifications need to cross a subsystem boundary.
> 
> > > Now, it seems to follow from what you're saying that this is not possible in
> > > general, because of USB mass storage devices that need some special handling.
> > 
> > No, they need the ordinary handling. All a device's children must be suspended
> > if a device is suspended.
> > 
> > > I'm not familiar with the USB code, so can you please tell me how the USB
> > > autosuspend is handled at present and what exactly the problem with that is?
> > 
> > The drivers for interfaces manage a count. If all a device's interfaces' count
> > goes to zero, the device is suspended. The drivers are notified through the
> > normal suspend() method. But children of these devices are not notified.
> 
> That's because the notifications go up the device tree, not down.  When 
> a child is suspended, the parent is notified.  Then if the driver sees 
> that all the children are suspended, the parent can be suspended as 
> well.
> 
> Oliver has been trying to subvert this model by making usb-storage 
> responsible for suspending the SCSI disk and CD/DVD drivers, which are 
> located beneath it in the device tree.  I've been trying to convince 
> him that the proper way to handle things is to let the SCSI drivers 
> decide for themselves when their devices can be suspended, and then 
> have them inform usb-storage.

Yes, I think that the SCSI layer should decide.

I guess that the SCSI layer is not really autosuspend-aware, is it?

Greetings,
Rafael
