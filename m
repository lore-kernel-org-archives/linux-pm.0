From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 3/3] intel_pstate: add module and kernel command line
 parameter to ignore ACPI _PPC
Date: Thu, 20 Nov 2014 13:23:17 -0800
Message-ID: <20141120132317.00ad7210@kcaccard-desk.amr.corp.intel.com>
References: <1416299826-15813-1-git-send-email-ethan.zhao@oracle.com>
	<1416299826-15813-8-git-send-email-ethan.zhao@oracle.com>
	<20141119110548.24a0a808@kcaccard-desk.amr.corp.intel.com>
	<41ADCDB8-C204-4661-833B-F68E7D687B61@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <41ADCDB8-C204-4661-833B-F68E7D687B61@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: ethan <ethan.kernel@gmail.com>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, "<dirk.j.brandewie@intel.com>" <dirk.j.brandewie@intel.com>, "<viresh.kumar@linaro.org>" <viresh.kumar@linaro.org>, "<rjw@rjwysocki.net>" <rjw@rjwysocki.net>, "<corbet@lwn.net>" <corbet@lwn.net>, "<linux-doc@vger.kernel.org>" <linux-doc@vger.kernel.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-pm@vger.kernel.org>" <linux-pm@vger.kernel.org>, "<joe.jin@oracle.com>" <joe.jin@oracle.com>, "<brian.maly@oracle.com>" <brian.maly@oracle.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Nov 2014 08:57:34 +0800
ethan <ethan.kernel@gmail.com> wrote:

>=20
>=20
> > =D4=DA 2014=C4=EA11=D4=C220=C8=D5=A3=AC03:05=A3=ACKristen Carlson A=
ccardi <kristen@linux.intel.com> =D0=B4=B5=C0=A3=BA
> >=20
> > On Tue, 18 Nov 2014 17:37:06 +0900
> > Ethan Zhao <ethan.zhao@oracle.com> wrote:
> >=20
> >> Add kernel command line parameter
> >> intel_pstate =3D ignore_acpi_ppc
> >> and module parameter
> >> ignore_acpi_ppc =3D 1
> >> to allow driver to ignore the ACPI _PPC existence even for Sun x86=
 servers.
> >> These parameter could be used for debug\test\workaround etc purpos=
e.
> >>=20
> >> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
> >=20
> > What if we used a more generic parameter like "force" that would by=
pass
> > any vendor specific checks and just load anyway?  This way we don't=
 have
> > to add new parameters everything some new thing shows up that we wa=
nt to
> > ignore.
> >=20
> To be honest, I prefer more generic parameter. But to avoid the possi=
ble negative affect=20
> To another vendors. I back to this way.

Well, your parameter can still impact other vendors as it is.  it
is pretty typical to assume that using a parameter like "force" means
you know what you are doing and accept the risks.  Especially if its
documented as such.

>=20
> Thanks,
> Ethan
> >> ---
> >> Documentation/kernel-parameters.txt | 3 +++
> >> drivers/cpufreq/intel_pstate.c      | 8 +++++++-
> >> 2 files changed, 10 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/kernel-parameters.txt b/Documentation/k=
ernel-parameters.txt
> >> index 4c81a86..f502b85 100644
> >> --- a/Documentation/kernel-parameters.txt
> >> +++ b/Documentation/kernel-parameters.txt
> >> @@ -1446,6 +1446,9 @@ bytes respectively. Such letter suffixes can=
 also be entirely omitted.
> >>               disable
> >>                 Do not enable intel_pstate as the default
> >>                 scaling driver for the supported processors
> >> +               ignore_acpi_ppc
> >> +             Ignore the existence of ACPI method _PPC for Sun x86=
 servers
> >> +             and load the driver.
> >>=20
> >>    intremap=3D    [X86-64, Intel-IOMMU]
> >>            on    enable Interrupt Remapping (default)
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/inte=
l_pstate.c
> >> index 7c5faea..388387b 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -870,6 +870,7 @@ static struct cpufreq_driver intel_pstate_driv=
er =3D {
> >> };
> >>=20
> >> static int __initdata no_load;
> >> +static unsigned int  ignore_acpi_ppc;
> >>=20
> >> static int intel_pstate_msrs_not_valid(void)
> >> {
> >> @@ -990,7 +991,7 @@ static bool intel_pstate_platform_pwr_mgmt_exi=
sts(void)
> >>            intel_pstate_no_acpi_pss())
> >>            return true;
> >>        if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE) =
&&
> >> -            intel_pstate_has_acpi_ppc())
> >> +            intel_pstate_has_acpi_ppc() && !ignore_acpi_ppc)
> >>            return true;
> >>    }
> >>=20
> >> @@ -1066,11 +1067,16 @@ static int __init intel_pstate_setup(char =
*str)
> >>=20
> >>    if (!strcmp(str, "disable"))
> >>        no_load =3D 1;
> >> +    if (!strcmp(str, "ignore_acpi_ppc"))
> >> +        ignore_acpi_ppc =3D 1;
> >>    return 0;
> >> }
> >> early_param("intel_pstate", intel_pstate_setup);
> >> #endif
> >>=20
> >> +module_param(ignore_acpi_ppc, uint, 0644);
> >> +MODULE_PARM_DESC(ignore_acpi_ppc,
> >> +    "value 0 or non-zero. non-zero -> ignore ACPI _PPC and load t=
his driver");
> >> MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
> >> MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core pro=
cessors");
> >> MODULE_LICENSE("GPL");
> >=20

