Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D073D5C1E;
	Wed,  7 Oct 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395002; cv=none; b=lAAQh3pTdKd+UiZZI2ldmkZyf0zu1/523RaGK628crmiSVOeEjs+bqgAux5r+49Cbb0mOGTfksAYzvjNNoaHP5Hg/9X38M6chxv/O4SYgcOfeiB9BNGLw2lOS+HAykuK6veOVfjlYUlQaNunpHh7pJM/NDUFIHRVvwgS8PNBoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395002; c=relaxed/simple;
	bh=eeBqwf8gqt4d/ZsIbXQKZ9OWeoOxgevBxhvA5snf/9c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiSsSQ8b/tMfYl+laCV6MYlgdn27yvgF4jsVNWOgHGch79xgmi1vtJzB3wpOWmr2Vbe3ywHCJvMxyV4E3tkJKDG3isIPwCcbp+tZfW77m/baq2KrmAuD89ZxQjx71TxnYsNgjHdO8A7dUlv8xaUYDr1UnK+1MBVs2xRlu7LJ3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch; spf=pass smtp.mailfrom=kylegospodneti.ch; dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b=ADLF1Y0v; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b="ADLF1Y0v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylegospodneti.ch;
	s=protonmail3; t=1791394997; x=1791654197;
	bh=cUY8mEJkGo9cFvsny6P6Omyp+nLjVdYRpntB9GhXt2I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ADLF1Y0v8DZUAWgdnVts+ILCMcPD03I5CmL+jyQ4SW7KBD+ObVkdVkVP3kU6OwtOM
	 Kq9YdKAme7G9d08wg6MHS5pYMsMh6OBiuimOAy4BaAnrKJ0shH0IvXxPHabnKEW/su
	 u/xUK1odlewnVo/9pk978TIHCrpRAMFhvDwqWOzzjToYWd4w7Jc4wYV0WKa985eb4Q
	 bbbMOMo22UXT0ZwjG8fN2uZgxyvN4M++Ur0S3y7E07hor28CZuOZ3oGiitzfwXI5i2
	 h4HDEapR5OsnJ2/sQGBT2mqWNQVJK8BRl7KTRKqRVTsc2pD+IkUCHIi4wy19qTO/C8
	 /TwW/4DS/jhZg==
Date: Wed, 07 Oct 2026 17:43:11 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for TRX40-based motherboards
Message-ID: <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch>
In-Reply-To: <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
References: <20261007144150.15113-1-ggherdovich@suse.cz> <27b226c7-f30b-4863-96e6-6798232863c5@amd.com> <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch> <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com> <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
Feedback-ID: 27885724:user:proton
X-Pm-Message-ID: 77226f50eee4752a34f9eeb17027162ffdc6a9f2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Missed one,

Release Date: 05/17/2022


On Wednesday, October 7th, 2026 at 10:36 AM, Kyle Gospodnetich <me@kylegosp=
odneti.ch> wrote:

> AMD Ryzen Threadripper 3960X
> MSI TRX40-PRO-10G
> https://www.msi.com/Motherboard/TRX40-PRO-10G/support
> I am using 7C60v1A3(Beta version), I will update to the latest today -- j=
ust learning that exists.
> dmidecode reports that as:
> Vendor: American Megatrends International, LLC.
> Version: 1.80
>=20
> I've had to disable pstate with:
> amd_pstate.enable=3D0 initcall_blacklist=3Damd-pstate
>=20
> Without that my system grinds to a hault, takes upwards of 15 minutes jus=
t to hit the desktop.
>=20
> Thanks, let me know if anything else is needed.
> -Kyle Gospodnetich
>=20
>=20
> On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.limo=
nciello@amd.com> wrote:
>=20
> > Kyle,
> >
> > Can you please confirm more about your system?  System Model, vendor,
> > BIOS version, BIOS vendor, CPU model.
> >
> > Thanks,
> >
> > On 10/7/26 10:04, Kyle Gospodnetich wrote:
> > > Yes this does appear to be the same problem, thank you!
> > >
> > > -------- Original Message --------
> > > On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@=
amd.com> wrote:
> > > + Kyle
> > >
> > > Kyle,
> > >
> > > By chance is this the same system that you were talking to me about o=
ffline?
> > >
> > >
> > >
> > > On 10/7/26 09:41, Giovanni Gherdovich wrote:
> > >> Some motherboard based on the TRX40 chipset has been reported to shi=
p
> > >> firmware lacking lowest and nominal frequency values in the
> > >> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
> > >> Firmware updates aren't available.
> > >
> > > Can you please add more information about the vendor/model of the MB,=
 etc?
> > >>
> > >> amd-pstate requires explicit knowledge of nominal frequency, so it
> > >> can't load on this hardware. The driver already has a mechanism (the
> > >> so-called "quirks") to accommodate for missing nominal freq in ACPI
> > >> tables, so here we use it to match against CPU family, model, core
> > >> count, and BIOS version.
> > >
> > > Yeah; it's intended for this specific case of really old hardware tha=
t
> > > the BIOS isn't going to fix it.
> > >
> > > I don't understand why core count matters though.
> > >
> > >>
> > >> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > >> ---
> > >>    drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
> > >>    1 file changed, 31 insertions(+)
> > >>
> > >> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-psta=
te.c
> > >> index 8bfd46d60843..532ff16dd076 100644
> > >> --- a/drivers/cpufreq/amd-pstate.c
> > >> +++ b/drivers/cpufreq/amd-pstate.c
> > >> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 =3D {
> > >>    =09.lowest_freq =3D 550,
> > >>    };
> > >>
> > >> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c =3D=
 {
> > >> +=09.nominal_freq =3D 3800,
> > >> +=09.lowest_freq =3D 550,
> > >> +};
> > >> +
> > >>    static inline u8 freq_to_perf(union perf_cached perf, u32 nominal=
_freq, unsigned int freq_val)
> > >>    {
> > >>    =09u32 perf_val =3D DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal=
_perf, nominal_freq);
> > >> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(con=
st struct dmi_system_id *dmi)
> > >>    =09return 0;
> > >>    }
> > >>
> > >> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_syste=
m_id *dmi)
> > >> +{
> > >> +=09/**
> > >> +=09 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 =
socket / TRX40 chipset.
> > >> +=09 */
> > >> +=09if (boot_cpu_data.x86 =3D=3D 0x17 &&
> > >> +=09    boot_cpu_data.x86_model >=3D 0x30 && boot_cpu_data.x86_model=
 <=3D 0x3F &&
> > >> +=09    topology_num_cores_per_package() =3D=3D 24) {
> > >
> > > Does the number of cores actually matter?  Do you mean to say if you
> > > swap the CPU to another part CPPC works?
> > >
> > >> +=09=09quirks =3D dmi->driver_data;
> > >> +=09=09pr_info("Overriding nominal and lowest frequencies for %s\n",=
 dmi->ident);
> > >
> > > The BIOS bug specifically is lack of values, not invalid values, righ=
t?
> > > Just want to make sure I'm following this right.
> > >
> > >> +=09=09return 1;
> > >> +=09}
> > >> +
> > >> +=09return 0;
> > >> +}
> > >> +
> > >>    static const struct dmi_system_id amd_pstate_quirks_table[] __ini=
tconst =3D {
> > >>    =09{
> > >>    =09=09.callback =3D dmi_matched_7k62_bios_bug,
> > >> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_qu=
irks_table[] __initconst =3D {
> > >>    =09=09},
> > >>    =09=09.driver_data =3D &quirk_amd_7k62,
> > >>    =09},
> > >> +=09{
> > >> +=09=09.callback =3D dmi_matched_trx40_bios_bug,
> > >> +=09=09.ident =3D "AMD Ryzen Threadripper 3000",
> > >> +=09=09.matches =3D {
> > >> +=09=09=09DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends Internati=
onal"),
> > >> +=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
> > >> +=09=09=09DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
> > >> +=09=09},
> > >> +=09=09.driver_data =3D &quirk_amd_ryzen_threadripper_3000_24c,
> > >> +=09},
> > >>    =09{}
> > >>    };
> > >>    MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> > >
> >
> >
