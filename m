From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: pm_message_t becoming struct
Date: Fri, 25 Mar 2005 12:17:58 +0100
Message-ID: <20050325111758.GC1297@elf.ucw.cz>
References: <20050325101149.GA1301@elf.ucw.cz>
	<Pine.LNX.4.50.0503250223490.28664-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89993996246418106=="
In-Reply-To: <Pine.LNX.4.50.0503250223490.28664-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============89993996246418106==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > pm_message_t is becoming typedefed into struct with single field,
> > "event" real soon now. If you do anything that wants to look inside
> > pm_message_t, please base it on this patch.
> >
> > [Patrick and David would like to pass struct pm_message * instead of
> > pm_message_t, but that just does not fly. Original code passed u32
> > there (ouch), and it is not easy to replace u32 with struct pm_message
> > * and not breaking the whole tree. Plus you do not get enough
> > typechecking that way.]
> 
> There is significant disagreement about the interface that this patch
> proposes from a number of people. About 12 hours ago, Pavel agreed that he
> would not try to push this patch upstream until others had a chance to
> come up with an alternative, more palatable interface. That seems to be in
> direct conflict with this email.

Yes, and then I remembered *all* the reasons why it needs to be
pm_message_t, and decided that I'm not going to wait. My reasons are
summarized in the above paragraph.

[And this was discussed to death half a year ago, only you and David
completely forgot that discussion and I forgot half of it.]

> Pavel, please think about the situation. Just because you think something
> is a good idea and want the patch to go in doesn't mean that everyone else
> does. You must accept the fact that people will disagree with you and that
> some people may want an alternative interface.

In 2.6.11, we had:

static int foo_suspend(struct pci_dev *pdev, u32 state)

. that's wrong. Now we have

static int foo_suspend(struct pci_dev *pdev, pm_message_t state)

, which is slightly better, but people still get it wrong, because
pm_message_t is compatible with u32. Oops. Obvious solution is to make
pm_message_t typedefed into struct, so people can't do the typing
wrong. This is kernel 101.

What you would like to have is

static int foo_suspend(struct pci_dev *pdev, struct pm_message *state)

which I agree is marginally nicer to look at, but still does not
provide enough typechecking and [more importantly] there's no way in
hell we are doing second search and replace over all the drivers.

Yes, you offered auditing all the drivers, but having all the drivers
audited in early 2006 is not really helpfull. Sorry.

								Pavel
PS: This is not "ego" thing. Come up with a patch that has enough
type-checking properties and has even remote chance to be merged in
2.6.13, and I'm happy with that. "Stop development and I'll produce
patch when I'm ready" does not cut it. Sorry.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============89993996246418106==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89993996246418106==--
