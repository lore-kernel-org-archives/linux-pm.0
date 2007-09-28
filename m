From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 22:29:06 +0200
Message-ID: <200709282229.06825.rjw__6213.9609981843$1191010525$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709281109170.4062-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709281109170.4062-100000@iolanthe.rowland.org>
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

On Friday, 28 September 2007 17:11, Alan Stern wrote:
> On Fri, 28 Sep 2007, Rafael J. Wysocki wrote:
> 
> > > That's because the notifications go up the device tree, not down.  When 
> > > a child is suspended, the parent is notified.  Then if the driver sees 
> > > that all the children are suspended, the parent can be suspended as 
> > > well.
> > > 
> > > Oliver has been trying to subvert this model by making usb-storage 
> > > responsible for suspending the SCSI disk and CD/DVD drivers, which are 
> > > located beneath it in the device tree.  I've been trying to convince 
> > > him that the proper way to handle things is to let the SCSI drivers 
> > > decide for themselves when their devices can be suspended, and then 
> > > have them inform usb-storage.
> > 
> > Yes, I think that the SCSI layer should decide.
> > 
> > I guess that the SCSI layer is not really autosuspend-aware, is it?
> 
> Not yet.  I would like it to become autosuspend-aware.  Oliver wants to
> avoid that by keeping all the awareness in usb-storage.  (But then what
> about all the other SCSI host-adapter drivers?  Will they each have
> their own way of deciding when a SCSI device can be suspended?)

IMO, this is a more general issue.

The problem, as I see it, is which layer of drivers should be responsible of
making autosuspend decisions if there are many layers stacked on top of one
another.

I think that it should be the layer which communicates with processes, eg. via
syscalls.

Greetings,
Rafael
