From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 11:11:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709281109170.4062-100000__35837.9964986399$1190992358$gmane$org@iolanthe.rowland.org>
References: <200709281712.35721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709281712.35721.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Sep 2007, Rafael J. Wysocki wrote:

> > That's because the notifications go up the device tree, not down.  When 
> > a child is suspended, the parent is notified.  Then if the driver sees 
> > that all the children are suspended, the parent can be suspended as 
> > well.
> > 
> > Oliver has been trying to subvert this model by making usb-storage 
> > responsible for suspending the SCSI disk and CD/DVD drivers, which are 
> > located beneath it in the device tree.  I've been trying to convince 
> > him that the proper way to handle things is to let the SCSI drivers 
> > decide for themselves when their devices can be suspended, and then 
> > have them inform usb-storage.
> 
> Yes, I think that the SCSI layer should decide.
> 
> I guess that the SCSI layer is not really autosuspend-aware, is it?

Not yet.  I would like it to become autosuspend-aware.  Oliver wants to
avoid that by keeping all the awareness in usb-storage.  (But then what
about all the other SCSI host-adapter drivers?  Will they each have
their own way of deciding when a SCSI device can be suspended?)

Alan Stern
