From: Greg KH <greg@kroah.com>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 13:22:57 -0700
Message-ID: <20060622202257.GB13736@kroah.com>
References: <20060622184649.GA6768@kroah.com>
	<Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606221505030.5772-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2006 at 03:57:24PM -0400, Alan Stern wrote:
> On Thu, 22 Jun 2006, Greg KH wrote:
> =

> > > There are several possible ways to fix this.  One is to add suspend a=
nd =

> > > resume routines to the endpoint-device driver.  Another is to change =
the =

> > > code that checks for the children being suspended, to make it check o=
nly =

> > > for child USB devices and not child endpoints.
> > =

> > I think it needs to check for _USB_ devices, not just any old device
> > that could possibly be attached to the main USB device (as this one is.)
> > What's to stop any other struct device to bind here and cause the same
> > problem?
> =

> In my upcoming patches for USB core suspend improvements, one of the =

> changes affects this very piece of code.  Instead of looping over all =

> child devices in the driver-model sense, it loops over all interfaces in =

> the active configuration, which is all we care about right here.
> =

> > Ok, the problem is in verify_suspended(), we are not detecting what type
> > of device this is.
> > =

> > Alan, what are you trying to check for here?  What "bogus requests" were
> > you seeing from sysfs that you are trying to filter out?
> =

> I didn't write that routine, Dave Brownell did.  It has been there for
> ages.

Sorry for the misattribution, I should have checked closer.

> The "bogus requests" are attempts by the user to suspend a USB
> device (by writing to /sys/devices/.../power/state) without first
> suspending all its children and interfaces.
> =

> (This can't happen when doing a global suspend because the PM core =

> iterates through the entire device tree.  It matters only for "runtime" o=
r =

> "selective" suspend.)

Then why is people hitting this now?  I guess no one had hooked a struct
device to a struct usb_device before, only interfaces.

> The two easiest ways to fix the problem are:
> =

> 	Change the code to look through the interfaces in the active
> 	configuration instead of using device_for_each_child;

Or at least verify that they are looking at an interface, just blindly
poking at a child device isn't very nice :(

> or
> =

> 	Revert your "endpoints are devices" patch until my upcoming
> 	changes are in place.

I'll work on a fix-up patch based on the first option :)

thanks,

greg k-h
