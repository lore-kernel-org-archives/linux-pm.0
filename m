From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: pm_message_t becoming struct
Date: Fri, 25 Mar 2005 16:23:32 +0100
Message-ID: <20050325152332.GA3738@elf.ucw.cz>
References: <20050325111758.GC1297@elf.ucw.cz>
	<Pine.LNX.4.44L0.0503251004490.1094-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57656404685751483=="
In-Reply-To: <Pine.LNX.4.44L0.0503251004490.1094-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============57656404685751483==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > static int foo_suspend(struct pci_dev *pdev, u32 state)
> > 
> > . that's wrong. Now we have
> > 
> > static int foo_suspend(struct pci_dev *pdev, pm_message_t state)
> > 
> > , which is slightly better, but people still get it wrong, because
> > pm_message_t is compatible with u32. Oops. Obvious solution is to make
> > pm_message_t typedefed into struct, so people can't do the typing
> > wrong. This is kernel 101.
> > 
> > What you would like to have is
> > 
> > static int foo_suspend(struct pci_dev *pdev, struct pm_message *state)
> > 
> > which I agree is marginally nicer to look at, but still does not
> > provide enough typechecking and [more importantly] there's no way in
> > hell we are doing second search and replace over all the drivers.
> 
> Are you willing to go halfway?  If we do something more like this:
> 
> 	typedef struct {
> 		struct pm_message *m;
> 	} pm_message_t;
> 
> then the code can pass pm_message_t's around with full type-checking and
> still retain the benefit of sending a pointer rather than a structure.
> 
> Yes, it looks stupid.  But it's a reasonable compromise that won't

I'm afraid it really looks stupid. [It actually has benefit that we
_could_ go over tree in future and change pm_message_t into struct
pm_message *.]

OTOH we would probably be stuck with this stupid-looking-thing
forever, and I'd really prefer to avoid that.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============57656404685751483==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57656404685751483==--
