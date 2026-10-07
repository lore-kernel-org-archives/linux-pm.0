Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB338D01B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385514; cv=none; b=GjJnUNlyFAnQQwSPOqdcKXVfadmFJayRFJ9I/pLQcKZYSnhHKwM3KtZVlGT++0N0W3M9wi3jRPoQFEj38gVPkWL6129eRQ1N8/IHhDGCLHshDuBXh25XcTKOdncVjm2bmmZNpygXDtJzk1dD5TDg7qpfSJxWmPECblpfRJ8PSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385514; c=relaxed/simple;
	bh=u9ndw+Si48kARyOA7OStJ5giAiMRGJcFhU8cy8mLtlg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOX3UDyCNKHdhUg9dBxZAOe2ZtDuVUkf4tonYUmKRyxytrWqO5XxGjKy2lXpzawS4OHv9x1uW6J+RmNwpgNRW35UtwpC0+743M5SwcfOx0I9dQHhsSQhi/y8onp4GUjPIxlVxylwWcS2xuGfMqHCJ5w3wUSJd8NZ7VWWFWFWrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch; spf=pass smtp.mailfrom=kylegospodneti.ch; dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b=UJbSTLVJ; arc=none smtp.client-ip=109.224.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylegospodneti.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylegospodneti.ch header.i=@kylegospodneti.ch header.b="UJbSTLVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylegospodneti.ch;
	s=protonmail3; t=1791385495; x=1791644695;
	bh=V+nZJrU5o56QPPUViqJIo8xMB/mLAIO3e6UEiVvrGHg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UJbSTLVJ2nCGdgrL3YKNH/Re4LJ+PsMeyOaPCWmpgFQt5oU1zY9D5yO4A1JcPfRFf
	 /Vw2ib60uiaN9tRx0Db5GR7V3wnEsMRNsAH9AXNeI9FWqHD7UcBUt5sDc+nx3v+Q24
	 VYiq7B7Y9fgGvL+C6SLoVPkONWkWEyB3Qd2Q9VWrX+R5iB8QdxPRoh5qDaVLWaD7cQ
	 FBIKW2lQTIDzkEmAQzC6zlf3U+YC4lvvgXF6qxlEe4n6ynpPYtzF76KiKtYQuVm4xN
	 mkTfyJI11XGVg2nG/P8cnDu//4EGoN5F4Njp0sxjZhr3CyxOgTWFJ6T8hAAeA0INro
	 PZzJhvOQ+2TGw==
Date: Wed, 07 Oct 2026 15:04:52 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for TRX40-based motherboards
Message-ID: <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
In-Reply-To: <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
References: <20261007144150.15113-1-ggherdovich@suse.cz> <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
Feedback-ID: 27885724:user:proton
X-Pm-Message-ID: f1ef74c1f5ced30533323590737b1b4f0eeacf9a
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes this does appear to be the same problem, thank you!

-------- Original Message --------
On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@amd.co=
m> wrote:
+ Kyle

Kyle,

By chance is this the same system that you were talking to me about offline=
?



On 10/7/26 09:41, Giovanni Gherdovich wrote:
> Some motherboard based on the TRX40 chipset has been reported to ship
> firmware lacking lowest and nominal frequency values in the
> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
> Firmware updates aren't available.

Can you please add more information about the vendor/model of the MB, etc?
>
> amd-pstate requires explicit knowledge of nominal frequency, so it
> can't load on this hardware. The driver already has a mechanism (the
> so-called "quirks") to accommodate for missing nominal freq in ACPI
> tables, so here we use it to match against CPU family, model, core
> count, and BIOS version.

Yeah; it's intended for this specific case of really old hardware that
the BIOS isn't going to fix it.

I don't understand why core count matters though.

>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>   drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8bfd46d60843..532ff16dd076 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 =3D {
>   =09.lowest_freq =3D 550,
>   };
>
> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c =3D {
> +=09.nominal_freq =3D 3800,
> +=09.lowest_freq =3D 550,
> +};
> +
>   static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq,=
 unsigned int freq_val)
>   {
>   =09u32 perf_val =3D DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf,=
 nominal_freq);
> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const st=
ruct dmi_system_id *dmi)
>   =09return 0;
>   }
>
> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id =
*dmi)
> +{
> +=09/**
> +=09 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socke=
t / TRX40 chipset.
> +=09 */
> +=09if (boot_cpu_data.x86 =3D=3D 0x17 &&
> +=09    boot_cpu_data.x86_model >=3D 0x30 && boot_cpu_data.x86_model <=3D=
 0x3F &&
> +=09    topology_num_cores_per_package() =3D=3D 24) {

Does the number of cores actually matter?  Do you mean to say if you
swap the CPU to another part CPPC works?

> +=09=09quirks =3D dmi->driver_data;
> +=09=09pr_info("Overriding nominal and lowest frequencies for %s\n", dmi-=
>ident);

The BIOS bug specifically is lack of values, not invalid values, right?
Just want to make sure I'm following this right.

> +=09=09return 1;
> +=09}
> +
> +=09return 0;
> +}
> +
>   static const struct dmi_system_id amd_pstate_quirks_table[] __initconst=
 =3D {
>   =09{
>   =09=09.callback =3D dmi_matched_7k62_bios_bug,
> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_=
table[] __initconst =3D {
>   =09=09},
>   =09=09.driver_data =3D &quirk_amd_7k62,
>   =09},
> +=09{
> +=09=09.callback =3D dmi_matched_trx40_bios_bug,
> +=09=09.ident =3D "AMD Ryzen Threadripper 3000",
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"=
),
> +=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
> +=09=09=09DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
> +=09=09},
> +=09=09.driver_data =3D &quirk_amd_ryzen_threadripper_3000_24c,
> +=09},
>   =09{}
>   };
>   MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);


