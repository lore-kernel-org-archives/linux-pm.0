From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: pm_message_t becoming struct
Date: Fri, 25 Mar 2005 10:51:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503251049000.1207-100000@ida.rowland.org>
References: <20050325152332.GA3738@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35382171518276762=="
In-Reply-To: <20050325152332.GA3738-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============35382171518276762==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 25 Mar 2005, Pavel Machek wrote:

> > Are you willing to go halfway?  If we do something more like this:
> > 
> > 	typedef struct {
> > 		struct pm_message *m;
> > 	} pm_message_t;
> > 
> > then the code can pass pm_message_t's around with full type-checking and
> > still retain the benefit of sending a pointer rather than a structure.
> > 
> > Yes, it looks stupid.  But it's a reasonable compromise that won't
> 
> I'm afraid it really looks stupid. [It actually has benefit that we
> _could_ go over tree in future and change pm_message_t into struct
> pm_message *.]
> 
> OTOH we would probably be stuck with this stupid-looking-thing
> forever, and I'd really prefer to avoid that.

Understandably.  But looking stupid in public is not as bad as bickering 
among ourselves and not getting anything done.  Especially if it smooths 
the path toward making future improvements.

Alan Stern


--===============35382171518276762==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35382171518276762==--
