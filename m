From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 12:55:55 -0800
Message-ID: <200503231255.55686.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503231106.03160.david-b@pacbell.net>
	<1111609769.14853.104.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86838429514228554=="
In-Reply-To: <1111609769.14853.104.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============86838429514228554==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 12:29 pm, Nigel Cunningham wrote:
> Hi
> 
> On Thu, 2005-03-24 at 06:06, David Brownell wrote:
> > On Tuesday 22 March 2005 4:52 pm, Patrick Mochel wrote:
> > > > 
> > > I think the core should always call ->suspend() for a device, regardless
> > > of whether it thinks it's in a low power state, or inactive. This is
> > > specifically for the reason that a device could be a low-power runtime
> > > state when the system is suspended.
> > 
> > I don't quite see a need for this.  If the parent/bridge driver knows
> > the device is adequately suspended, why kick it again?  It's actually
> > rather annoying -- and error/bug prone! -- to have to code drivers to
> > detect and cope with superfluous suspend calls.
> 
> I would think it would be simpler not to have the parent/bridge check
> whether the device is already suspended, and to just have all the logic
> that decides what to do in the driver. I'm only thinking intuitively,
> but it sounds like that should help with avoiding race conditions.

Maybe the solution should involve a parent/child handshake; that'd
be the place to address potential races, and it could include the
notification folk seem to want.  

You're suggesting a tradeoff which shifts work from the bridges,
which won't be numerous, to the drivers, which will be.  I still
don't see a need to do that, and I'd rather take opportunities to
make the drivers simpler.

- Dave

--===============86838429514228554==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86838429514228554==--
