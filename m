From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Mon, 28 Mar 2005 21:03:45 -0800
Message-ID: <20050329050345.GB7937@kroah.com>
References: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39481292961803982=="
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
In-Reply-To: <1111951499.3503.87.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============39481292961803982==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> One of the original design goals of sysfs was to provide a standardized
> location to keep driver configuration attributes.  Although sysfs
> handles this very well for bus devices and class devices, there isn't
> currently a method to export attributes for device drivers and their
> specific bound device instances to userspace.

Hm, what's device_create_file(), device_remove_file(), and DEVICE_ATTR()
for?  A number of drivers use these functions today to add their own
driver specific attributes to a device they control.

Then, userspace can just do a simple:
	ls /sys/bus/pci/drivers/my_foo_driver/
to see all devices on the PCI bus that are controlled by that driver.
Then it can go into those directories and cat out the specific
information if needed.

Is there something that is lacking in the current code that you would
like to see present?  I don't think that adding another layer on top of
a device would help out much here.

thanks,

greg k-h

--===============39481292961803982==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39481292961803982==--
