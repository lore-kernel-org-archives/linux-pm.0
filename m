From: =?iso-8859-1?Q?Lu=EDs?= Henriques <luis.henriques@canonical.com>
Subject: Re: [stable request <=3.7] acpi-cpufreq: set current frequency based
 on target P-State
Date: Mon, 31 Mar 2014 09:50:17 +0100
Message-ID: <20140331085017.GA5042@hercules>
References: <20131220081912.GA13684@hobo.Home>
 <1395785057-28903-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395785057-28903-1-git-send-email-vlee@twopensource.com>
Sender: cpufreq-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Ross Lagerwall <rosslagerwall@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 25, 2014 at 03:04:16PM -0700, Vinson Lee wrote:
> Hi.
>=20
> Please backport upstream commit 8673b83bf2f013379453b4779047bf3c6ae38=
7e4=20
> "acpi-cpufreq: set current frequency based on target P-State" to stab=
le=20
> kernels 3.7 and earlier. This patch enables the kernel to control=20
> P-states on several platforms. Without this patch, the kernel was una=
ble=20
> to control P-states on the same platforms.
>=20
> The upstream patch cleanly applies to 3.7.
>=20
> A backported patch is needed with the removal of SYSTEM_AMD_MSR_CAPAB=
LE=20
> for kernels 3.6 and earlier.
>=20

Thank you, I'm queuing this backport to the 3.5 kernel.

Cheers,
--
Lu=EDs

> Cheers,
> Vinson
>=20
>=20
> Ross Lagerwall (1):
>   acpi-cpufreq: set current frequency based on target P-State
>=20
>  drivers/cpufreq/acpi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --=20
> 1.8.3.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
