From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 10:14:15 +1100
Message-ID: <1111619655.16201.98.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62286952746654056=="
In-Reply-To: <Pine.LNX.4.50.0503231008340.17099-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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

--===============62286952746654056==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-23 at 10:20 -0800, Patrick Mochel wrote:

> I wasn't disputing that. What I was trying to say was the core could
> effectively do:
> 
> 	for each device {
> 		device->suspend();	/* Stop Device */
> 		device->enter_state();	/* Power Down */
> 	}

Where is room in the above for suspend() to be the one deciding what
state to enter ? suspend() has no way to do it with your example. I'd
rather have suspend optionally call device_enter_state() itself (and not
device->enter_state if we decide to have a function pointer per state in
the state array, those won't be pointers in struct device, which is
probably better since enter_state() would end up just switch/casing on
them anyway).

> The reason I'm going down this road is because I think it could possibly
> be split into such a way like this:
> 
> 	device->class->stop(dev, system_state);
> 	device->bus->save_state(dev, system_state);
> 	device->bus->enter_state(dev, system_state);
> 
> 
> The first would perform functional-level suspension - stopping current
> transactions and preventing future ones.

It's up to the driver's suspend() to do those. I would keep that policy
in there, really. I agree that a class->stop() may be useful for putting
the "common" code, but I'd rather have it seen as a "helper" that the
driver can call.

> The second would call down to the device driver and save the device
> context for the system state being entered.
> 
> The third would call down to the device driver and actually enter the low
> power state.

save_state would be nop most of the time. enter_state may have to save
things too... I think the distinction between those is very academic and
makes little sense in practice.

> Functionally, this is what happens. Do you see a reason to/not to break it
> up programmatically?

Because I think it's a lot more flexible not to do it :) That is,
breaking it up _imposes_ a structure on driver that I'd rather avoid in
this case. Just let them have suspend(), that can eventually use the
state mecanism and maybe a class "stop" helper, but some drivers will
want to do tricks etc... or do things before stopping the class, you
can't even imagine now :) So I'd rather not have the core do that.

Ben.



--===============62286952746654056==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62286952746654056==--
