From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Thu, 17 Mar 2005 09:52:47 +0100
Message-ID: <20050317085247.GA6719@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503162259320.7210-100000@netrider.rowland.org>
	<1111034693.3240.92.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40798101687630872=="
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
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============40798101687630872==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j2H8rAqh020374

On =C4=8Ct 17-03-05 15:44:53, Nigel Cunningham wrote:
> Hi.
>=20
> On Thu, 2005-03-17 at 15:11, Alan Stern wrote:
> > On Wed, 16 Mar 2005, David Brownell wrote:
> >=20
> > > > Wether the system IRQs must be masked or not is one thing that is
> > > > platform specific during suspend. Wether devices must stop their =
IRQ
> > > > emission, well...=20
> > >=20
> > > What's a "system IRQ" as opposed to any other kind?  Drivers don't
> > > generally know or care how their IRQs are routed, they just care
> > > that they get a callback.
> >=20
> > Given that on some platforms it's necessary to leave some IRQs enable=
d for=20
> > remote wakeup to work, the definitions of FREEZE and SUSPEND need to =
be=20
> > changed.  A quiesced device does not perform DMA and does not generat=
e=20
> > interrupt requests _except_ that it may issue wakeup requests (which =
may=20
> > be IRQs) if it is enabled for remote wakeup.
>=20
> I don't think the definition of FREEZE needs to be changed because -
> unless I misunderstand - it is only used when swsusp and Suspend2 are
> doing their atomic copies. Pavel, is this right?

Yes, I think so.
								Pavel

--=20
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============40798101687630872==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============40798101687630872==--
