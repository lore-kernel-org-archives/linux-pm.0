From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 17:41:35 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231727220.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14360020361801906=="
In-Reply-To: <1111548664.16201.63.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============14360020361801906==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:

> > When a driver is bound to a device, it will modify the static array as
> > necessary (removing dangerous states, and changing the method pointers),
> > and it will fill in the pointer for device/driver specific states.
>
> The driver just exposes it's array that gets attached to struct device.
> No need to "modify" an existing array or whatever. In 99.9% of the
> states, the array will just be a static structure in the driver.

I'm talking about an array of device states the device supports. They
would be exporting them to userspace for the purpose of device power
management. While it's related to the device states a driver supports,
it's not exactly the same thing.

You want to expose only the mutual set of those sets (the states the
device and the driver both support) on a per-device basis. The easiest way
to do that would be with a per-device array. You could do it with a
per-driver array, but in the case where a driver supports different revs
of a chip with different power management capabilities, you'd have to
constantly check what rev of the chip you're using..


	Pat

--===============14360020361801906==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14360020361801906==--
