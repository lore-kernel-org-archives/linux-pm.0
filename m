From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 17:27:19 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231724100.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33193300055407837=="
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

--===============33193300055407837==
Content-Type: TEXT/PLAIN; charset=US-ASCII


[ Short replies, to prevent some messiness. ]

On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:

> > > Note that rather than enter_state, I'd rather just have a function
> > > pointer enter_this_state in the driver state array ...
> >
> > Wouldn't that imply a different ->enter_state() method for each system
> > state?
>
> one enter state method for each driver state. If the driver has one
> enter state for each system state, then go for it.

Two things:

1) I meant just 1 ->enter_state() entry point for the core to call. It
won't call a different function depending on the state; it will leave it
up to the driver to determine what state to enter/what function to call.
Internally (or in its bus core), is where the array of enter_state()
methods would reside. Do you agree?

2) The system states are totally dependent on the platform. I don't see
how we could have a sane array that encapsulates every possible system
state. Thoughts?


	Pat

--===============33193300055407837==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33193300055407837==--
