From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 08:44:02 -0500 (CDT)
Message-ID: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: "Rafael J. Wysocki"'s message of Thu, 22 Mar 2007 00:32:24 +0100
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, linux-arm@lists.arm.linux.org.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org


| From: "Rafael J. Wysocki" <rjw@sisk.pl>
| =

| On Wednesday, 21 March 2007 23:57, Pavel Machek wrote:
| > Hi!
| > =

| > > > Which is very much an indication of how weak ACPI is.  It
| > > > doesn't contemplate typical SOC behavior, which have a wide
| > > > variety of system sleep states that leave the CPU on ... and
| > > > which may not even *have* (or need!) a "cpu off" state.
| > > > =

| > > > My own definition would be more like:  the minimal RAM-based
| > > > power-saving system state is "standby".  If the system
| > > > implements a deeper RAM-based system sleep state, that's "STR".
| > > =

| > > Hmmm, this leaves the decision how to call each state COMPLETELY to t=
he =

| > > implementor, doesn't it?
| > =

| > Is that a problem? If someone is clever enough to implement suspend, I
| > think we can trust them to name their states right.
| > =

| > (And trust me, we can flame them if not).
| > =

| > (Anyway, my definition would be "mem" =3D=3D RAM is powered, everything
| > else is down, except for devices needed for wakeup; "standby" =3D=3D
| > something is powered that can be powered down, we'll fix that in next v=
ersion).
| =

| I think we can define "standby" a bit more precisely.  Something like:
| - processes are frozen,
| - devices are suspended,
| - nonboot CPUs are down (and in low powered states, if possible),
| - "system" devices may or may not be suspended, depending on the platform,
| - the boot CPU may or may not be in a low power state, depending on the p=
latform,
| - RAM is powered
| - wake up need not be BIOS-driven (main difference from "mem")
---

I would be tempted to say that that last bullet is the distinguishing
characteristic - that you come back from standby by just continuing
where you left off, but you come back from StR by something akin to
booting.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
