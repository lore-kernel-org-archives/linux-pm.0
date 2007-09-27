From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Thu, 27 Sep 2007 22:08:25 +0200
Message-ID: <200709272208.26178.rjw__4669.89105702869$1190922898$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
	<200709272145.00092.rjw@sisk.pl>
	<200709272137.02169.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709272137.02169.oliver@neukum.org>
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

On Thursday, 27 September 2007 21:37, Oliver Neukum wrote:
> Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > But there's a problem, in that the resume methods don't take a mess=
age=20
> > > parameter. =A0So they wouldn't know whether they were doing a runti=
me=20
> > > resume or a system resume.
> >=20
> > This is a general problem with the .resume() routines.
> >=20
> > If you want to use one for runtime resume, the driver needs to preser=
ve
> > information allowing it to figure out what kind of resume is going to=
 happen.
>=20
> How? Suppose you
>=20
> 1) runtime suspend
> 2) whole system suspend
> 3) whole system resume
>=20
> What kind of resume do you do?

System resume, I'd guess.

Anyway, if we are going to stop using the freezer during suspend, the loc=
king
requirements will probably have to unified between the runtime and system
suspend.

Greetings,
Rafael
