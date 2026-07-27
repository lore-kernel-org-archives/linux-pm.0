Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4334F46F;
	Mon, 27 Jul 2026 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150281; cv=none; b=s/BK9hh5qQuTLAcY4QlSNR3snRnO3kWj0c/OZH+iB1jymDV9eF0zmPOWNSg8omuXYw2QaswX5u+GzScd5hIpJTckmEWH+Aum+A+9vv4SVXF7K+UjtBljiyyuswEcS/5Wjmv0yT4b3ZTeacJwzmmJfUEZqEz/mwPkN2pmw1k6h98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150281; c=relaxed/simple;
	bh=QM/K8aOc5Up2gdGT9i+OHNKgkTN1erLCWtsav788hrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIIkAhITPpNMpWXmNoEQ5D0rFSPA3NgaiG6SbXjQXdKLAcURAGKXAJ1dXc99yRyEYibqve6ZmmlptPieWBssTYhqiqsTHCsfp1IRvxNr6BAdQZzye7htX3Zj7V3fWQ01pJ3mJMVk/NStdqLC4Bw+/Ra+Zjqtf4dc4//5w/E1RUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nx1sxHrM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nx1sxHrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785150278;
	bh=QM/K8aOc5Up2gdGT9i+OHNKgkTN1erLCWtsav788hrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nx1sxHrM4Gt9yN4Ces1O83GaplTN8qv4vVmwOAKihOgOgmvoI8rPtVh4RuLuVfjnH
	 VyWjXMbLiBzhZAukMWSSh+ZIhbufyfp3ODsIYNvJQCVmCGpV5gHNOuUt1jnJ1nmjcw
	 LpojVlFqmmGlp6IBOulOA4c966bFCYfP0P9J58wSxQHMIhEF+F1AbbKFI9GEw+0jdW
	 4eUX6JDZB6kOwMAzCeiTO2hJawrrgkDUjDLq5fQdoNdynszoEOS/CVSPnmGZXw0ThP
	 k35BrqEGIinPrZ8jEZ2i3NyIs2AJUxT5NJ03QI0Pt5PckKDuUAQc/egjgcC8ak2XyV
	 Fl1Ap1TqcbEBw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A990C17E001F;
	Mon, 27 Jul 2026 13:04:37 +0200 (CEST)
Message-ID: <3130633c-fbff-4b1a-a127-bd4eb678c3f6@collabora.com>
Date: Mon, 27 Jul 2026 13:04:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
 <CAPx+jO-1_ZpYcnPtoYxRn5vv34tiP7TXnjKZ3SaWkEzdeTfXpA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPx+jO-1_ZpYcnPtoYxRn5vv34tiP7TXnjKZ3SaWkEzdeTfXpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/26 17:01, Ulf Hansson wrote:
> On Wed, Jul 22, 2026 at 3:28 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Depending on firmware, part of the MFG domains may be left ON at boot
>> leaving only some MFG cores powered, to let the ACP to prefetch the GPU
>> region when the display controller is brought up. This doesn't play well
>> with an eventual delay in probing Panfrost when the display controller is
>> fully set up, as that would make genpd's sync_state() to power off the
>> domain while ACP tries to prefetch: this is causing an AXI stall,
>> effectively freezing the AP indefinitely. In order to prevent this from
> 
> I haven't made any detailed investigation, but to me, it sounds like
> there is a missing consumer somewhere.
> 
> Should the ACP/panfrost devices be a consumer of the MFG domains as
> well? Or perhaps, if the ACP/panfrost should rely on the display
> controller to be probed and powered-on, to be able to probe?
> 

This is about how the bootloader is leaving the display controller, the ACP,
and the MFG registers before booting the kernel.

The kernel drivers themselves will reset this weird state when the HW gets
to full probe so there won't be any more issue(s) from that point onwards.

Actually, there would be A LOT to say about this, but I'll be very brief...

Basically, before booting the kernel, the bootloader is leaving a half-assed
setup to potentially support continuous splash functionality, but without it
being actually used on the device(s) that we're talking about here...

Again, I should put a remark on every word of that last paragraph, but this
is the gist of it.

If you're curious or need more information, of course I can expand a bit,
there's no secret involved here, it's just that I'm avoiding to write a wall
of text around that...

P.S.: We've been discussing that internally and chasing this issue for months
before deciding to "solve" it like this.

Cheers,
Angelo

>> happening, the sync_state() functionality must be obliterated on all of
>> the MFG domains: while this guarantees a power leakage if the bootloader
>> boots the kernel with MFG PDs partially powered on, this is the only way
>> to ensure stable operation of the SoC during boot on devices with such
>> firmware because, of course, those will never officially receive a
>> firmware update.
>>
>> Fixes Kappa Chromebook hanging during system boot.
>>
>> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
>> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/pmdomain/mediatek/mt8183-pm-domains.h | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
>> index 3742782a2702..5e33b8628e85 100644
>> --- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
>> +++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
>> @@ -47,7 +47,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                  .pwr_sta2nd_offs = 0x0184,
>>                  .sram_pdn_bits = 0,
>>                  .sram_pdn_ack_bits = 0,
>> -               .caps = MTK_SCPD_DOMAIN_SUPPLY,
>> +               .caps = MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_OFF,
>>          },
>>          [MT8183_POWER_DOMAIN_MFG] = {
>>                  .name = "mfg",
>> @@ -57,7 +57,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                  .pwr_sta2nd_offs = 0x0184,
>>                  .sram_pdn_bits = GENMASK(8, 8),
>>                  .sram_pdn_ack_bits = GENMASK(12, 12),
>> -               .caps = MTK_SCPD_DOMAIN_SUPPLY,
>> +               .caps = MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_OFF,
>>          },
>>          [MT8183_POWER_DOMAIN_MFG_CORE0] = {
>>                  .name = "mfg_core0",
>> @@ -67,6 +67,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                  .pwr_sta2nd_offs = 0x0184,
>>                  .sram_pdn_bits = GENMASK(8, 8),
>>                  .sram_pdn_ack_bits = GENMASK(12, 12),
>> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>          },
>>          [MT8183_POWER_DOMAIN_MFG_CORE1] = {
>>                  .name = "mfg_core1",
>> @@ -76,6 +77,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                  .pwr_sta2nd_offs = 0x0184,
>>                  .sram_pdn_bits = GENMASK(8, 8),
>>                  .sram_pdn_ack_bits = GENMASK(12, 12),
>> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>          },
>>          [MT8183_POWER_DOMAIN_MFG_2D] = {
>>                  .name = "mfg_2d",
>> @@ -85,6 +87,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
>>                  .pwr_sta2nd_offs = 0x0184,
>>                  .sram_pdn_bits = GENMASK(8, 8),
>>                  .sram_pdn_ack_bits = GENMASK(12, 12),
>> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF,
>>                  .bp_cfg = {
>>                          BUS_PROT_WR(INFRA,
>>                                      MT8183_TOP_AXI_PROT_EN_1_MFG,
>> --
>> 2.54.0
>>
