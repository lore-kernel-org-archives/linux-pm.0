From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 23:43:09 +0200
Message-ID: <20050327214309.GA18745@isilmar.linta.de>
References: <1111951499.3503.87.camel@localhost.localdomain>
	<20050327210853.GA18358@isilmar.linta.de>
	<1111958844.3503.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12870877635692213=="
In-Reply-To: <1111958844.3503.100.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

--===============12870877635692213==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 27, 2005 at 04:27:24PM -0500, Adam Belay wrote:
> > extern int device_create_file(struct device *device, struct device_attribute
> > * entry);
> > and delete them (e.g. in ->remove) using
> > extern void device_remove_file(struct device * dev, struct device_attribute
> > * attr);
> > 
> > and there's also 
> > 
> > extern int driver_create_file(struct device_driver *, struct
> > driver_attribute *);
> > extern void driver_remove_file(struct device_driver *, struct
> > driver_attribute *);
> > 
> > 
> > 	Dominik
> 
> Yes, I'm aware of these functions but they pollute the bus level
> namespace.  I'm interested in reactions to this alternative approach.  I
> wanted to explore the possibility of making a device driver instance a
> separate component with its own individual state and relationships.

To be honest, I don't consider this to be a pollution of the "bus"
namespace, but I fear that having two different places for somewhat similar,
or even equal, data adds unneeded complexity to the driver model. In what
specific instances has the current design limited or obstructed your
intentions?

	Dominik

--===============12870877635692213==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12870877635692213==--
