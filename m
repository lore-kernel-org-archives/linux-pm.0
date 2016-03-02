From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Wed, 2 Mar 2016 08:08:22 +0530
Message-ID: <20160302023822.GM16437@vireshk-i7>
References: <1456778205-19197-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160301022830.GX2791@vireshk-i7>
 <1456855841.21069.59.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34598 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbcCBCif (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 21:38:35 -0500
Received: by mail-pa0-f53.google.com with SMTP id fy10so123180113pac.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 18:38:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456855841.21069.59.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 01-03-16, 10:10, Srinivas Pandruvada wrote:
> > What about:
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0acpi_cpufreq_attr[ARRAY_SIZE(acpi_cpu
> > freq_attr) - 2] =3D &base_frequency;
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0and a comment to describe that ?
> >=20
> Will it work in this case?
> "
> Even if CONFIG_X86_ACPI_CPUFREQ_CPB is defined,=A0
> acpi_cpufreq_attr[2] will be set to NULL in the init callback when
> some condition fails. So we will have a NULL in the acpi_cpufreq_attr=
[]
> before &base_frequency if we add at fixed place.=A0
> "

Oh dude, you already have this hack in place in a different way. Though=
 its
doable this way:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpuf=
req.c
index 51eef87bbc37..26c026a34e1e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -937,7 +937,7 @@ static void acpi_cpufreq_boost_exit(void)
=20
 static int __init acpi_cpufreq_init(void)
 {
-       int ret;
+       int ret, cpb_removed =3D 0;
=20
        if (acpi_disabled)
                return -ENODEV;
@@ -967,6 +967,7 @@ static int __init acpi_cpufreq_init(void)
                for (attr =3D acpi_cpufreq_attr; *attr; attr++)
                        if (*attr =3D=3D &cpb) {
                                *attr =3D NULL;
+                               cpb_removed =3D 1;
                                break;
                        }
        }

And then the above statement:

acpi_cpufreq_attr[ARRAY_SIZE(acpi_cpufreq_attr) - 2 - cpb_removed] =3D =
&base_frequency;

But I would rather add another patch first to set the CPB thing in the =
array to
NULL and remove the ifdef from within the array. And then set it to a v=
alid
attribute only if we are making an addition. And then you can easily ke=
ep a
count of the next NULL entry you can update.

--=20
viresh
