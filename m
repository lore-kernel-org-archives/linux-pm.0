From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 23:08:53 +0200
Message-ID: <20050327210853.GA18358@isilmar.linta.de>
References: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77426151591190107=="
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

--===============77426151591190107==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> One of the original design goals of sysfs was to provide a standardized
> location to keep driver configuration attributes.  Although sysfs
> handles this very well for bus devices and class devices, there isn't
> currently a method to export attributes for device drivers and their
> specific bound device instances to userspace.

Drivers can add (e.g. in ->probe) attributes for devices using
extern int device_create_file(struct device *device, struct device_attribute
* entry);
and delete them (e.g. in ->remove) using
extern void device_remove_file(struct device * dev, struct device_attribute
* attr);

and there's also 

extern int driver_create_file(struct device_driver *, struct
driver_attribute *);
extern void driver_remove_file(struct device_driver *, struct
driver_attribute *);


	Dominik

--===============77426151591190107==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77426151591190107==--
