Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3D23A564
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397837; cv=none; b=J1HZl/YEK+13bcJonz3IumKF4yL8tx6F4yHnKQ+sK9OiNdji/eQY97vzgQUDbmqbh1LSwkkAQ//CbGD1LlCmgKHb1i5/wEQXeAC6NZ9tr7McpYch6Lsy7sS/2e0HtqKYg1KTqaf2gUNOA9V0ux4GVllP1AUlZ9pOV/EVp1DMHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397837; c=relaxed/simple;
	bh=dty6bX0TpqfNox09g+PEjq/uh4bZ25fulB3qoljVxg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXiPuW8DSqbZ0jy4skh29QqeoAFtoVbh6x8Jt5JXJrxoLpqXTdM2ERia+D1ektXds4G6SWq9R1jkBawwF5XJy7C6mbcX0mZl5PvVbyUBICVRIRQ8PMeMzCyYJcN9MKf1ZA2mBFytcA68Zx7vWsF5zT7CoAqYJaLucFj3RzSE5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch; spf=pass smtp.mailfrom=kylegospodneti.ch; dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b=xA668s1m; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b="xA668s1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylegospodneti.ch;
	s=protonmail3; t=1791397831; x=1791657031;
	bh=2t5dWYok++vN5ZNtz+zSTrrC5vV7C3n+OBQtO99L+SY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xA668s1mWMKk3NyBIY/tX09oF/IE1Weq2p/rHCIIicoaO/pz1Kc/8Tt8M5XpGjg6r
	 RZAwLnzWK86xPSJjvVApuYrOnZgeC3nrS5BZ/JYNvPS8n1npU5PCcDGyEk42xKpofy
	 GYrgOe0oDGnIy1HLGi7N5GR2AwRKbtyEjeyJfgmcis/U0ywdMpjVsb1vPT4Sn15od6
	 kD6Sl51zF1xo/hvkr24MWKicQOjMCG/rTmme8+OGH5IyotYf6S5VfoCdgDGHgzbItS
	 bWkBQyuLmPVLaDi+ZNYmqgRWBPVw5qJpYanXLttpsONcGKmcnA+uxBSuZLqPBVwAEf
	 DvOHWZwHWn3mg==
Date: Wed, 07 Oct 2026 18:30:27 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for TRX40-based motherboards
Message-ID: <bK7n7j4SGpNNcHzUh7I63T_Ozbd5u6wVHdVlpa3Ym76UQs2PhQDtaREPYuFsHMKZku0B9v2-d8A9PdeBRx_0l0xUZ9gt--wxwyI4-sTKfyM=@kylegospodneti.ch>
In-Reply-To: <1c6ba221-a73c-4793-aac6-b38d6e573295@amd.com>
References: <20261007144150.15113-1-ggherdovich@suse.cz> <27b226c7-f30b-4863-96e6-6798232863c5@amd.com> <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch> <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com> <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch> <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch> <1c6ba221-a73c-4793-aac6-b38d6e573295@amd.com>
Feedback-ID: 27885724:user:proton
X-Pm-Message-ID: cc20ce1c6cab4a540163e6012be786c38e9a9a7c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looks like it's finally fixed with that last BIOS release, it's been years!

Platform Firmware Information
=09Vendor: American Megatrends International, LLC.
=09Version: 1.A4
=09Release Date: 06/15/2026

cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
amd-pstate-epp

And no performance issues. Thanks!


On Wednesday, October 7th, 2026 at 11:08 AM, Mario Limonciello <mario.limon=
ciello@amd.com> wrote:

> OK, let's wait and see what happens after you upgrade.  New versions of
> FW and the behavior please.
>=20
> On 10/7/26 12:43, Kyle Gospodnetich wrote:
> > Missed one,
> >
> > Release Date: 05/17/2022
> >
> >
> > On Wednesday, October 7th, 2026 at 10:36 AM, Kyle Gospodnetich <me@kyle=
gospodneti.ch> wrote:
> >
> >> AMD Ryzen Threadripper 3960X
> >> MSI TRX40-PRO-10G
> >> https://www.msi.com/Motherboard/TRX40-PRO-10G/support
> >> I am using 7C60v1A3(Beta version), I will update to the latest today -=
- just learning that exists.
> >> dmidecode reports that as:
> >> Vendor: American Megatrends International, LLC.
> >> Version: 1.80
> >>
> >> I've had to disable pstate with:
> >> amd_pstate.enable=3D0 initcall_blacklist=3Damd-pstate
> >>
> >> Without that my system grinds to a hault, takes upwards of 15 minutes =
just to hit the desktop.
> >>
> >> Thanks, let me know if anything else is needed.
> >> -Kyle Gospodnetich
> >>
> >>
> >> On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.l=
imonciello@amd.com> wrote:
> >>
> >>> Kyle,
> >>>
> >>> Can you please confirm more about your system?  System Model, vendor,
> >>> BIOS version, BIOS vendor, CPU model.
> >>>
> >>> Thanks,
> >>>
> >>> On 10/7/26 10:04, Kyle Gospodnetich wrote:
> >>>> Yes this does appear to be the same problem, thank you!
> >>>>
> >>>> -------- Original Message --------
> >>>> On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello=
@amd.com> wrote:
> >>>> + Kyle
> >>>>
> >>>> Kyle,
> >>>>
> >>>> By chance is this the same system that you were talking to me about =
offline?
> >>>>
> >>>>
> >>>>
> >>>> On 10/7/26 09:41, Giovanni Gherdovich wrote:
> >>>>> Some motherboard based on the TRX40 chipset has been reported to sh=
ip
> >>>>> firmware lacking lowest and nominal frequency values in the
> >>>>> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
> >>>>> Firmware updates aren't available.
> >>>>
> >>>> Can you please add more information about the vendor/model of the MB=
, etc?
> >>>>>
> >>>>> amd-pstate requires explicit knowledge of nominal frequency, so it
> >>>>> can't load on this hardware. The driver already has a mechanism (th=
e
> >>>>> so-called "quirks") to accommodate for missing nominal freq in ACPI
> >>>>> tables, so here we use it to match against CPU family, model, core
> >>>>> count, and BIOS version.
> >>>>
> >>>> Yeah; it's intended for this specific case of really old hardware th=
at
> >>>> the BIOS isn't going to fix it.
> >>>>
> >>>> I don't understand why core count matters though.
> >>>>
> >>>>>
> >>>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> >>>>> ---
> >>>>>     drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++=
++
> >>>>>     1 file changed, 31 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pst=
ate.c
> >>>>> index 8bfd46d60843..532ff16dd076 100644
> >>>>> --- a/drivers/cpufreq/amd-pstate.c
> >>>>> +++ b/drivers/cpufreq/amd-pstate.c
> >>>>> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 =3D {
> >>>>>     =09.lowest_freq =3D 550,
> >>>>>     };
> >>>>>
> >>>>> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c =
=3D {
> >>>>> +=09.nominal_freq =3D 3800,
> >>>>> +=09.lowest_freq =3D 550,
> >>>>> +};
> >>>>> +
> >>>>>     static inline u8 freq_to_perf(union perf_cached perf, u32 nomin=
al_freq, unsigned int freq_val)
> >>>>>     {
> >>>>>     =09u32 perf_val =3D DIV_ROUND_UP_ULL((u64)freq_val * perf.nomin=
al_perf, nominal_freq);
> >>>>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(co=
nst struct dmi_system_id *dmi)
> >>>>>     =09return 0;
> >>>>>     }
> >>>>>
> >>>>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_syst=
em_id *dmi)
> >>>>> +{
> >>>>> +=09/**
> >>>>> +=09 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4=
 socket / TRX40 chipset.
> >>>>> +=09 */
> >>>>> +=09if (boot_cpu_data.x86 =3D=3D 0x17 &&
> >>>>> +=09    boot_cpu_data.x86_model >=3D 0x30 && boot_cpu_data.x86_mode=
l <=3D 0x3F &&
> >>>>> +=09    topology_num_cores_per_package() =3D=3D 24) {
> >>>>
> >>>> Does the number of cores actually matter?  Do you mean to say if you
> >>>> swap the CPU to another part CPPC works?
> >>>>
> >>>>> +=09=09quirks =3D dmi->driver_data;
> >>>>> +=09=09pr_info("Overriding nominal and lowest frequencies for %s\n"=
, dmi->ident);
> >>>>
> >>>> The BIOS bug specifically is lack of values, not invalid values, rig=
ht?
> >>>> Just want to make sure I'm following this right.
> >>>>
> >>>>> +=09=09return 1;
> >>>>> +=09}
> >>>>> +
> >>>>> +=09return 0;
> >>>>> +}
> >>>>> +
> >>>>>     static const struct dmi_system_id amd_pstate_quirks_table[] __i=
nitconst =3D {
> >>>>>     =09{
> >>>>>     =09=09.callback =3D dmi_matched_7k62_bios_bug,
> >>>>> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_q=
uirks_table[] __initconst =3D {
> >>>>>     =09=09},
> >>>>>     =09=09.driver_data =3D &quirk_amd_7k62,
> >>>>>     =09},
> >>>>> +=09{
> >>>>> +=09=09.callback =3D dmi_matched_trx40_bios_bug,
> >>>>> +=09=09.ident =3D "AMD Ryzen Threadripper 3000",
> >>>>> +=09=09.matches =3D {
> >>>>> +=09=09=09DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends Internat=
ional"),
> >>>>> +=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
> >>>>> +=09=09=09DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
> >>>>> +=09=09},
> >>>>> +=09=09.driver_data =3D &quirk_amd_ryzen_threadripper_3000_24c,
> >>>>> +=09},
> >>>>>     =09{}
> >>>>>     };
> >>>>>     MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> >>>>
> >>>
> >>>
>=20
> 
