From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] Driver States
Date: Sun, 27 Mar 2005 17:42:47 -0500
Message-ID: <1111963367.3503.152.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0042420405956784535=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============0042420405956784535==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dynamic power management may require devices and drivers to transition
between various physical and logical states.  I would like to start a
discussion on how these might be defined at the bus, driver, and class
levels.

Bus Level
=========
At the bus level, there are two state attributes, power and
enable/disable.  Enable/disable may mean different things on different
buses, but they generally refer to resource decoding.  A device can only
be enabled during a non-off power state.

A possible API:

struct bus_type {
	char			* name;

	struct subsystem	subsys;
	struct kset		drivers;
	struct kset		devices;

	struct bus_attribute	* bus_attrs;
	struct device_attribute	* dev_attrs;
	struct driver_attribute	* drv_attrs;

	int		(*match)(struct device * dev, struct device_driver * drv);
	int		(*hotplug) (struct device *dev, char **envp, 
				    int num_envp, char *buffer, int buffer_size);
	int		(*suspend)(struct device * dev, pm_message_t state);
	int		(*resume)(struct device * dev);
	int		(*enable)(struct device * dev);
	int		(*disable)(struct device * dev);
};

Driver Level
============
At the driver level there are two areas of interest, physical and
logical state.  There is an additional concern of transitioning between
these states multiple times.  Because a driver acts as a bridge between
physical and logical components, I think separating these steps seems
natural.

A possible API:

struct device_driver {
	char			* name;
	struct bus_type		* bus;

	struct semaphore	unload_sem;
	struct kobject		kobj;
	struct list_head	devices;

	struct module 		* owner;

	int	(*attach)	(struct device * dev);
	int	(*start)	(struct device * dev);
	int	(*open)		(struct device * dev);
	int	(*close)	(struct device * dev);
	void 	(*stop)		(struct device * dev);
	void	(*detach)	(struct device * dev);
	void	(*shutdown)	(struct device * dev);
	int	(*suspend)	(struct device * dev, u32 state, u32 level);
	int	(*resume)	(struct device * dev, u32 level);
};

*attach - allocates data structures, creates sysfs entries, prepares driver
       to handle the hardware.
 
*start -  Sets up device resources and configures the hardware.  Loads
firmware, etc.
(physical)
 
*open -   engages the hardware, and makes it usable by the class device.
(logical and physical)
 
*close -  disengages the hardware, and stops class level access
(logical and physical)
 
*stop -   physically disables the hardware
(physical)
 
*detach - tears down the driver and releases it from the "struct device"

The idea behind *attach and *detach is to move code that would only need
to be called once out of *probe and *remove.

A table could be defined that indicates what should be called for each
power level transition.  *suspend and *resume could handle any extra
steps (ex. saving state).  As an example, *start and *stop may only be
called when power is going to be lost entirely.

Additional states are class specific and would only be used after *open
is called.

Class Level
===========
At the class level, we could have a simple start/stop mechanism.

A possible API:

struct class_device {
	struct list_head	node;

	struct kobject		kobj;
	struct class		* class;
	struct device		* dev;
	void			* class_data;

	char	class_id[BUS_ID_SIZE];

	int	(*attach)	(struct device * dev);
	int	(*start)	(struct device * dev);
	void 	(*stop)		(struct device * dev);
	void	(*detach)	(struct device * dev);
};

*attach - allocates data structures, creates sysfs entries, prepares
class to handle the device.

*start - start the logical class device, accept userspace interaction

*stop - stop the logical class device, deny userspace interaction

*detach - tear down the class driver's bindings with this class device


These are just rough ideas.  I look forward to any comments or
alternative approaches.

Thanks,
Adam



--===============0042420405956784535==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0042420405956784535==--
