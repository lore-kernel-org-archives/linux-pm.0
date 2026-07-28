Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F841F350;
	Tue, 28 Jul 2026 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228831; cv=none; b=UshT+hUG27TmdTHcay5IAkWYhaiWkBYZpEzKoOKMwVNT3xmlv+X7dTHQwB0rxjDxIsBuGNodlkGJZvwdJT5RTsQDR7/dCyakZ4bCEjES2byNCA71OW5G8uwuJLuDZceJqecuUI8ig3i5vxB+3nq0rEe+gXBfVprDefEIyuDYMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228831; c=relaxed/simple;
	bh=CcVl3+TM3lenS6CZAniU96vf6OOzWlsl01+972cfyeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyAyHiunT6tRrtGrsWOCa58KY63CCiWxZZzhUg/WkOfaqpbmmgOn9hoKOjnqyzbo9sUwFaRrhggYawwcx1ehZmv1XQHpz8Fn4BW78l6+aKFsASEB9JP/sz2p0FVD8gDvMVVc8n1bEp6F7xiE6Tf8ljn9vejZgjgNJ4EY93z8oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F7y4XFr9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F7y4XFr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785228826;
	bh=CcVl3+TM3lenS6CZAniU96vf6OOzWlsl01+972cfyeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F7y4XFr99qLiF31AvlBBi2K259cBdERnXBdCtOS056G49NTf72Ah2uvC9qbthUx3Y
	 QpUAUy9FULZjeQe0PqN9mVIxmPN88/tAqsy7UMEPe1TTWXnp4AYfG7M7GdR6PSN4TS
	 eIJukDsu8QK/1kgnxI9AdqnOzC+x7mnHwycNDz2fT7u4SDkIECvT5Q9tbs/CuHlSjx
	 KksC3SfRiE6URP5TZNtPveaWd1F9Gz/s9319/mmI3JQXLEwjXOqSlSqmKGoxg3iiPv
	 Y91kxNpAT+Yw6Uu74DNHcd7/PKo64iLqQa0yaQpBPyuYANuE3tSQqkWEO4x0xKRWYs
	 5ithB9dzlq1wg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8979117E063E;
	Tue, 28 Jul 2026 10:53:46 +0200 (CEST)
Message-ID: <d33152e6-6033-4aab-a6d6-353c514d6565@collabora.com>
Date: Tue, 28 Jul 2026 10:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: mediatek: Fix MT8183 hang on boot
To: Brady Norander <brady.norander@mainlining.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260722132729.302067-1-dmitry.osipenko@collabora.com>
 <fe909054-5c9d-42f5-bbc1-66ca0ace72de@mainlining.org>
 <dd1e30ae-46fd-4083-a306-98e2d23be120@collabora.com>
 <847c99d4-6fae-4984-b6d9-e1f8bf46b300@mainlining.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <847c99d4-6fae-4984-b6d9-e1f8bf46b300@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/27/26 19:38, Brady Norander wrote:
> On 7/27/26 06:57, AngeloGioacchino Del Regno wrote:
>> On 7/25/26 07:11, Brady Norander wrote:
>>> On 7/22/26 09:27, Dmitry Osipenko wrote:
>>>> Depending on firmware, part of the MFG domains may be left ON at boot
>>>> leaving only some MFG cores powered, to let the ACP to prefetch the GPU
>>>> region when the display controller is brought up. This doesn't play well
>>>> with an eventual delay in probing Panfrost when the display controller is
>>>> fully set up, as that would make genpd's sync_state() to power off the
>>>> domain while ACP tries to prefetch: this is causing an AXI stall,
>>>> effectively freezing the AP indefinitely. In order to prevent this from
>>>> happening, the sync_state() functionality must be obliterated on all of
>>>> the MFG domains: while this guarantees a power leakage if the bootloader
>>>> boots the kernel with MFG PDs partially powered on, this is the only way
>>>> to ensure stable operation of the SoC during boot on devices with such
>>>> firmware because, of course, those will never officially receive a
>>>> firmware update.
>>>>
>>>> Fixes Kappa Chromebook hanging during system boot.
>>>
>>> I also saw this same issue on my MT8192 Hayato Chromebook, and I also saw an 
>>> issue on my MT8183 and MT8186 Chromebooks where the audio was broken. I fixed 
>>> all of those issues by setting the GENPD_FLAG_NO_STAY_ON flag on all domains. I 
>>> held off from submitting that change as I was unsure if it was the "correct" way 
>>> to handle it, but perhaps it is. Either way, this issue is not specific to only 
>>> MT8183.
>>
>> Audio is something a bit different I believe.
>>
>> For MFG on MT8183 specifically (and potentially same generation or even slightly
>> older) there's an issue that is very specific and described in the description
>> of this commit.
>>
> 
> I do believe that the issue I'm seeing on MT8192 is very similar to the issue 
> described on MT8183. On my MT8192 Hayato, I get the following sync_state warnings 
> due to these two display components not having drivers which bind to them:
> 
>    [   25.828186] mtk-power-controller 10006000.syscon:power-controller: 
> sync_state() pending due to 1400d000.postmask
>    [   25.838380] mtk-power-controller 10006000.syscon:power-controller: 
> sync_state() pending due to 1400e000.dither
> 
> This device boots just fine up until I reach the point where my display manager 
> starts, where I get a full SoC hang. If I disable my display manager from starting 
> at boot, the device boots to a shell just fine.

Eeeeeeh....

 > While MT8192 doesn't have ACP to > prefetch anything from the GPU,

....well..... drivers/soc/mediatek/mtk-infracfg.c - read that driver: are you still
sure about what you're saying now? :-P

P.S.: We tried the same trick with MT8183, but that needs more than just that, and
it's anyway a very suboptimal (and ugly) solution anyway.


> the display manager (which uses 3D accel) still 
> appears to trigger an AXI stall (I don't know how to verify this is actually what 
> happens, but it seems likely) and I would assume the bootloader also leaves the MFG 
> domains partially enabled on MT8192 based on this behavior.
> 

That can be a real possibility. Try to apply the same patch on 8192 domains, and
see if and which power domains are kept on in the MFlexGraphics island (you'll see
a print saying that a default off domain "has been on").


>> So, specifically for audio, I think that there may be something else that is
>> wrong if you're seeing such a behavior - as in, some dependencies may be missing
>> from somewhere (some devicetree node), or something else.
>>
> 
> The audio issues I see on MT8183 and MT8186 also seem to have the same root cause, 
> the bootloader leaving domains partially enabled. On my MT8183 krane I get these 
> warnings:
> 
>    [   21.705672] mtk-power-controller 10006000.syscon:power-controller: 
> sync_state() pending due to 14005000.dma-controller
>    [   21.705677] mtk-power-controller 10006000.syscon:power-controller: 
> sync_state() pending due to 14006000.mdp3-wdma
>    [   21.705688] mtk-power-controller 10006000.syscon:power-controller: 
> sync_state() pending due to 14012000.dither
> 
> And I get this error when attempting to play audio:
> 
>    [  217.282793] mt8183-audio 11220000.audio-controller:mt8183-afe-pcm: 
> mtk_afe_pcm_pointer hw_ptr err
> 
> In both the MT8192 GPU case and the MT8183/8186 audio case, the issue was fixed 
> with the following diff to not use the sync_state system to keep domains powered on:
> 

In the audio case, since there's no stall, a cleaner solution could be to trigger a
full reset on the ADSP and on the AFE/PCM/whatever.

There should be a reset register for that.

Alternatively, the drivers are assuming that the device starts from a clean known
state, so some registers are not set as they are left to the initial default state:
adding writes to force those in default state could also be an option... but then
that depends on how many, because otherwise just asserting reset is simply a better
option.

> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/ 
> mediatek/mtk-pm-domains.c
> index 9c9323c8c93a..b0868e24e241 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -639,6 +639,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, 
> struct device_no
> 
>       pd->genpd.power_off = scpsys_power_off;
>       pd->genpd.power_on = scpsys_power_on;
> +    pd->genpd.flags |= GENPD_FLAG_NO_STAY_ON;
> 
>       if (MTK_SCPD_CAPS(pd, MTK_SCPD_ACTIVE_WAKEUP))
>           pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> 
> What isn't clear to me is why leaving display domains powered on is preventing 
> audio from working. Maybe there is some dependency that isn't clear to me?

It's probably due to how MediaTek SoCs are internally structured: I didn't check
on 8186 or 83 specifically, but it's likely that the multimedia IP block (which
also contains multimedia clock controllers, which are powered by multimedia power
domains!!!!) is providing some clock source to some audio related gate (or PLL
even).

When the clock source for the whatever audio related IP is turned off, the IP is
getting in a unclocked state (or even unpowered, depending on what's actually going
on), so when it gets re-clocked, said IP restarts like it was reset with register
defaults - then you get a "known and clean" (is it really clean if this is what is
happening? ugh!) state for the initialization sequence to go on Just Fine (TM).

That could be an explanation... but then please take all this with a grain of salt,
I'm doing an information dump here hoping to help you somehow with this, but I can
not be certain of what's going on unless I really analyze the specific issue on HW.

> The 
> other thing which isn't clear to me is why I never experienced the boot hang on 
> MT8183.

Luck and just the right defconfig, where the right drivers never -EPROBE_DEFER,
and the whole boot process doesn't take "too much time". That's why.

For Dmitry the hang didn't happen all the time either, it did depend on both how
much time it was required for booting and on probe deferrals.

> Either way, I'm experiencing issues on multiple SoCs which are fixed by 
> allowing the domains to power off and back on.
> 

Multiple SoCs... MediaTek? Qualcomm? NXP? And which models?

This thing, anyway, all started since sync_state() was introduced in power domains:
it wasn't an issue before, and AFAIK that actually made more platforms to regress.

I'm not blaming anyone though... this only means that many platforms had some
"hidden" bug (or an easter egg, if you wish? :-P) that was power domain related...
..when you have such situations, it's only a matter of time until something goes
wrong... in this case it all started going wrong with sync_state, but it could've
been worst, or could've happened in other racy ways which would've been way harder
to debug, etc.

Cheers,
Angelo

>> In any case, I'm always open for discussion, of course.
> 
