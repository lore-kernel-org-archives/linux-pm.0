From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 10:20:28 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71622644511113975=="
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

--===============71622644511113975==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:

>
> > Just to clarify, are you suggesting that the functional (not necesarily
> > literal) steps to fully suspend a device during a system state transition
> > are first to 'suspend' it, preventing it from being used and accessed or
> > being suspended/resumed from userpsace; then to have it directly enter a
> > low power state (e.g. via an enter_state() method)?
>
> At the system level, low power state must be entered atomically with the
> actual suspending of the driver. That is, when suspend() has returned,
> th device must be sleeping. That is necessary for the good old reason
> that once the parent is asleep, no way you can talk to your device.

I wasn't disputing that. What I was trying to say was the core could
effectively do:

	for each device {
		device->suspend();	/* Stop Device */
		device->enter_state();	/* Power Down */
	}

The reason I'm going down this road is because I think it could possibly
be split into such a way like this:

	device->class->stop(dev, system_state);
	device->bus->save_state(dev, system_state);
	device->bus->enter_state(dev, system_state);


The first would perform functional-level suspension - stopping current
transactions and preventing future ones.

The second would call down to the device driver and save the device
context for the system state being entered.

The third would call down to the device driver and actually enter the low
power state.

Functionally, this is what happens. Do you see a reason to/not to break it
up programmatically?

...


Too many subjects in 1 email. Snipping and replying separately. :)


	Pat


--===============71622644511113975==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71622644511113975==--
