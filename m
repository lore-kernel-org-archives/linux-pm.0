From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: pm_message_t becoming struct
Date: Fri, 25 Mar 2005 10:12:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503251004490.1094-100000@ida.rowland.org>
References: <20050325111758.GC1297@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26673912095987218=="
In-Reply-To: <20050325111758.GC1297-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============26673912095987218==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 25 Mar 2005, Pavel Machek wrote:

> In 2.6.11, we had:
> 
> static int foo_suspend(struct pci_dev *pdev, u32 state)
> 
> . that's wrong. Now we have
> 
> static int foo_suspend(struct pci_dev *pdev, pm_message_t state)
> 
> , which is slightly better, but people still get it wrong, because
> pm_message_t is compatible with u32. Oops. Obvious solution is to make
> pm_message_t typedefed into struct, so people can't do the typing
> wrong. This is kernel 101.
> 
> What you would like to have is
> 
> static int foo_suspend(struct pci_dev *pdev, struct pm_message *state)
> 
> which I agree is marginally nicer to look at, but still does not
> provide enough typechecking and [more importantly] there's no way in
> hell we are doing second search and replace over all the drivers.

Are you willing to go halfway?  If we do something more like this:

	typedef struct {
		struct pm_message *m;
	} pm_message_t;

then the code can pass pm_message_t's around with full type-checking and
still retain the benefit of sending a pointer rather than a structure.

Yes, it looks stupid.  But it's a reasonable compromise that won't require 
changing the prototypes of a million drivers.  (You could make it look a 
little less stupid by changing the name of struct pm_message -- a minor 
detail.)

It _will_ require auditing for drivers that store the message as their 
state, which is maybe just about as hard.  However almost everyone agrees 
that using a message to represent a state is a bad thing to do.  The 
simplest way to fix it would be to store message.m->event as the state 
instead of message itself.

Alan Stern


--===============26673912095987218==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26673912095987218==--
