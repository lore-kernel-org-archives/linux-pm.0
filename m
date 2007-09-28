From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 15:25:53 +0200
Message-ID: <200709281525.54410.rjw__3239.8963151083$1190985160$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
	<200709272220.20503.rjw@sisk.pl>
	<200709280904.17314.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709280904.17314.oliver@neukum.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Friday, 28 September 2007 09:04, Oliver Neukum wrote:
> Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > On Thursday, 27 September 2007 21:59, Oliver Neukum wrote:
> > > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > > On Thursday, 27 September 2007 21:37, Oliver Neukum wrote:
> > > > > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > > > > > But there's a problem, in that the resume methods don't tak=
e a message=20
> > > > > > > parameter. =A0So they wouldn't know whether they were doing=
 a runtime=20
> > > > > > > resume or a system resume.
> > > > > >=20
> > > > > > This is a general problem with the .resume() routines.
> > > > > >=20
> > > > > > If you want to use one for runtime resume, the driver needs t=
o preserve
> > > > > > information allowing it to figure out what kind of resume is =
going to happen.
> > > > >=20
> > > > > How? Suppose you
> > > > >=20
> > > > > 1) runtime suspend
> > > > > 2) whole system suspend
> > > > > 3) whole system resume
> > > > >=20
> > > > > What kind of resume do you do?
> > > >=20
> > > > System resume, I'd guess.
> > >=20
> > > How do you know unless resume() tells you to do so?
> > >=20
> > > > Anyway, if we are going to stop using the freezer during suspend,=
 the locking
> > > > requirements will probably have to unified between the runtime an=
d system
> > > > suspend.
> > >=20
> > > Even so, eg. for storage devices you should unquiesce them in case =
of runtime
> > > suspend, which makes no sense otherwise.
> >=20
> > OK
> >=20
> > What exactly would you like to do?
>=20
> Put the stuff into struct device and move the autosuspend code into
> driver core.

Well, I thought that it would be nicer if drivers handled autosuspend in =
a
transparent (from the point of view of the core) way.

Now, it seems to follow from what you're saying that this is not possible=
 in
general, because of USB mass storage devices that need some special handl=
ing.

I'm not familiar with the USB code, so can you please tell me how the USB
autosuspend is handled at present and what exactly the problem with that =
is?

Greetings,
Rafael
