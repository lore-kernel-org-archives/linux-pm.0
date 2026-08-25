Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783D42E007
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661099; cv=pass; b=FN7iFbDTSrjMYlrbWUPy3DBZRwa5DN3ZmnXVWWRkcrHjV8FalqyoS8X4boQa5mltDJiQ4gH/b3Q6GKVcijOLgnTPcjqHvdlPoak2W4VbSmwVsswEPYxL6ORDHl9Qj6j+kzz/GxvOePpH7LgD/ykmULD1nTyU+XdJZo8cpUTVpBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661099; c=relaxed/simple;
	bh=KLVbc8WLHKERKnG9obTVBGbSM+aCFle3c4tKE2S94Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dk8mZGrIs++2oO4v5DwSZr69u2KIssNkI17QA0aCwt1vjZC3U7Y9P8RGy91aMEb2lraP7o0VbXMa8wCR4R3v6WpcafW50nciWDBem6TBvcwh40j1IYZRFowZ3f7NRU2ovokFhuG3GbRa26ZEQu21P6M+Tobu+VgJvc5jmZwAXsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1c2RKVb; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1c2RKVb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-85569d3a6f7so197387b3.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661091; cv=none;
        d=google.com; s=arc-20260327;
        b=lXN7Rw4Ux2Ev5+4Kt336zZG3SHD+ej5hO4cl2xEjdhVvVTh9ohYqZvGdKvnvodM/go
         VL/21cSjoTeMl5WVH+3wg/tsEBxyrqoS0RpIqD5anGc6t5/EVeGd2HKr9BMoyVK+EGQD
         vIHxPcEiDJFFrr0II2mBFmUpcfdFjWNXGtKReSFRchwbhqvumSsQH6FpI2qzeUYmTRwI
         oYy9lv6yvLdexFlIlRu0OkZUsZCHCAt9Ge+bB6134FfRO0f+6oFZJPB0Uuw4UemJfOGK
         xoxMEz0nlD1VqUysv+4uwGMeJuyRT5KsL6HgBSgGGArTjmgl3XKj22G8fqGwkW3nLnKn
         K4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
        fh=ITJb1YPudmRtUmvjrERpUe63fqRhXbT7KjIxnhXbo3s=;
        b=DdvahFv19a+XH+ToDVlwCW7ES/OZWzFp0iaWtmPbMUNv0BvNvmKaKfpD8DrOW6wpvM
         lb803CtDoyPSCT3sjb9w9IDjeUwLGKbShz+1mU8Nv8DVIC3va/VKLCGxPH/7wx+oN6Ca
         LydgtFOxma8aqHhTUwaiFbl16nptQrn4P1wQPOI699/bDgKKNbCKIFEGBO/BJvxw5BP1
         MSvZFOE0JBWR75BPjlklAsHgJmBlLDrwZxDW3Tyn7Z6S9iCGV0GqVIlqbGuUq5uCjBIp
         6NTVmoTFLm6jpfXK0rBoq4OBniVAZ5bnHwjLrgwZjht7GLCZ10POaOiXTV/7+IlI1fYf
         aG7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661091; x=1788265891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
        b=G1c2RKVboawtG4aK70Ea4Drs5ePp9yfI3yoD/FVceajDKfWSaWP+P/QyXjNNztqYFo
         7oQ+rpITj/e9FNLCW7vCEz4eRk914UOf9jf6Wm+DAr+PYdstpzurQpwPSsyI1z7dnWN5
         Ac9H4RWh+REEcTeXLdpKvq4jv8HQX8nuUt3PkRx5AixVLGfEqdiE+pPykzLa7PVVRySc
         /bRTsFYNXxWGkeMbQwIBY+Sj9yETCCIsOFKvRW+kXkpz2mOCg+IUlMdCe3Po69Ad+48j
         zR6Dyd8R9m5E9gDDY0f/9OM3ERyuCKD9PjLDroYMsEh8bq0i7KoUFJvrKVComhZTSxqw
         04Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661091; x=1788265891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0gYjv1ucDokxKoaaL4BAfVfT4VkNcel3INzlS65MsI=;
        b=EdERqizXF+2a4oB8/5PYJMgdOx/GspPOWDjo/D3he/anqrqU4uNs8a2Xcc3U0X5weP
         tdWK+yp5bDsuVGzJuYWZR29I5m8hikir5XMlFx7VZJ47P88pmj6bRATWT4WhAj1JYLDJ
         kXz/Qpz8ZNMW68dVmte90CxE+2OVLC+wfBUoAiVyaFU6I6t4Ezc4ZV3NojJ0Ye0JmRWR
         qbWosQayOAp1fzqLVZZggQ72z4OkF1bBnEvvh/AbjaFtp5tSTI+SCSmZOZDLNFLCOURD
         68+MYA8EGIYjdvjOWhxOvd3MGFddvmzKuk9th7zTuHl18P1qppxYJfA+IpZUZEY4EBM0
         G2ug==
X-Forwarded-Encrypted: i=1; AHgh+RojM+sPMBQC9G3Ho543e+hKttzCsWQo5fwSpsDFKXu5pryApWdjqwztsxJzI746mBHXxPnnhQLaBA==@vger.kernel.org
X-Gm-Message-State: AFuF++lzuBRuStYPEF7aKR4DDNVezYLcmA61v8OX2Rz2xr57+LFyJ3Qu
	PaJrcLgmASpGiyD5cfo0EB0xN5oHmXLgFFhrGBx/8m1LyEI/uI5+aSiYiDWkWDtfeC5a8EBp548
	dU/J5H+OWP1FSBo+2psvUCdJ7fRI/64I=
X-Gm-Gg: AR+sD11+wqVt3TuKCz6kQoWsVQDuIZfMYT0MB3GQ2XEY0jN8jtT44qGjQRZlKE1hJ4U
	xCI6j3gsPSIJoRlla+aGuPNjoCo27khrBizno6zX5q1Xp9g1T/VAZGI7Hcg0UueLcUlbewUqW1v
	9zgZhkOGXSLom99bwcGIdHqBe7n57AgegWrIWalrHFFJqxHGHKRsylxgmDOmD4CNSQAvL3xiFpX
	k2owu8/NBM4r7xuTfWzam/AyR24w/Empj+ez3+t3y4Qag24fYvN1itmeuIHO0b2GaXeEa4EnYFn
	1PdUQ4QFaS0s/QY9qUAaWya8h7AMH50YWc7FIje6YX5VUw==
X-Received: by 2002:a05:690c:610d:b0:81f:45f0:21b7 with SMTP id
 00721157ae682-854bd19ce2bmr22184007b3.0.1787661091147; Tue, 25 Aug 2026
 05:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:31:19 +0200
X-Gm-Features: AcwNN1UBjSiDmBbvi-rdrGxY2QMseNtuQmYMP06jtM-iH2d8s_qF62MX0JMUhl8
Message-ID: <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
Subject: Re: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

As promised, the 19 August protocol re-run on v9, as-is.

Setup, identical to the run reported against v8 1-2/12: same
board (RK3588, Orange Pi 5 Plus), same personal 7.2-rc6 tree,
same config (PROVE_LOCKING=3Dy, DEBUG_ATOMIC_SLEEP=3Dy), all three
cores bound with scheduler-driven placement, and the same local
test-only patch lowering JOB_TIMEOUT_MS to 2 ms. The serial
console was captured on a second machine for the whole session.
Two passes per kernel, at console_loglevel 8 and 4. The only
difference from 19 August: the two rocket changes on top of the
base are now v9 1/13 and 2/13 instead of the v8 pair. Both
applied cleanly.

v9 arm: two passes, 12 and 11 induced "NPU job timed out"
resets. Every reset recovered, every inference matched the CPU
oracle within 1 (48/48), including the one issued after a
forced autosuspend and resume. No MMU faults, no raw reset
messages, no lockdep hits, nothing on the serial console.

Differential arm, fresh in the same session (same base with the
two patches removed, same config, same timeout): five runs -
the protocol pair at loglevel 8 and 4, plus three extra runs at
loglevel 8 to gauge repeatability. Reset counts 8/10/12/8/15,
all recovered. Four runs clean. One of the extra runs came back
with something I had not seen before: the inference after the
forced autosuspend "succeeded" but returned a constant buffer -
all 48 output channels uniformly 128 (0x80), which is not the
output zero point of this model, while the CPU reference varies
normally. Zero kernel messages, zero lockdep hits, nothing on
the serial console. A job that signals completion while its
output buffer is never written is exactly the silent flavour of
the race these two patches close, and in 102 induced resets
across nine runs today it appeared only on the arm that does
not carry them. Full artifacts are preserved (scorer output,
runtime and genpd state, journal, serial log) if anyone wants
them.

Before testing I also compared the tagged patches against their
v8 counterparts: 1/13 is byte-identical to v8 1/12 up to the
base-commit trailer, and 4/13 is identical to v8 3/12, so the
tags they carry describe exactly what was tested here.

For this patch:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three
cores, induced reset, differential base, JOB_TIMEOUT_MS=3D2

Regards,
Igor

On Mon, Aug 24, 2026 at 1:09=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() calls drm_sched_stop(), which stops the scheduler and
> returns. It does not wait for a threaded handler that is already
> running, so the comment that follows, "Remaining interrupts have been
> handled", states an assumption rather than something the code arranges.
>
> Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
> comment to say what holds afterwards.
>
> It has to go before the scoped_guard(mutex, &core->job_lock) rather than
> inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
> handler while holding that lock would be waiting for a handler that is
> waiting for us. Nothing is held at that point, and both callers,
> rocket_job_timedout() and rocket_reset_work(), run in process context,
> so sleeping there is allowed.
>
> This does not stop a handler that has already read in_flight_job from
> finishing its work on the job the reset is about to drop. That window
> needs the check and the register writes to be one step under the lock,
> which is what the previous patch does; the two are complementary.
>
> Mask the block before the sync as well. INTERRUPT_MASK is armed by
> hw_submit() on every submit and cleared only by the hardirq, so on an
> ordinary timeout it is still live and a completion can arrive after
> synchronize_irq() returns. Nothing is lost by clearing it, since the next
> submit arms it again.
>
> That write is the first register access this function has ever made, and
> it is guarded, because the function holds no runtime PM reference of its
> own. The only reference in the window belongs to in_flight_job, and the
> completion path can have put it and cleared the pointer before the
> timeout worker arrives: drm_sched_stop() sits in between and can block on
> cancel_work_sync() and on a dma_fence_wait(), and it subtracts every
> pending job's credits, so rocket_job_is_idle() is true and
> rocket_device_runtime_suspend() will not refuse. With the autosuspend
> delay elapsed the clocks are off and both NPU domains are down. A
> register access in that state takes an async SError on this hardware,
> which is the failure two later patches in this series describe from the
> power-on side.
>
> pm_runtime_get_if_active() resumes nothing and allocates nothing; if the
> core is already down there is no live interrupt to mask and the following
> synchronize_irq() is all that is needed. Igor Paunovic asked the general
> form of this on v8 -- whether rocket_reset() should hold a reference --
> and it was deferred then because nothing in the path touched a register.
> This patch is what makes it matter.
>
> The deadlock this placement avoids would not have been reported. The wait
> is on desc->wait_for_threads rather than on a lock, so lockdep does not
> model it and it would have hung silently.
>
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 34 ++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5f0f9682e..3c0ed4605 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -377,9 +377,37 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>         drm_sched_stop(&core->sched, bad);
>
>         /*
> -        * Remaining interrupts have been handled, but we might still hav=
e
> -        * stuck jobs. Let's make sure the PM counters stay balanced by
> -        * manually calling pm_runtime_put_noidle().
> +        * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK=
 on
> +        * every submit and only the hardirq clears it, so on an ordinary
> +        * timeout it is still live and a completion can arrive after the=
 sync
> +        * returns. The next submit re-arms it, so nothing is lost here.
> +        *
> +        * Only when the device is already awake, though. This function h=
olds no
> +        * runtime PM reference of its own: the only one in the window be=
longs to
> +        * in_flight_job, and the completion path may have put it and cle=
ared the
> +        * pointer before the timeout worker got here. drm_sched_stop() a=
bove can
> +        * block for a long time, and it drops every pending job's credit=
s, so
> +        * rocket_job_is_idle() is true and nothing keeps the core resume=
d. On
> +        * this hardware a register access with the domain down takes an =
async
> +        * SError, so a reset must not be the thing that causes one.
> +        */
> +       if (pm_runtime_get_if_active(core->dev) > 0) {
> +               rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +               pm_runtime_put_autosuspend(core->dev);
> +       }
> +
> +       /*
> +        * drm_sched_stop() returns without waiting for a threaded handle=
r that
> +        * is already running, so wait for one here. This has to stay out=
side
> +        * job_lock: the handler takes that lock, so waiting for it while
> +        * holding it would deadlock instead of fencing anything.
> +        */
> +       synchronize_irq(core->irq);
> +
> +       /*
> +        * No handler is running now, but we might still have stuck jobs.=
 Let's
> +        * make sure the PM counters stay balanced by manually calling
> +        * pm_runtime_put_noidle().
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> --
> 2.43.0
>
