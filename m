From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Tue, 14 Jul 2015 01:26:28 +0200
Message-ID: <1591472.jfYRX9HXXv@vostro.rjw.lan>
References: <559F5D13.8050104@intel.com> <CAJZ5v0jwgtgC+01p8f5a7amPcTGUfps5f2Ph9rtt77=3BEk5Cg@mail.gmail.com> <55A35BA4.8020800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64009 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751491AbbGMW7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 18:59:53 -0400
In-Reply-To: <55A35BA4.8020800@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On Monday, July 13, 2015 02:33:08 PM Pan Xinhui wrote:
> hi, Rafeal
> 	thanks for your reply. :)
>=20
> On 2015=E5=B9=B407=E6=9C=8811=E6=97=A5 04:44, Rafael J. Wysocki wrote=
:
> > Hi,
> >=20
> > On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel.com>=
 wrote:
> >>
> >> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placehold=
er for
> >> cpb is not needed. Add ifdef around it.
> >>
> >> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> >> ---
> >>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi=
-cpufreq.c
> >> index e7fcaa6..314a19e 100644
> >> --- a/drivers/cpufreq/acpi-cpufreq.c
> >> +++ b/drivers/cpufreq/acpi-cpufreq.c
> >> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufreq_=
policy *policy)
> >>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
> >>         &cpufreq_freq_attr_scaling_available_freqs,
> >>         &freqdomain_cpus,
> >> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> >>         NULL,   /* this is a placeholder for cpb, do not remove */
> >> +#endif
> >=20
> > Adding the ifdef here doesn't change anything, because the next NUL=
L
> > will play the role of the one you've just #ifdefed and the structur=
e
> > will be filled with zeros from that point on anyway.
> >=20
> Yes, adding ifdef here does not change any binary codes. But I want t=
o make the codes more readable. :)
> Patch author has noticed two *NULL* here would confuse people, especi=
ally who first read this acpi-cpufreq.c file
> From code style point, it would be better to have #ifdef around it.=20

Not really.

Why don't you simply drop *both* NULLs?


>=20
> > You'd need to #ifdef it in the struct freq_attr definition, but I'm
> > not sure it's worth the effort.
> >=20
>=20
> struct freq_attr *cpb* is defined in #ifdef section. :)

Ah, OK.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
