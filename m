From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Re: The evilness of struct
	usb_device->auto_pm
Date: Fri, 28 Sep 2007 15:41:50 +0200
Message-ID: <200709281541.50632.oliver__29596.0678639405$1190986960$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0709271202150.7735-100000@iolanthe.rowland.org>
	<200709280904.17314.oliver@neukum.org>
	<200709281525.54410.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709281525.54410.rjw@sisk.pl>
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

Am Freitag 28 September 2007 schrieb Rafael J. Wysocki:
> On Friday, 28 September 2007 09:04, Oliver Neukum wrote:
> > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > On Thursday, 27 September 2007 21:59, Oliver Neukum wrote:
> > > > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > > > On Thursday, 27 September 2007 21:37, Oliver Neukum wrote:
> > > > > > Am Donnerstag 27 September 2007 schrieb Rafael J. Wysocki:
> > > > > > > > But there's a problem, in that the resume methods don't t=
ake a message=20
> > > > > > > > parameter. =A0So they wouldn't know whether they were doi=
ng a runtime=20
> > > > > > > > resume or a system resume.
> > > > > > >=20
> > > > > > > This is a general problem with the .resume() routines.
> > > > > > >=20
> > > > > > > If you want to use one for runtime resume, the driver needs=
 to preserve
> > > > > > > information allowing it to figure out what kind of resume i=
s going to happen.
> > > > > >=20
> > > > > > How? Suppose you
> > > > > >=20
> > > > > > 1) runtime suspend
> > > > > > 2) whole system suspend
> > > > > > 3) whole system resume
> > > > > >=20
> > > > > > What kind of resume do you do?
> > > > >=20
> > > > > System resume, I'd guess.
> > > >=20
> > > > How do you know unless resume() tells you to do so?
> > > >=20
> > > > > Anyway, if we are going to stop using the freezer during suspen=
d, the locking
> > > > > requirements will probably have to unified between the runtime =
and system
> > > > > suspend.
> > > >=20
> > > > Even so, eg. for storage devices you should unquiesce them in cas=
e of runtime
> > > > suspend, which makes no sense otherwise.
> > >=20
> > > OK
> > >=20
> > > What exactly would you like to do?
> >=20
> > Put the stuff into struct device and move the autosuspend code into
> > driver core.
>=20
> Well, I thought that it would be nicer if drivers handled autosuspend i=
n a
> transparent (from the point of view of the core) way.

That is possible only for drivers which are leaves in the device tree.

> Now, it seems to follow from what you're saying that this is not possib=
le in
> general, because of USB mass storage devices that need some special han=
dling.

No, they need the ordinary handling. All a device's children must be susp=
ended
if a device is suspended.

> I'm not familiar with the USB code, so can you please tell me how the U=
SB
> autosuspend is handled at present and what exactly the problem with tha=
t is?

The drivers for interfaces manage a count. If all a device's interfaces' =
count
goes to zero, the device is suspended. The drivers are notified through t=
he
normal suspend() method. But children of these devices are not notified.

	Regards
		Oliver
