From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 11:07:07 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006021059150.2933__12136.7950727747$1275469812$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-305410675-1275469630=:2933"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-305410675-1275469630=:2933
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o5297PiJ022681

On Wed, 2 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/2 Thomas Gleixner <tglx@linutronix.de>:
> > On Tue, 1 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> >>
> >> Because suspend itself causes you to not be idle you cannot abort
> >> suspend just because you are not idle anymore.
> >
> > You still are addicted to the current suspend mechanism. :)
> >
>=20
> No I want you to stop confusing low power idle modes with suspend. I
> know how to enter low power modes from idle if that low power mode is
> not too disruptive.

What prevents us from going into a disruptive mode from idle ? I don't
see a reason - except crappy ACPI stuff, which I'm happy to ignore.

> > If I understood you correctly then you can shutdown the CPU in idle
> > completelty already, but that's not enough due to:
> >
> > =A0 =A01) crappy applications keeping the cpu away from idle
> > =A0 =A02) timers firing
> >
> > Would solving those two issues be sufficient for you or am I missing
> > something ?
>=20
> Solving those two is enough for current android phones, but it may not
> be enough for other android devices.

In which way ? May not be enough is a pretty vague statement.

> 1 is not solvable (meaning we cannot fix all apps),

We can mitigate it with cgroups and confine crap there, i.e. force
idle them.

> and 2 is difficult to fix since the periodic
> work is useful while the device is actually in use. One possible way
> to solve 2 is to allow timers on a not-idle clock.

That's what I had in mind.

> Unrelated to Android, I also want to use opportunistic suspend on my
> desktop.

I expect that intel/amd fixing their stuff is going to happen way
before we sprinkled suspend blockers over a full featured desktop
distro.

Thanks,

	tglx
--8323328-305410675-1275469630=:2933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-305410675-1275469630=:2933--
