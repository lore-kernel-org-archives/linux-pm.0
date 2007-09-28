From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 09:04:16 +0200
Message-ID: <200709280904.17314.oliver__29276.052353862$1190963154$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
	<200709272159.11731.oliver@neukum.org>
	<200709272220.20503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709272220.20503.rjw@sisk.pl>
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
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> On Thursday, 27 September 2007 21:59, Oliver Neukum wrote:
> > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > On Thursday, 27 September 2007 21:37, Oliver Neukum wrote:
> > > > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > > > > But there's a problem, in that the resume methods don't take =
a message=20
> > > > > > parameter. =A0So they wouldn't know whether they were doing a=
 runtime=20
> > > > > > resume or a system resume.
> > > > >=20
> > > > > This is a general problem with the .resume() routines.
> > > > >=20
> > > > > If you want to use one for runtime resume, the driver needs to =
preserve
> > > > > information allowing it to figure out what kind of resume is go=
ing to happen.
> > > >=20
> > > > How? Suppose you
> > > >=20
> > > > 1) runtime suspend
> > > > 2) whole system suspend
> > > > 3) whole system resume
> > > >=20
> > > > What kind of resume do you do?
> > >=20
> > > System resume, I'd guess.
> >=20
> > How do you know unless resume() tells you to do so?
> >=20
> > > Anyway, if we are going to stop using the freezer during suspend, t=
he locking
> > > requirements will probably have to unified between the runtime and =
system
> > > suspend.
> >=20
> > Even so, eg. for storage devices you should unquiesce them in case of=
 runtime
> > suspend, which makes no sense otherwise.
>=20
> OK
>=20
> What exactly would you like to do?

Put the stuff into struct device and move the autosuspend code into
driver core.

	Regards
		Oliver
