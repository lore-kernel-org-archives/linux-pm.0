From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Wed, 16 Mar 2005 21:58:02 -0800
Message-ID: <200503162158.03005.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503162259320.7210-100000@netrider.rowland.org>
	<1111034693.3240.92.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53400726997690828=="
In-Reply-To: <1111034693.3240.92.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============53400726997690828==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 March 2005 8:44 pm, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-03-17 at 15:11, Alan Stern wrote:
> > On Wed, 16 Mar 2005, David Brownell wrote:
> > 
> > > > Wether the system IRQs must be masked or not is one thing that is
> > > > platform specific during suspend. Wether devices must stop their IRQ
> > > > emission, well... 
> > > 
> > > What's a "system IRQ" as opposed to any other kind?  Drivers don't
> > > generally know or care how their IRQs are routed, they just care
> > > that they get a callback.
> > 
> > Given that on some platforms it's necessary to leave some IRQs enabled for 
> > remote wakeup to work, the definitions of FREEZE and SUSPEND need to be 
> > changed.  A quiesced device does not perform DMA and does not generate 
> > interrupt requests _except_ that it may issue wakeup requests (which may 
> > be IRQs) if it is enabled for remote wakeup.
> 
> I don't think the definition of FREEZE needs to be changed because -
> unless I misunderstand - it is only used when swsusp and Suspend2 are
> doing their atomic copies. Pavel, is this right?

FWIW this is another case where I think things become clearer if the
model is that swsusp and suspend2 aren't really "suspend/resume", but
are checkpoint-before-poweroff.  If they were really suspend states
(and maybe S4 counts as one of those, on hardware that handles it),
then wakeup would need to work ... otherwise, just say that from the
instant swsusp/suspend2 starts, wakeup is disallowed.

- Dave


--===============53400726997690828==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53400726997690828==--
