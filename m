From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at
	fault?
Date: Tue, 29 Mar 2005 23:44:08 +0200
Message-ID: <20050329214408.GH8125@elf.ucw.cz>
References: <4243D854.2010506@suse.de>
	<d120d50005032908183b2f622e@mail.gmail.com>
	<20050329181831.GB8125@elf.ucw.cz>
	<d120d50005032911114fd2ea32@mail.gmail.com>
	<20050329192339.GE8125@elf.ucw.cz>
	<d120d50005032912051fee6e91@mail.gmail.com>
	<20050329205225.GF8125@elf.ucw.cz>
	<d120d500050329130714e1daaf@mail.gmail.com>
	<20050329211239.GG8125@elf.ucw.cz>
	<d120d50005032913331be39802@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d120d50005032913331be39802-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Isaacson <adi-3HqRAUrWAWyGglJvpFV4uA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On =DAt 29-03-05 16:33:04, Dmitry Torokhov wrote:
> On Tue, 29 Mar 2005 23:12:39 +0200, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:
> > >
> > > I am leaning towards calling disable_usermodehelper (not writtent y=
et)
> > > after swsusp completes snapshotting memory. We really don't care ab=
out
> > > hotplug events in this case and this will allow keeping "normal"
> > > resume in drivers as is. What do you think?
> >=20
> > That would certianly do the trick.
> >=20
> > [Or perhaps in_suspend() is slightly nicer solution? People wanted it
> > for other stuff (sanity checking, like BUG_ON(in_suspend())), too....=
]
> >=20
>=20
> We might want having both... Hmm... in_suspend - is it only for swsusp
> (in_swsusp) or for suspend-to-ram as well? For suspend to ram we might
> need slightly different rules, I don't know. A separate call will
> allow more fine-grained control and will explicitely tell reader what
> is happening.

We currently freeze processes for suspend-to-ram, too. I guess that
disable_usermodehelper is probably better and that in_suspend() should
only be used for sanity checks... go with disable_usermodehelper and
sorry for the noise.
								Pavel
--=20
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
