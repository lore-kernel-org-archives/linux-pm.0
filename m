Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0873F58E8
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920791; cv=pass; b=A/lU25mKmbSk/UKnqWnqVRUhYAGVUxIJH8ebjpASGCZqbIXr4sy0weQST7UN/hzZnvnRsdzuVx9Uuk2POYQFBU6GYB5WdzN1/KdEQK3sMoBCw8uRv1nBbEJQkJ1v16YJT/JYVZR9t4P+9teSzLNr1YoXCDVMzeR3XIM32Z/UF4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920791; c=relaxed/simple;
	bh=wnJYk7tv/1X5ZNiBp8HFypSLjBPoRlIAdKPKBEfNm/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/F6aKaSHlC7d8wWtmW/mm6jhRd/OqjIUj2Dryn3OuFGK+VS3Slxzimqos7k+PlpuiedSwbEnyqB3C/ZiRAjkOP1rXyhrCRv0vTFwe+KNqZNyYxMESRSfo3banGEnNCw7uOBjr3j/RawuvSFaVaUWWyN9pCsEOm+E4EUcKGF+3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meEiOn6L; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meEiOn6L"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81f64e6eae4so406407b3.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 02:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785920784; cv=none;
        d=google.com; s=arc-20260327;
        b=GMtrJ20llKxrMeWcU8wMkGA8+ADYV5s5jZvlqnZ54cJIjJTg3WbHooaepL54Oucexh
         2rsBdjwgI9rb8dCbgP2MeHxB4gSYgAvWYTf3yJW27Td8cSVo1h1QtIanla1E1v8VTEfa
         WKkSVA5Q5Un6WgWsceeUjtZhNGePvOW5TJPcH/aameXIsXBdhif9s1wrQy7+C+Ed/xxS
         SLxD90RHcNlF3PJUMsv2ULk3sJJtBrvHj8sD5QmgbDyZhheLcM3JZPtiWFI4qUa2abHW
         iIpMq2soSPAhZLOUsLudegs2Ps83seNbWGuhydJ4e5iKZ72SVirpnI9Ye3civDrFYDwH
         azfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Td6mNKdGUot4KIrCl9hsoIQ/aoUJ9UoQdcfUAQ+AAKw=;
        fh=soi62JxKZ+JkE0aRHSuyAzIxFtiPDIGbqOhEBD7MIe4=;
        b=n4DdAd6MABYNY9X6dEi+yxYS0D0qEtaOYbpBWp/aXt3puitsjB6M9Gqo0ff54eGyTg
         crKw5J6VFegTt+2LQbPabr+58+tGyKFpT3hXzZ6IyuglcEA4qLNjxk+7btMdDurjm2oH
         gxRs1yd5Zcrb6HAuKsHrFxeiTQz/g0ls/IuJRuGmOPqmmpXQB0qCne+R5M6IvFLiXfH9
         YgW4KJxU2qaIwTOnRY4FsKwF50MybyPgpkAY90MRIkdLIdpVG1iQ8USvdHzo405LgzB5
         zT9Nx6Q8wIUygqBMujgLwfCvI+SPHtgEyV5ZxWYebFZQ1bw85enqbDmTZ4MS0Kg1Pk+z
         c5bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920784; x=1786525584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Td6mNKdGUot4KIrCl9hsoIQ/aoUJ9UoQdcfUAQ+AAKw=;
        b=meEiOn6LZHSTh8XXcbgD4YcPawcPmiiqfqv3B0M3w1a9NZwWpz0R8qCMp4UKT/S5QS
         hG1igVXqdOGQbBEi9vHCDAl9g1CQjT9lNUipK1jIMSyDYw7e6UP18NczeeZoWD5QdZ5h
         AvRAWa9KJpILwLxwyzVdEPqv50PlBbA29dN6VWI8FDWkcvO2ptALkBXyymR2onzriea1
         swJCH+O4QRQtTFfXFy91fsmEMktMpFr/UzS4xAnvsDKp3H4DuJNQnz1WoA9i7uri2cEQ
         qVAabBknzKUDtwK2DVPyDOy69qBsz11f7thrDC1uYbMmBwKXucdYfeHudEjwW4V6817p
         5gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920784; x=1786525584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Td6mNKdGUot4KIrCl9hsoIQ/aoUJ9UoQdcfUAQ+AAKw=;
        b=OH32pMrl7yrqICJxz3TCMMsxvTttPbAT+ok5zxDRZBMzSIbZWsVKNwbKtq9bZ8xedp
         0JfWkKHnNc7Cq3PjrPOm0Lazij+c4H78eEEHcjqw0OKJPg1EqJrbSfKUOm96BNFFxKZg
         UpQxgyscRce1ZeRiBjtcn+U08DDLCfyNSyH+jAAxK1lwfN+W1IALnW1qG3TH2psPHqWh
         UKJaDSSEkFtzh9ZoI4YXsmdHRhelMgF9EhES6YKwcFkx15AW2JczhZLJL4nhJhcjRykn
         kujXxkSCgAEwDNo5OUmcCygxdU5LcjGFpDHmf1lgXNxo7KN14Hw1QT6kfxD67RE36riQ
         QRnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZrB+K/uXHI17UW2+OaFh29yeXheHFT8SsqhFwaLxXM0AnAwPQ+mFYAE07ktUIDbTxhw+qEoZL/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3nCx8fXCWtFHIe7zblt2BBNb4TGbvb288SV4fWPPNoLrqsnb
	IeeTG5rKdbWhRU4dFJ6csN4IEfJ5vkWWRCqHAc1nkpYYt7eyDXtKgM2IaHTkBVZmIxFCqiu3WGw
	lhln8a6EtoIKdSr1Eb4ryQuUvJtoyODw=
X-Gm-Gg: AR+sD11hi79wGcN7f6oyF13113aYrZYCoBZ9L3P/zX+EKr7LjsucjgGVKtI++XS27mh
	Ya/P9AHKK5jQy+V/Nhf/9eX8dWfDzK8HkRsHuKzPFmBrPqZQgs1klJQP7PAQdESrIsVEK2Wb68N
	DmjnzkVXM9dlWqTbqToUcO6EkxXtH3lsLZUwpf7it8c/bkaJWz5BJG55y1mhxjT3LYtSrkMsETC
	QnAjFj2nfCviw3Ih4bUlb+JEqXe3KZUrMk9nWZeI9QSjux8ez4mpN1yMYNLYhm2NZoOU+7RnHdx
	pKDf03wPtY6pzmBlraAWo1YezGH+dFWjtdukJQZKYUW1wmneQBl32SJxgW/V2j2L3NzUoBtmyz1
	SGubW
X-Received: by 2002:a05:690c:f14:b0:80f:3e90:f021 with SMTP id
 00721157ae682-820228786a8mr23452977b3.4.1785920784114; Wed, 05 Aug 2026
 02:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805063826.95682-1-gahing@gahingwoo.com>
In-Reply-To: <20260805063826.95682-1-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Wed, 5 Aug 2026 11:06:12 +0200
X-Gm-Features: AUfX_mx8sZ1oOBpyF-eiDObnyjKAjph0uq8_vhxZ1E5TqSabLpwhaozpHST2Zho
Message-ID: <CAEWPSH5K-x7bEuQihv+ofodvnCoeVJfWts+FoAcYmfp+uggALQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, alchark@flipper.net, 
	chaoyi.chen@rock-chips.com, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

Thank you for the fast respin, and for the correction in the cover letter.
Retracting the zero point reading in public, in the same cover that carries
the fix, is the right way to handle it, and it makes the series easier to
reason about rather than harder.

On the two items that touch rocket_job_handle_irq(): understood, and agreed
that a repeat of the v3 bench would not say anything useful about them. I
will characterise the shared path on RK3588 rather than re-run it, and
report separately on 6/8. What I plan to look at, so you can tell me if I
am aiming at the wrong thing:

  - the bit exact oracle across a long run rather than a short one, since
    the poll_seq move under job_lock changes when the completion path
    observes a submit rather than whether it does;

  - the interrupt accounting per inference, which on RK3588 is a stable
    41/1/0 for MobileNetV1 on a single core, and is the cheapest signal I
    have that the restructured completion path is not double counting or
    dropping a task boundary;

  - throughput against my current baseline, to catch a regression hiding
    behind a still correct result;

  - and an unbind/rebind cycle plus a module unload under load, which is
    where the new dying flag actually earns its place.

If there is a specific ordering you want exercised, say so and I will add
it.

Now the open question, what condition makes the block load its
configuration at all. Three things, in the order I would spend time on
them.

1. The complement of your marker test.

Your marker byte covers the failing job's own output BOs. Would it be cheap
to run the mirror image: fill the *resident* convolution's output BOs with
a marker, then submit the different convolution that walls, then read the
resident job's buffers back rather than the new one's?

Everything you have measured is also consistent with the block never having
stopped executing the resident configuration. It computes byte exact from a
regcmd buffer full of 0xdeadbeef, so on a repeat submit it is demonstrably
not fetching. The failing job's output is untouched in 100 percent of the
buffer, which is exactly what you would see if the block wrote to the
previous task's addresses rather than to nothing at all. The resident
convolution keeps working across the failure, and going back to it is byte
exact. And the only case where corruption changes the result is the first
submit after a resume, which is the one submit that follows the domain
reset cycling patch 5 adds.

If the resident BO's marker is gone after a walling submit, then the
failing submit is not a no-op at all, it is a re-run of the last
configuration the block ever loaded, and the question narrows from "why
does it not start" to "why does the configuration fetch stop happening
after the first post-reset submit". If the marker survives there too, your
no-op reading stands and this costs you one run to confirm it.

2. Read pc_task_status (0x003C).

This is the one register that speaks directly to "does the block load at
all", and as far as I can tell nothing reads it: not the driver, not Mesa,
not this series. rocket_registers.h already defines REG_PC_TASK_STATUS, and
the driver has exactly three readl calls in the whole tree, for
INTERRUPT_RAW_STATUS and the two VERSION registers.

The RK3588 TRM describes 0x003C as bits [11:0] current task counter value,
plus flags for the first and last task operating and, separately, for the
first and last task's register *fetching*. (The bit numbering in that table
is visibly mistyped, 12 and 13 appear twice, so the flags would need
probing rather than trusting.)

Would a read of 0x003C before TASK_CON, after TASK_CON and after OP_EN, on
a computing submit and on a walling one, separate your two remaining cases?
A counter that still reads non-zero on the walling submit would say the
TASK_COUNT_CLEAR pulse that hw_submit issues on every submit is not landing
on RK3576, which is the same failure shape as the MMU that accepted reads
and silently dropped register writes until the right clocks were on. A
counter of zero with no fetch flag would say the PC never started, which
points somewhere else entirely.

If it helps, tell me where you want the reads and I will run the same three
on RK3588 and post what a known good submit looks like, so you have a
reference rather than an isolated number for a register neither of us has
ever seen the contents of.

3. The pc_sel readback, and one control run that only I can do.

hw_submit writes PC_BASE_ADDRESS twice: first 0x1, which the TRM defines as
pc_sel =3D 1, slave mode, "use AHB to set register", and then the regcmd
IOVA, whose bit 0 is 0 and which puts the block back into PC mode with AXI
DMA fetching the config. Nothing reads that register back. Given that you
already found S_POINTER bit 0 reads back 1 whatever is written, is it worth
reading 0x0010 back after the second write and checking both that pc_sel is
0 and that the address matches the IOVA you wrote? A block left in slave
mode fetches no configuration over AXI and keeps whatever register state is
resident, which is the shape of what you measured.

Separately, and this is the part where I can be useful rather than
speculative: I have RK3588 and the TRM, you have neither. If you tell me
precisely where you patch the regcmd head, I will run your 0xdeadbeef
corruption on a repeat submit on RK3588 and report whether it produces a
wrong result there. If RK3588 always fetches and always goes wrong under
that corruption, then "computes byte exact from a dead buffer" is already
anomalous on RK3576 for the submits you are counting as working, not only
for the one that walls, and that would move the resident state question to
the centre of the picture.

One smaller thing, since it is two lines. The TRM marks bits 16:0 of
pc_interrupt_raw_status (0x002C) and pc_interrupt_status (0x0028) as W1C in
their own right, not read only, and the driver only ever writes
pc_interrupt_clear (0x0024). Three write-one-to-clear registers, one of
which is written. Since the bits your poll tests, DPU_0 and DPU_1, survive
both the clear in hw_submit and the 0x1ffff clear in the completion path,
would writing 0x1ffff directly to 0x002C and re-reading it behave any
differently on RK3576? To be clear about what that would and would not buy
you: it is about the completion signalling, not about the fetch, so it
cannot explain why the block does not load. It would only tell you whether
the stale latch is a separate clear-path quirk you can take off the table
while you chase the real thing. And I am reading the RK3588 TRM, so I have
no way to know whether the RK3576 block keeps the same attributes there.

Thanks again for the credit in the cover letter. It was a pleasure to have
something useful to say.

Igor

P.S. The subject lines carry the version twice, "[RFC PATCH v5 v5 1/8]"
through 8/8; the cover is the only one tagged correctly. Harmless to read,
but b4 and patchwork both parse that field, so it is worth fixing before
the next spin.


On Wed, Aug 5, 2026 at 8:38=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> wr=
ote:
>
> v4 was supposed to be a fixes only revision and its patch 4 was not.
> I trimmed the series out of my debugging tree and the trim missed
> rocket_job.c entirely, so 202 lines of ping-pong experiment went out
> with it, including a rocket_core_state_init() call that runs
> unconditionally from rocket_device_runtime_resume() and would therefore
> have replayed the RK3576 vendor init on RK3588 as well. Igor Paunovic
> caught it when he went to re-test, before it cost anyone else time.
> Sorry for the noise.
>
> That code is gone. rocket_job.c is back to +72 lines, which is v3 plus
> the two fixes v4 was meant to carry.
>
> Tested on a Radxa ROCK 4D, on next-20260730.
>
> Changes in v5
> -------------
>
>   * accel/rocket: the experiment code v4 shipped by mistake is removed.
>     No module parameters, no snapshot ioremap, no regcmd patching.
>
>   * dt-bindings: the RK3576 nodes never validated against the RK3588
>     binding, which still described RK3588's shape only. Igor ran
>     dt-validate and found ten failures across the two cores: six clocks
>     and two power domains where the schema allowed four and one, and a
>     single reset where dtschema infers minItems from maxItems and so
>     requires two. The property ranges are widened and each SoC is pinned
>     back to its own shape in allOf, so nothing loosens for RK3588. I
>     checked that by giving an RK3588 node a fifth clock and confirming
>     the schema still rejects it.
>
>   * dt-bindings: new patch. The resets that patch 5 adds to the NPU power
>     domain nodes had no binding at all, and pd-node is
>     unevaluatedProperties: false at every level, so the DTS could not
>     validate. Also found by Igor.
>
>   * dt-bindings: new patch. The NPU MMU nodes carry five clocks and no
>     clock-names, which rockchip,iommu.yaml does not allow either. This
>     one is not cosmetic: with only aclk and iface enabled the MMU accepts
>     reads and silently drops register writes, which is what commit
>     841363ebb508 ("iommu/rockchip: Take all DT clocks") was for. The
>     schema is widened to match, minItems stays at 2 so every existing
>     devicetree is unaffected, and the DTS gets its clock-names back.
>     Found by the Sashiko bot.
>
>   * accel/rocket: the poll work checked its sequence number outside
>     job_lock, which narrowed the race it was meant to close rather than
>     closing it. poll_seq only moves under job_lock, in hw_submit, so the
>     check belongs there too. The shared part of the completion path is
>     split into a helper both callers use. Also from the bot.
>
>   * accel/rocket: rocket_job_fini() cancelled the poll after
>     drm_sched_fini(), but the completion path submits the job's next
>     task, and drm_sched_fini() does not wait for work already queued, so
>     a poll could arm the hardware while teardown was disabling clocks.
>     A dying flag now stops that before the scheduler goes away, and the
>     cancel stays after it so a job running at that moment cannot re-arm
>     the timer behind it. Also from the bot.
>
>   * rk3576-rock-4d.dts: the commit message now says why the supply is
>     marked always-on and why only core 0 is enabled, rather than leaving
>     both to be asked about.
>
> Igor, this is not the mechanical respin I said it would be. The last two
> items restructure rocket_job_handle_irq(), which is the RK3588 path as
> well, so it needs characterising rather than a repeat of your v3 bench.
> Both are gated on soc->poll_completion for behaviour, but the code
> underneath is shared. Thanks for reading the diff instead of trusting
> the cover letter.
>
> Verified on hardware, twice, with every debug knob off: the NPU probes
> with the two domain list, a known byte exact convolution stays byte exact
> six times over, running a different one and coming back is unchanged, and
> unbind/rebind rebinds cleanly and runs again with no warning.
>
> What is still wrong
> -------------------
>
> A single convolution is byte exact, and re-running it is byte exact every
> time. A different one after it computes nothing, while the resident one
> keeps working, and going back to it is byte exact again.
>
> Igor suggested on the v4 thread that this reads less like a register we
> fail to write and more like something the block never re-fetches, and
> that the useful question is whether the regcmd is read at all. That
> turned out to be the right question, and the answer is now measured.
>
> Overwriting the head of the regcmd buffer in place, just before OP_EN,
> changes nothing for a repeat submit: it computes byte exact from a buffer
> full of 0xdeadbeef. The same corruption on the first submit after a
> resume makes that job wrong. So some submits load their configuration and
> some run from resident state, and the write itself is confirmed by
> reading it back.
>
> Filling the output BOs with a marker byte just before OP_EN says what the
> failing submit does with that state. On a submit that computes, the
> marker is gone from every byte and the result is correct. On the submit
> that walls, the marker survives in 100% of the buffer.
>
> So the failing submit is a no-op. It does not read its configuration, it
> does not compute, and it never writes its output, which means it does not
> know where the output goes. It still looks like a completion, because
> INTERRUPT_RAW_STATUS PC_DONE is permanently latched and the poll
> condition is therefore always already true.
>
> I have to correct something in the v3 and v4 cover letters here. Both
> said the failing job "writes out a zero point surface", and I read that
> as the MAC producing nothing. That was wrong. A fresh shmem BO is zeroed,
> 0x00 plus the +0x80 that teflon applies on readback is 128, and 128 is
> exactly what I had been calling the zero point fill. The buffer was never
> written at all. Nothing was ever measured about the MAC on this path.
>
> That also retires the ping-pong lead from the v3 thread, and not because
> the observation was wrong. The pointer is stuck, S_POINTER bit 0 reads
> back 1 whatever we write, but flipping it, selecting a bank the way
> rk3576_state_init does, and pulsing POINTER_PP_CLEAR are all null, the
> vendor does not switch banks per submit either, and adding its state_init
> verbatim changes nothing. The bank is about where a configuration lands,
> and the configuration is not being read in the first place.
>
> What is left is the condition under which the block loads at all. That is
> what I am chasing now, and suggestions are very welcome.
>
> I used Claude Opus 5 to trim this series out of my debugging tree and
> generate the diffs. It is also what missed the hunk in v4, so this time
> the trimmed tree was diffed against v3 patch by patch and grepped for
> every experiment symbol before sending.
>
> Jiaxing Hu (8):
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
>   pmdomain/rockchip: add optional per-domain power-on settle delay
>   pmdomain/rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
>   arm64: dts: rockchip: rk3576-rock-4d: enable NPU
>
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml  |   8 ++
>  .../bindings/npu/rockchip,rk3588-rknn-core.yaml    |  47 +++++++-
>  .../bindings/power/rockchip,power-controller.yaml  |   8 ++
>  arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  10 ++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  80 +++++++++++++-
>  drivers/accel/rocket/rocket_core.c                 |  26 ++++-
>  drivers/accel/rocket/rocket_core.h                 |  20 +++-
>  drivers/accel/rocket/rocket_device.c               |   4 +
>  drivers/accel/rocket/rocket_drv.c                  |  22 +++-
>  drivers/accel/rocket/rocket_job.c                  | 121 +++++++++++++++=
++++--
>  drivers/pmdomain/rockchip/pm-domains.c             |  71 ++++++++----
>  11 files changed, 373 insertions(+), 44 deletions(-)
>
> --
> 2.43.0
