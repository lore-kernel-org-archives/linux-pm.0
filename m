Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41637204C
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394607; cv=none; b=ljlNKNrihutBoQ//fDIq85elVE1Cvdn/nDnfDH9tzn5hBd7vB8yOL90HH5mbjqecIrsxH88D2L5Eer2YNOExzClsL5ckOFOGzh4bcTt6FasSyBtbCMni5fFJjvFwSkwGqwa5nJb9ux2hvI2WgOO6vw3v797wDHjjBVAnfpF3HaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394607; c=relaxed/simple;
	bh=C0RSXjB1nLbdzpeEtdAe95jzxBfxDs6pRQykZzq2SQs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/nY6PBQfSDUIyiR+MVoBcXtF9g7C3B5YR5rzztP4zwvPqP0F/jwTriQJlckSCfbY6lpINQQ8aX09QPzmjHf43wxo/jRpCMVpOd6BAeh2i9ke1wrT7gsOusxHlSYBfrOGzz+inWSTG4XTWOGcNBWqSHlkbA54lhMrz4YPTO7rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch; spf=pass smtp.mailfrom=kylegospodneti.ch; dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b=syae4N3M; arc=none smtp.client-ip=79.135.106.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b="syae4N3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylegospodneti.ch;
	s=protonmail3; t=1791394594; x=1791653794;
	bh=PvxAgSh0xBlF/P76pfLyUCPeTOeopnwdDneGTCSerXo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=syae4N3Mm+frXT8YCoPzKfb8gc4KU6Fr3lp2ZcTVGmaa94U6LBzSUWn4rnw9SuAxG
	 2YuJQ8nUoGwE2eOnSwlD5z1S92E8nYvcz/BClbj0gtR4qb4UrLaRrxmSJC2ICr6gZC
	 rzaVEEM8wrArZ0kyKfWcl8MgvBZqbStp+cRR5sLHngOFzwUoYZ19cnFH6uD95vMkB5
	 /RGEq395w14Gm1R0waZkkwbaCJw6AFfD7ulZxxz3EIHhJpcTZ0qv5db9vcvBo/NN7S
	 8xCzVBPubDCxFw7M1tsVvVSH2TSJDz9FRWNNX82/8diVjA6cW27XONtJDTTvkT79qL
	 PG/+btjvCjKBA==
Date: Wed, 07 Oct 2026 17:36:32 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for TRX40-based motherboards
Message-ID: <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
In-Reply-To: <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
References: <20261007144150.15113-1-ggherdovich@suse.cz> <27b226c7-f30b-4863-96e6-6798232863c5@amd.com> <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch> <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
Feedback-ID: 27885724:user:proton
X-Pm-Message-ID: 06776745457b660cba6e8b55a2f1d8c35c8fd832
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

AMD Ryzen Threadripper 3960X
MSI TRX40-PRO-10G
https://www.msi.com/Motherboard/TRX40-PRO-10G/support
I am using 7C60v1A3(Beta version), I will update to the latest today -- jus=
t learning that exists.
dmidecode reports that as:
Vendor: American Megatrends International, LLC.
Version: 1.80

I've had to disable pstate with:
amd_pstate.enable=3D0 initcall_blacklist=3Damd-pstate

Without that my system grinds to a hault, takes upwards of 15 minutes just =
to hit the desktop.

Thanks, let me know if anything else is needed.
-Kyle Gospodnetich


On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.limonc=
iello@amd.com> wrote:

> Kyle,
>=20
> Can you please confirm more about your system?  System Model, vendor,
> BIOS version, BIOS vendor, CPU model.
>=20
> Thanks,
>=20
> On 10/7/26 10:04, Kyle Gospodnetich wrote:
> > Yes this does appear to be the same problem, thank you!
> >
> > -------- Original Message --------
> > On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@am=
d.com> wrote:
> > + Kyle
> >
> > Kyle,
> >
> > By chance is this the same system that you were talking to me about off=
line?
> >
> >
> >
> > On 10/7/26 09:41, Giovanni Gherdovich wrote:
> >> Some motherboard based on the TRX40 chipset has been reported to ship
> >> firmware lacking lowest and nominal frequency values in the
> >> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
> >> Firmware updates aren't available.
> >
> > Can you please add more information about the vendor/model of the MB, e=
tc?
> >>
> >> amd-pstate requires explicit knowledge of nominal frequency, so it
> >> can't load on this hardware. The driver already has a mechanism (the
> >> so-called "quirks") to accommodate for missing nominal freq in ACPI
> >> tables, so here we use it to match against CPU family, model, core
> >> count, and BIOS version.
> >
> > Yeah; it's intended for this specific case of really old hardware that
> > the BIOS isn't going to fix it.
> >
> > I don't understand why core count matters though.
> >
> >>
> >> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> >> ---
> >>    drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
> >>    1 file changed, 31 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate=
.c
> >> index 8bfd46d60843..532ff16dd076 100644
> >> --- a/drivers/cpufreq/amd-pstate.c
> >> +++ b/drivers/cpufreq/amd-pstate.c
> >> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 =3D {
> >>    =09.lowest_freq =3D 550,
> >>    };
> >>
> >> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c =3D {
> >> +=09.nominal_freq =3D 3800,
> >> +=09.lowest_freq =3D 550,
> >> +};
> >> +
> >>    static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_f=
req, unsigned int freq_val)
> >>    {
> >>    =09u32 perf_val =3D DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_p=
erf, nominal_freq);
> >> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const=
 struct dmi_system_id *dmi)
> >>    =09return 0;
> >>    }
> >>
> >> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_=
id *dmi)
> >> +{
> >> +=09/**
> >> +=09 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 so=
cket / TRX40 chipset.
> >> +=09 */
> >> +=09if (boot_cpu_data.x86 =3D=3D 0x17 &&
> >> +=09    boot_cpu_data.x86_model >=3D 0x30 && boot_cpu_data.x86_model <=
=3D 0x3F &&
> >> +=09    topology_num_cores_per_package() =3D=3D 24) {
> >
> > Does the number of cores actually matter?  Do you mean to say if you
> > swap the CPU to another part CPPC works?
> >
> >> +=09=09quirks =3D dmi->driver_data;
> >> +=09=09pr_info("Overriding nominal and lowest frequencies for %s\n", d=
mi->ident);
> >
> > The BIOS bug specifically is lack of values, not invalid values, right?
> > Just want to make sure I'm following this right.
> >
> >> +=09=09return 1;
> >> +=09}
> >> +
> >> +=09return 0;
> >> +}
> >> +
> >>    static const struct dmi_system_id amd_pstate_quirks_table[] __initc=
onst =3D {
> >>    =09{
> >>    =09=09.callback =3D dmi_matched_7k62_bios_bug,
> >> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quir=
ks_table[] __initconst =3D {
> >>    =09=09},
> >>    =09=09.driver_data =3D &quirk_amd_7k62,
> >>    =09},
> >> +=09{
> >> +=09=09.callback =3D dmi_matched_trx40_bios_bug,
> >> +=09=09.ident =3D "AMD Ryzen Threadripper 3000",
> >> +=09=09.matches =3D {
> >> +=09=09=09DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends Internation=
al"),
> >> +=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
> >> +=09=09=09DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
> >> +=09=09},
> >> +=09=09.driver_data =3D &quirk_amd_ryzen_threadripper_3000_24c,
> >> +=09},
> >>    =09{}
> >>    };
> >>    MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> >
>=20
> 
