From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 16:18:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503231614580.631-100000@ida.rowland.org>
References: <1111609769.14853.104.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63209543740993346=="
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
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============63209543740993346==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 24 Mar 2005, Nigel Cunningham wrote:

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

David and Patrick are talking about two different things without realizing
it.  Patrick said the _core_ should always call bus->suspend.  Dave said
the _parent/bridge/bus_ doesn't have to call driver->suspend.  Both can be 
correct.

Alan Stern


--===============63209543740993346==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63209543740993346==--
