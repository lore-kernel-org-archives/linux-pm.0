From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 10:59:10 +0100
Message-ID: <20050324095910.GD1354@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231724100.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11618048187356456=="
In-Reply-To: <Pine.LNX.4.50.0503231724100.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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

--===============11618048187356456==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > Note that rather than enter_state, I'd rather just have a function
> > > > pointer enter_this_state in the driver state array ...
> > >
> > > Wouldn't that imply a different ->enter_state() method for each system
> > > state?
> >
> > one enter state method for each driver state. If the driver has one
> > enter state for each system state, then go for it.
> 
> Two things:
> 
> 1) I meant just 1 ->enter_state() entry point for the core to call. It
> won't call a different function depending on the state; it will leave it
> up to the driver to determine what state to enter/what function to call.
> Internally (or in its bus core), is where the array of enter_state()
> methods would reside. Do you agree?
> 
> 2) The system states are totally dependent on the platform. I don't see
> how we could have a sane array that encapsulates every possible system
> state. Thoughts?

Seems to me that suspend-to-RAM and suspend-to-DISK make sense, and
cover 90% of what people want to do. Add "standby" for "fast
suspend-to-RAM" and you cover even ARM. I'd say that's good enuogh.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============11618048187356456==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11618048187356456==--
