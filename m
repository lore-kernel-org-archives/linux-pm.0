From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpuidle: big_little: Fix build error
Date: Tue, 29 Jul 2014 00:00:19 +0200
Message-ID: <1636644.mn4hD5sirK@vostro.rjw.lan>
References: <1406523539-23823-1-git-send-email-sachin.kamat@samsung.com> <53D5EB46.7070606@linaro.org> <CAK5sBcFiEaK_zvifq24gQ9uPLOF_mtQo4n9R7_fBnk82gL8qQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54438 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750708AbaG1Vls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 17:41:48 -0400
In-Reply-To: <CAK5sBcFiEaK_zvifq24gQ9uPLOF_mtQo4n9R7_fBnk82gL8qQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <spk.linux@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Monday, July 28, 2014 11:51:09 AM Sachin Kamat wrote:
> Hi Daniel,
>=20
> On Mon, Jul 28, 2014 at 11:48 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > On 07/28/2014 06:58 AM, Sachin Kamat wrote:
> >>
> >> big_little CPU idle driver references functions defined in MCPM dr=
iver.
> >> Thus make it depend on MCPM to avoid the following errors:
> >>
> >> drivers/built-in.o: In function `bl_enter_powerdown':
> >> drivers/cpuidle/cpuidle-big_little.c:134: undefined reference to
> >> `mcpm_cpu_powered_up'
> >> drivers/built-in.o: In function `bl_powerdown_finisher':
> >> drivers/cpuidle/cpuidle-big_little.c:104: undefined reference to
> >> `mcpm_set_entry_vector'
> >> drivers/cpuidle/cpuidle-big_little.c:111: undefined reference to
> >> `mcpm_cpu_suspend'
> >> make: *** [vmlinux] Error 1
> >>
> >> Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> >> ---
> >>   drivers/cpuidle/Kconfig.arm | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig=
=2Earm
> >> index 33fc0ff..38cff69 100644
> >> --- a/drivers/cpuidle/Kconfig.arm
> >> +++ b/drivers/cpuidle/Kconfig.arm
> >> @@ -4,6 +4,7 @@
> >>   config ARM_BIG_LITTLE_CPUIDLE
> >>         bool "Support for ARM big.LITTLE processors"
> >>         depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
> >> +       depends on MCPM
> >>         select ARM_CPU_SUSPEND
> >>         select CPU_IDLE_MULTIPLE_DRIVERS
> >>         help
> >
> >
> > Hi Sachin,
> >
> > thanks for the fix. Arnd sent the same fix a couple of weeks ago.
>=20
> Oh great. Perhaps it hasn't hit the linux-next tree yet.

No, it hasn't and I can't find it in the linux-pm archives.

I'll queue up your patch, thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
