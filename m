From: Adrian Huang <adrian.huang@hp.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Thu, 31 Oct 2013 14:59:19 +0800
Message-ID: <1383202759.2487.5.camel@adrian-F6S>
References: <1382952130.4419.10.camel@adrian-F6S>
	 <2180132.nWVXASx7r4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:14564 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab3JaG70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 02:59:26 -0400
In-Reply-To: <2180132.nWVXASx7r4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com

Will re-send it later. Sorry about that.=20

=E6=96=BC =E4=B8=89=EF=BC=8C2013-10-30 =E6=96=BC 23:06 +0100=EF=BC=8CRa=
fael J. Wysocki =E6=8F=90=E5=88=B0=EF=BC=9A=20
> On Monday, October 28, 2013 05:22:10 PM Adrian Huang wrote:
> > This patch minimizes indentation levels and re-defines some local v=
ariables.
>=20
> Care to add changelog describing what changes are made by the patch a=
nd why?
>=20
> > Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> > ---
> > Changes since v1:
> >  * Minimize indentation levels (Commented by Rafael)
> >  * Re-define some local variables (Commented by Rafael)
> >  * Return -ENODEV if platform FW has power management modes (Commen=
ted by Dirk)
> >=20
> >  drivers/cpufreq/intel_pstate.c | 70 ++++++++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 70 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel=
_pstate.c
> > index eb3fdc7..8770d67 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -26,6 +26,8 @@
> >  #include <linux/fs.h>
> >  #include <linux/debugfs.h>
> >  #include <trace/events/power.h>
> > +#include <linux/acpi.h>
> > +#include <acpi/processor.h>
> > =20
> >  #include <asm/div64.h>
> >  #include <asm/msr.h>
> > @@ -129,6 +131,18 @@ static struct perf_limits limits =3D {
> >  	.max_sysfs_pct =3D 100,
> >  };
> > =20
> > +struct hw_vendor_info {
> > +	u16  valid;
> > +	char oem_id[ACPI_OEM_ID_SIZE];
> > +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> > +};
> > +
> > +/* Hardware vendor-specific info that has its own power management=
 modes */
> > +static struct hw_vendor_info vendor_info[] =3D {
> > +	{1, "HP    ", "ProLiant"},
> > +	{0, "", ""},
> > +};
> > +
> >  static inline void pid_reset(struct _pid *pid, int setpoint, int b=
usy,
> >  			int deadband, int integral) {
> >  	pid->setpoint =3D setpoint;
> > @@ -698,6 +712,55 @@ static int intel_pstate_msrs_not_valid(void)
> > =20
> >  	return 0;
> >  }
> > +
> > +static bool intel_pstate_no_acpi_pss(void)
> > +{
> > +	int i;
> > +
> > +	for_each_possible_cpu(i) {
> > +		acpi_status status =3D AE_OK;
> > +		struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > +		struct acpi_processor *pr =3D per_cpu(processors, i);
> > +		union acpi_object *pss =3D NULL;
> > +
> > +		if (!pr)
> > +			continue;
> > +
> > +		status =3D acpi_evaluate_object(pr->handle, "_PSS",
> > +					      NULL, &buffer);
> > +		if (ACPI_FAILURE(status))
> > +			continue;
> > +
> > +		pss =3D buffer.pointer;
> > +		if (pss && (pss->type =3D=3D ACPI_TYPE_PACKAGE)) {
> > +			kfree(buffer.pointer);
> > +			return false;
> > +		}
> > +
> > +		kfree(buffer.pointer);
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static bool intel_pstate_platform_pwr_mgmt_exists(void)
> > +{
> > +	struct acpi_table_header hdr;
> > +	struct hw_vendor_info *v_info;
> > +
> > +	if (ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)))
> > +		return false;
> > +
> > +	for (v_info =3D vendor_info; v_info->valid; v_info++) {
> > +		if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
> > +		    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OEM=
_TABLE_ID_SIZE)
> > +		    && intel_pstate_no_acpi_pss())
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static int __init intel_pstate_init(void)
> >  {
> >  	int cpu, rc =3D 0;
> > @@ -706,6 +769,13 @@ static int __init intel_pstate_init(void)
> >  	if (no_load)
> >  		return -ENODEV;
> > =20
> > +	/*
> > +	 * The Intel pstate driver will be ignored if the platform
> > +	 * firmware has its own power management modes.
> > +	 */
> > +	if (!acpi_disabled && intel_pstate_platform_pwr_mgmt_exists())
> > +		return -ENODEV;
> > +
> >  	id =3D x86_match_cpu(intel_pstate_cpu_ids);
> >  	if (!id)
> >  		return -ENODEV;
> >=20


