From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Sun, 27 Mar 2005 17:18:10 -0500
Message-ID: <1111961891.3503.132.camel@localhost.localdomain>
References: <1111951499.3503.87.camel@localhost.localdomain>
	<20050327210853.GA18358@isilmar.linta.de>
	<1111958844.3503.100.camel@localhost.localdomain>
	<20050327214309.GA18745@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90365046310289454=="
In-Reply-To: <20050327214309.GA18745-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
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

--===============90365046310289454==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-03-27 at 23:43 +0200, Dominik Brodowski wrote:
> On Sun, Mar 27, 2005 at 04:27:24PM -0500, Adam Belay wrote:
> > > extern int device_create_file(struct device *device, struct device_attribute
> > > * entry);
> > > and delete them (e.g. in ->remove) using
> > > extern void device_remove_file(struct device * dev, struct device_attribute
> > > * attr);
> > > 
> > > and there's also 
> > > 
> > > extern int driver_create_file(struct device_driver *, struct
> > > driver_attribute *);
> > > extern void driver_remove_file(struct device_driver *, struct
> > > driver_attribute *);
> > > 
> > > 
> > > 	Dominik
> > 
> > Yes, I'm aware of these functions but they pollute the bus level
> > namespace.  I'm interested in reactions to this alternative approach.  I
> > wanted to explore the possibility of making a device driver instance a
> > separate component with its own individual state and relationships.
> 
> To be honest, I don't consider this to be a pollution of the "bus"
> namespace, but I fear that having two different places for somewhat similar,
> or even equal, data adds unneeded complexity to the driver model. In what
> specific instances has the current design limited or obstructed your
> intentions?
> 

Fair enough.  I just wanted to float this possibility.  I appreciate
your comments.  The original intention for this design was to begin
working on a framework for driver layering.  (ex. snd-intel8x0m -> ac97,
or the pci express bus abstraction)  I was considering the possibility
of having driver devices with parent and child relationships that
reflect the internal layering of Linux drivers.  I haven't really had a
chance to fully develop this idea, so at this point, driver layering and
my original email are just abstract concepts.

Adam



--===============90365046310289454==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90365046310289454==--
