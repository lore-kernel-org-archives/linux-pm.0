From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 09:33:48 -0800
Message-ID: <200503240933.49123.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503240838.37628.david-b@pacbell.net>
	<Pine.LNX.4.50.0503240858200.13683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41429255081483918=="
In-Reply-To: <Pine.LNX.4.50.0503240858200.13683-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============41429255081483918==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 March 2005 9:00 am, Patrick Mochel wrote:

> > Other platforms could use the same names differently of course.  Capsule
> > summary, "deep" means there's only a 32KHz clock, while "big" means the
> > 48 MHz one is available to peripherals that need it (UARTs, USB, MMC/SD,
> > camera, and so forth).
> 
> It sounds like they refer to low-power states in which the system is still
> operating, which are distinct from the STD/STR/Standby that we're used to
> that are non-operational low-power states. Is that correct?

Well, _some_ parts of the system are still operating.  But that's
true of STR/Standby too ... some components are operating well
enough to issue wakeup events.  (Even in some STD modes.)  And
return from STR/Standby does't mean all device state is trashed;
those devices don't go "non-operational" as in "reset" either.

It may be fair to say that more parts are more functional though;
making detailed comparisons hasn't been high on my tasklist!

- Dave



--===============41429255081483918==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41429255081483918==--
