From: David Zeuthen <davidz-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: suspend/resume uevents [was Re: Introducing HAL
	userspace power management]
Date: Fri, 11 Mar 2005 11:04:58 -0500
Message-ID: <1110557099.4203.19.camel@daxter.boston.redhat.com>
References: <Pine.LNX.4.44L0.0503071125001.1378-100000@ida.rowland.org>
	<1110411138.7779.86.camel@daxter.boston.redhat.com>
	<20050309233556.GO17034@elf.ucw.cz>
	<1110426926.3443.3.camel@daxter.boston.redhat.com>
	<20050310095629.GA13444@elf.ucw.cz>
	<1110476278.3404.60.camel@daxter.boston.redhat.com>
	<20050310211320.GG632@openzaurus.ucw.cz>
	<1110490939.3404.84.camel@daxter.boston.redhat.com>
	<20050310230745.GC10954@elf.ucw.cz>
	<1110518935.4512.14.camel@daxter.boston.redhat.com>
	<20050311084158.GA1705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79910795236066745=="
In-Reply-To: <20050311084158.GA1705-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: seife-l3A5Bk7waGM@public.gmane.org, linux-pm <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============79910795236066745==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j2BG3Hqi016796

On Fri, 2005-03-11 at 09:41 +0100, Pavel Machek wrote:
> On P=C3=A1 11-03-05 00:28:55, David Zeuthen wrote:
> > On Fri, 2005-03-11 at 00:07 +0100, Pavel Machek wrote:
> > > > I was merely asking for an event when the system is resumed.
> > > >=20
> > > > I agree it doesn't make much sense for an event just before the s=
ystem
> > > > is suspended - if this is needed I believe we can orchestrate it
> > > > completely from user space (things like making your email app
> > > > synchronize etc. comes to mind).
> > >=20
> > > You can have event when the system is resumed. Just do it in usersp=
ace.
> > >=20
> >=20
> > Maybe I'm reading the source wrong, but isn't it the case that some
> > laptops using APM (my IBM thinkpad T41 with acpi=3Doff for instance)
> > suspends without user space interaction when the lid is closed, thus
> > rendering it impossible to send the event from user space?=20
> >=20
> > One may even ask whether it's sound to assume that all architectures
> > will be suspended via user space?
>=20
> Some machines will suspend without even telling operating system
> anything.
>=20
> For APM case, yes some kind of notification makes sense (I thought we
> were talking ACPI/swsusp here).
>=20

Oh, I thought the kernel was moving towards presenting user space with
an abstract interface much like /sys/power/state; that would definitely
be easier on user space (we don't have to add new code for every PM
framework), but I do understand if you don't want to do this as it have
negative consequences. But at least some form of feature parity across
different PM frameworks would be nice (e.g. if you make APM resume send
an event, do the same for ACPI and PMU) because in many ways user space
do have to design for lowest common denominator when abstracting this.

> > > . I'm *not* going to do that from kernel. But standartizing what ne=
eds
> > > to be ran on resume is indeed good idea, and few lines in
> > > Documentation/power/* are probably worth it.
> > >=20
> >=20
> > There's a very practical problem of getting all distributions to
> > actually do this.
>=20
> Where doing it kernel means we have to do it right..
>=20

I understand that, yes.

> > Another point is that user space may just use a timer and look at the
> > wall clock to determine when a suspend happens, but that's hardly an
> > elegant architecture. It does save some discussion, though, either wa=
y
> > I'll be quiet now and leave you guys to do real work :-)
>=20
> Well, if you propose reasonable way to notify userspace, you can get
> it at least for APM case... So do not drop quiet just now.

I'm not a kernel hacker, sorry, my best bet would be using the
kobject_uevent stuff (since that is used for other notifications) but I
don't really grok all the locking and synchronization needed to do this
right without races / deadlocks.

I was just adding to this thread because Alan asked what user space
would like to see :-)

Cheers,
David



--===============79910795236066745==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============79910795236066745==--
