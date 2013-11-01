From: Adrian Huang <adrian.huang@hp.com>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Fri, 01 Nov 2013 09:53:34 +0800
Message-ID: <1383270814.3646.7.camel@adrian-F6S>
References: <1383233045.2462.7.camel@adrian-F6S>
	 <2937960.e8vxuRXoUT@vostro.rjw.lan> <5272D85C.3030306@gmail.com>
	 <24720758.HRzPDnyMM4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:27302 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3KABxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 21:53:40 -0400
In-Reply-To: <24720758.HRzPDnyMM4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linda.knippers@hp.com, adrianhuang0701@gmail.com

Re-send my reply email because my gmail account sent the email with htm=
l format.=20
It was rejected by vger kernel. My bad.

BTW, the patch was verified correctly on HP ProLiant servers. Also, ple=
ase see my other answers below.=20

-- Adrian

=E6=96=BC =E5=9B=9B=EF=BC=8C2013-10-31 =E6=96=BC 23:47 +0100=EF=BC=8CRa=
fael J. Wysocki =E6=8F=90=E5=88=B0=EF=BC=9A
> On Thursday, October 31, 2013 03:23:24 PM Dirk Brandewie wrote:
> > On 10/31/2013 03:29 PM, Rafael J. Wysocki wrote:
> > > On Thursday, October 31, 2013 11:24:05 PM Adrian Huang wrote:
> > >> Do not load the Intel pstate driver if the platform firmware
> > >> (ACPI BIOS) supports the power management alternatives.
> > >> The ACPI BIOS indicates that the OS control mode can be used
> > >> if the _PSS (Performance Supported States) is defined in ACPI
> > >> table. For the OS control mode, the Intel pstate driver will be
> > >> loaded.
> > >>
> > >> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> > >
> > > Do I assume correctly that this has been tested on the affected h=
ardware?
> > >
> > > Dirk, any objections?
> >=20
> > As long as you are comfortable with the ACPI related logic for matc=
hing
> > the entry in the hw_vendor_info vendor_info[] I have no objections.
>=20
> Well, is there any other way to address that?

I put hw_vendor_info vendor_info in case other vendors (Dell, Lenovo...=
)
have their firmware power management. Vendors should make sure their
firmware power management works properly, and they can go for adding
their vendor info to the variable.

> > One question though can this be disabled via the HP BIOS if the
> > customer does not want to use the firmware power management?
>=20
> Good question.  Adrian?

Yes. HP BIOS has several power management modes (firmware, OS-control
and so on). For the OS control mode in HP BIOS, the Intel p-state drive=
r
will be loaded. When the customer chooses the firmware power management
in HP BIOS, the Intel p-state driver will be ignored.

>=20
>=20
> > >> ---
> > >> Changes from v2:
> > >>   - Remove unnecessary assignments and parentheses (Thanks to Ra=
fael)
> > >>
> > >> Changes from v1:
> > >>   - Minimize indentation levels (Thanks to Rafael)
> > >>   - Re-define some local variables (Thanks to by Rafael)
> > >>   - Return -ENODEV if platform FW has power management modes (Th=
anks to by Dirk)
> > >>
> > >>   drivers/cpufreq/intel_pstate.c | 70 ++++++++++++++++++++++++++=
++++++++++++++++
> > >>   1 file changed, 70 insertions(+)
> > >>
> > >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/in=
tel_pstate.c
> > >> index eb3fdc7..9ec1d6c 100644
> > >> --- a/drivers/cpufreq/intel_pstate.c
> > >> +++ b/drivers/cpufreq/intel_pstate.c
> > >> @@ -26,6 +26,8 @@
> > >>   #include <linux/fs.h>
> > >>   #include <linux/debugfs.h>
> > >>   #include <trace/events/power.h>
> > >> +#include <linux/acpi.h>
> > >> +#include <acpi/processor.h>
> > >>
> > >>   #include <asm/div64.h>
> > >>   #include <asm/msr.h>
> > >> @@ -129,6 +131,18 @@ static struct perf_limits limits =3D {
> > >>   	.max_sysfs_pct =3D 100,
> > >>   };
> > >>
> > >> +struct hw_vendor_info {
> > >> +	u16  valid;
> > >> +	char oem_id[ACPI_OEM_ID_SIZE];
> > >> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> > >> +};
> > >> +
> > >> +/* Hardware vendor-specific info that has its own power managem=
ent modes */
> > >> +static struct hw_vendor_info vendor_info[] =3D {
> > >> +	{1, "HP    ", "ProLiant"},
> > >> +	{0, "", ""},
> > >> +};
> > >> +
> > >>   static inline void pid_reset(struct _pid *pid, int setpoint, i=
nt busy,
> > >>   			int deadband, int integral) {
> > >>   	pid->setpoint =3D setpoint;
> > >> @@ -698,6 +712,55 @@ static int intel_pstate_msrs_not_valid(void=
)
> > >>
> > >>   	return 0;
> > >>   }
> > >> +
> > >> +static bool intel_pstate_no_acpi_pss(void)
> > >> +{
> > >> +	int i;
> > >> +
> > >> +	for_each_possible_cpu(i) {
> > >> +		acpi_status status;
> > >> +		union acpi_object *pss;
> > >> +		struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > >> +		struct acpi_processor *pr =3D per_cpu(processors, i);
> > >> +
> > >> +		if (!pr)
> > >> +			continue;
> > >> +
> > >> +		status =3D acpi_evaluate_object(pr->handle, "_PSS",
> > >> +					      NULL, &buffer);
> > >> +		if (ACPI_FAILURE(status))
> > >> +			continue;
> > >> +
> > >> +		pss =3D buffer.pointer;
> > >> +		if (pss && pss->type =3D=3D ACPI_TYPE_PACKAGE) {
> > >> +			kfree(pss);
> > >> +			return false;
> > >> +		}
> > >> +
> > >> +		kfree(pss);
> > >> +	}
> > >> +
> > >> +	return true;
> > >> +}
> > >> +
> > >> +static bool intel_pstate_platform_pwr_mgmt_exists(void)
> > >> +{
> > >> +	struct acpi_table_header hdr;
> > >> +	struct hw_vendor_info *v_info;
> > >> +
> > >> +	if (ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)=
))
> > >> +		return false;
> > >> +
> > >> +	for (v_info =3D vendor_info; v_info->valid; v_info++) {
> > >> +		if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
> > >> +		    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_=
OEM_TABLE_ID_SIZE)
> > >> +		    && intel_pstate_no_acpi_pss())
> > >> +			return true;
> > >> +	}
> > >> +
> > >> +	return false;
> > >> +}
> > >> +
> > >>   static int __init intel_pstate_init(void)
> > >>   {
> > >>   	int cpu, rc =3D 0;
> > >> @@ -706,6 +769,13 @@ static int __init intel_pstate_init(void)
> > >>   	if (no_load)
> > >>   		return -ENODEV;
> > >>
> > >> +	/*
> > >> +	 * The Intel pstate driver will be ignored if the platform
> > >> +	 * firmware has its own power management modes.
> > >> +	 */
> > >> +	if (!acpi_disabled && intel_pstate_platform_pwr_mgmt_exists())
> > >> +		return -ENODEV;
> > >> +
> > >>   	id =3D x86_match_cpu(intel_pstate_cpu_ids);
> > >>   	if (!id)
> > >>   		return -ENODEV;
> > >>
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


