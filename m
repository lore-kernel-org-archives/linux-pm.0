From: Thomas Voegtle <tv@lio96.de>
Subject: Re: 2.6.23-rc2 swsusp, suddenly increased uptime
Date: Mon, 13 Aug 2007 23:31:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708132325580.29791__46727.8604898185$1187042413$gmane$org@er-systems.de>
References: <Pine.LNX.4.63.0708122137130.25343@er-systems.de>
	<200708132306.27587.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="425052808-1259902182-1187040698=:29791"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708132306.27587.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Voegtle <tv@lio96.de>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--425052808-1259902182-1187040698=:29791
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp2.linux-foundation.org id l7DLxVAo000723

On Mon, 13 Aug 2007, Rafael J. Wysocki wrote:

> On Sunday, 12 August 2007 21:39, Thomas Voegtle wrote:
> >=20
> > Hi,
> >=20
> > today I saw this (output from my suspend script):
> >=20
> > -> woke up at Sun Aug 12 11:39:17 CEST 2007
> > -> uptime is
> >  11:39am  up 8 days  0:41,  10 users,  load average: 26.12, 6.35, 2.1=
7
> >=20
> >=20
> > Then I did a software suspend. After waking up, I saw this:
> >=20
> >=20
> > -> woke up at Sun Aug 12 14:41:56 CEST 2007
> > -> uptime is
> >   2:41pm  up 44 days  9:11,  12 users,  load average: 35.17, 9.17, 3.=
33

I just want to add, I built 2.6.23-rc2 on Aug 4th and this happened on Au=
g=20
12 and I suspend once a day. And the only thing which was odd was the=20
uptime, nothing else.

I rebooted with 2.6.23-rc3 today, so the odd uptime is gone.
Should I try 8 suspend cycles or something to reproduce it again?

=20
> Can you please boot the kernel in the minimal configuration (init=3D/bi=
n/bash)
> and try to hibernate, ie.
>=20
> # mount /proc
> # mount /sys
> # swapon -a
> # echo disk > /sys/power/state
>=20
> Also, please check if anything changes if you do
>=20
> # echo shutdown > /sys/power/disk
>=20
> before the last command above.

I did, but what could change? I did not see anything, nothing dmesg, no=20
odd uptime etc.

      Thomas

--=20
 Thomas V=F6gtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
--425052808-1259902182-1187040698=:29791
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--425052808-1259902182-1187040698=:29791--
