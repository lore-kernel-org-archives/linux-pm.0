From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 14:24:59 -0500
Message-ID: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96492938753714608=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============96492938753714608==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

One of the original design goals of sysfs was to provide a standardized
location to keep driver configuration attributes.  Although sysfs
handles this very well for bus devices and class devices, there isn't
currently a method to export attributes for device drivers and their
specific bound device instances to userspace.

I would like to propose that we create a new type of device that would
act as the layer between physical (bus devices) and logical (class
devices).  It could be referred to as a "driver device".  Driver devices
would bind to a bus devices and create one or more class devices.  Their
type would be of "struct device_driver".  As an example, this would
allow us to move something like /proc/driver/emu10k1/0000:01:09.0 into
sysfs.

(physical)	     |		  (logical)
------------------------------------------------
|bus device -->	driver device --> class device |
------------------------------------------------

struct driver_device {
	struct list_head node;
	unsigned long id;
	struct kobject kobj;
	struct device_driver *drv;
	struct device *dev;
	int state;
};

In sysfs, a new directory could be created to represent driver devices.
It might look like the following:

bus
|
\- pci
 |
 \- devices
  |
  \- link to device0
  \- link to device1
 \- drivers
  |
  \- link to random_drv (in other words random_drv can drive this bus)

device
|
\- device0
[...]
\- device1
[...]

driver (this directory is new)
|
\- random_drv
 |
 \- 0 (a sequential instance number) <-- this is a driver device
  |
  \- link to device0
  \- link to class0
  \- a file to control driver state (start, stop, etc.)
  \- driver attributes for this link
 \- 1
  |
  \- link to device1
  \- link to class1
  \- a file to control driver state
  \- driver attributes for this link

class
|
\-some_type
 |
 \- class0
[...]
 \- class1
[...]

This would allow us to represent per-device driver attributes in sysfs.
As an added benefit, driver devices would allow the tracking and control
of driver state, which may be needed for dynamic power management.  I
look forward to any comments.

Thanks,
Adam



--===============96492938753714608==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96492938753714608==--
