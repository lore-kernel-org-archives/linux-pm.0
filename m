From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 07:29:29 +1100
Message-ID: <1111609769.14853.104.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<200503231106.03160.david-b@pacbell.net>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43329857856673026=="
In-Reply-To: <200503231106.03160.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============43329857856673026==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Thu, 2005-03-24 at 06:06, David Brownell wrote:
> On Tuesday 22 March 2005 4:52 pm, Patrick Mochel wrote:
> > > 
> > I think the core should always call ->suspend() for a device, regardless
> > of whether it thinks it's in a low power state, or inactive. This is
> > specifically for the reason that a device could be a low-power runtime
> > state when the system is suspended.
> 
> I don't quite see a need for this.  If the parent/bridge driver knows
> the device is adequately suspended, why kick it again?  It's actually
> rather annoying -- and error/bug prone! -- to have to code drivers to
> detect and cope with superfluous suspend calls.

I would think it would be simpler not to have the parent/bridge check
whether the device is already suspended, and to just have all the logic
that decides what to do in the driver. I'm only thinking intuitively,
but it sounds like that should help with avoiding race conditions.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============43329857856673026==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43329857856673026==--
