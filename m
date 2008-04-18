From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 23:30:39 +0200
Message-ID: <200804182330.40530.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
	<200804182238.45512.rjw@sisk.pl> <20080418212348.GA14992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418212348.GA14992@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 18 of April 2008, Greg KH wrote:
> On Fri, Apr 18, 2008 at 10:38:44PM +0200, Rafael J. Wysocki wrote:
> > On Friday, 18 of April 2008, Rafael J. Wysocki wrote:
> > > On Friday, 18 of April 2008, Rafael J. Wysocki wrote:
> > > > On Friday, 18 of April 2008, Alan Stern wrote:
> > > > > On Thu, 17 Apr 2008, Andrew Morton wrote:
> > > > > 
> > > > > > But this:
> > > > > > 
> > > > > > <cold boot>
> > > > > > <suspend-to-ram>
> > > > > > <resume-from-ram>
> > > > > > <suspend-to-disk>
> > > > > > <resume-from-disk>
> > > > > > 
> > > > > > hangs at the end of resume-from-disk.
> > > > > > 
> > > > > > 
> > > > > > During the suspend-to-disk I saw:
> > > > > > 
> > > > > > ipw2200: Radio Frequency Kill Switch is On:
> > > > > > Kill switch must be turned off for wireless networking to work.
> > > > > > PM: Device usb1 failed to (unknown PM event): error -113
> > > > > > PM: Device usb2 failed to (unknown PM event): error -113
> > > > > > PM: Device usb3 failed to (unknown PM event): error -113
> > > > > > PM: Device usb4 failed to (unknown PM event): error -113
> > > > > 
> > > > > These -113 errors can be ignored.  They are fallout from the recent 
> > > > > conversion of the driver core's suspend/resume API.  Matching changes 
> > > > > have not yet been added to the USB core.
> > > > > 
> > > > > The "(unknown PM event)" strings look like a bug, though.
> > > > 
> > > > Yes, it does.
> > > > 
> > > > I'm trying to figure this out.
> > > 
> > > This particular problem should be fixed by the appended patch.
> > 
> > The following patch is also necessary to make hibernation work as documented
> > in pm.h.
> > 
> > Thanks,
> > Rafael
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make hibernation work as documented in include/linux/pm.h .
> > 
> > In pm.h it is documented that device_power_up() and device_resume()
> > will be called with PMSG_RECOVER if the creation of a hibernation
> > image fails or the restoration of memory contents from a
> > hibernation image fails.  Otherwise, it should be called either
> > with PMSG_THAW or with PMSG_RESTORE, depending on the context.
> > Make that happen.
> 
> Should either of these patches be merged / added to the ones you sent me
> before?

Yes, both of them, please.

Thanks,
Rafael
