From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 13:22:07 +1100
Message-ID: <1111630927.16224.163.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231727220.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============038389627281401495=="
In-Reply-To: <Pine.LNX.4.50.0503231727220.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============038389627281401495==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I'm talking about an array of device states the device supports. They
> would be exporting them to userspace for the purpose of device power
> management. While it's related to the device states a driver supports,
> it's not exactly the same thing.

I would have a single array. Just use a flag in there to mark the ones
that are visible to userspace.

> You want to expose only the mutual set of those sets (the states the
> device and the driver both support) on a per-device basis. The easiest way
> to do that would be with a per-device array. You could do it with a
> per-driver array, but in the case where a driver supports different revs
> of a chip with different power management capabilities, you'd have to
> constantly check what rev of the chip you're using..

Too many arrays, we are going to complicate the driver-side of the model
too much. I'm thinking more about an array that can be pointed to
statically from the driver structure (which is usually static as well).
This is important for a reason: Devices may be added to a part of the
tree that is in a low power state. So the actual "state" upon probe() is
_not_ necessarily the "main" power state. The core must be able to
resolve the state dependency at device add time before probe I think, or
at least know what value to put in "current state" before probe(), so
the driver can eventually try to clamp the state up on the parent if it
needs more power to initialize itself.

Something like

struct pm_state_list my_states = {
	{ "running", PM_STATE_USER, .... <whatever else> },
	{ "snoozing", PM_STATE_USER, .... <whatever else> },
	{ "suspended", PM_STATE_USER, .... <whatever else> },
};

struct pci_driver my_driver = {
   .../...
   dev.pm_states = &my_states;
};

The above array is just a random example, we definitely have to work
more on the defintion of a state. In that example, we have the state
name and a flags word, PM_STATE_USER indicating the state can be set by
the user.

Ben.



--===============038389627281401495==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============038389627281401495==--
