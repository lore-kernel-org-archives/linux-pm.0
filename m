From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 22:08:35 +0100
Message-ID: <20050323210835.GF30704@elf.ucw.cz>
References: <1111113131.25179.73.camel@gaston>
	<200503231146.17105.david-b@pacbell.net>
	<200503231153.48230.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22722195658700642=="
In-Reply-To: <200503231153.48230.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

--===============22722195658700642==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Thing is, it's the system power states that are placing clock
> > constraints on devices.  On OMAP, going into "deep sleep" means
> > you've got to stop using the 48 MHz clock.  For "big sleep",
> > you can keep using that clock.  Most other CPUs have similar
> > constraints:  multiple system states, defined primarily by
> > clock usage.  
> 
> 
> So to focus on one point:  "pm_message_t" doesn't work well
> at all, since it doesn't have a way to identify the target
> system power state, and drivers thus have no way to see if
> they should drop their requests for those clocks or whether
> the hardware should keep working away.

Well, in current model, drivers shoudl stop all the activity they can
("deep sleep"). If you want to add support for "big sleep", then you
should probably use flags... I guess calling "big sleep" standby is
okay...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============22722195658700642==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22722195658700642==--
