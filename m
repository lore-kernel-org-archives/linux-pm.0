From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 22:00:12 +0100
Message-ID: <20050323210012.GD30704@elf.ucw.cz>
References: <20050321202016.GI1390@elf.ucw.cz>
	<Pine.LNX.4.44L0.0503211613010.2329-100000@ida.rowland.org>
	<20050321222609.GK1390@elf.ucw.cz>
	<200503231032.36164.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============024314457580720372=="
In-Reply-To: <200503231032.36164.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============024314457580720372==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > 	pm_message_t		power_state;
> > > > > 
> > > > > Obviously a message isn't the same thing as a state.  This looks like 
> > > > > something that will need to be changed in a lot of drivers when we 
> > > > > introduce the new notion of a power state.
> > > > 
> > > > This is not so obvious to me. 
> 
> It's a semantics thing, among others.  "System transitioning to
> state Z" is a message, as is "system leaving state Z".  Both are
> distinct from the "system state Z" being described.

But that does not mean you can't use same type for both.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============024314457580720372==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============024314457580720372==--
