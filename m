From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: comments on irc log
Date: Fri, 18 Mar 2005 19:14:52 +0100
Message-ID: <20050318181452.GE18427@elf.ucw.cz>
References: <1111113131.25179.73.camel@gaston>
	<Pine.LNX.4.44L0.0503181147110.1099-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2461129074005064=="
In-Reply-To: <Pine.LNX.4.44L0.0503181147110.1099-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============2461129074005064==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I have this crazy idea that we could have a single "new" enter_state(), and keep
> > suspend/resume for system state transitions.
> > 
> > Basically, my idea there is that enter_state() is the actual low level driver
> > state change function. It is called when userland picks a state in sysfs, or
> > we could deal with the various bus state dependencies if we want etc...
> > 
> > We could keep suspend/resume separate for the system-wide suspend, and have
> > them implement the policy of converting a system wide suspend/resume into the
> > appropriate enter_state() for the driver.
> > 
> > "Old" or "Simple" drivers would just suspend/resume and not implement
> > enter_state, more complex/subtle drivers would do the above.
> > 
> > I haven't quite thought out the implications, it's just an idea that came to mind
> > as I was reading the log...
> 
> This sounds like a reasonable thing to do.  We do need distinct ways to
> tell drivers "Go to this system state" and "Go to this bus/device state".  
> Whether they are implemented by 1, 2, or 3 different callbacks doesn't
> really matter (except that we might want to minimize the number of 
> function pointers stored in the driver structures).

Actually you want to re-use existing suspend-to-ram code in drivers as
much as possible.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============2461129074005064==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2461129074005064==--
