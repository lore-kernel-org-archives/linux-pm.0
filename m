From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 16:27:24 -0500
Message-ID: <1111958844.3503.100.camel@localhost.localdomain>
References: <1111951499.3503.87.camel@localhost.localdomain>
	<20050327210853.GA18358@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3746823647676456=="
In-Reply-To: <20050327210853.GA18358-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============3746823647676456==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-03-27 at 23:08 +0200, Dominik Brodowski wrote:
> On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> > One of the original design goals of sysfs was to provide a standardized
> > location to keep driver configuration attributes.  Although sysfs
> > handles this very well for bus devices and class devices, there isn't
> > currently a method to export attributes for device drivers and their
> > specific bound device instances to userspace.

You're right, I should have worded this differently.

> 
> Drivers can add (e.g. in ->probe) attributes for devices using
> extern int device_create_file(struct device *device, struct device_attribute
> * entry);
> and delete them (e.g. in ->remove) using
> extern void device_remove_file(struct device * dev, struct device_attribute
> * attr);
> 
> and there's also 
> 
> extern int driver_create_file(struct device_driver *, struct
> driver_attribute *);
> extern void driver_remove_file(struct device_driver *, struct
> driver_attribute *);
> 
> 
> 	Dominik

Yes, I'm aware of these functions but they pollute the bus level
namespace.  I'm interested in reactions to this alternative approach.  I
wanted to explore the possibility of making a device driver instance a
separate component with its own individual state and relationships.

Adam



--===============3746823647676456==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3746823647676456==--
