Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746088;
	b=0cws68IASQxIRTQRePA9AFd/4DB/vgL2AoMz9q2ZxXCou2Njyu0bceUIF8XKgegBEMJP
	 oFObaCLEQx/hF3zs6ACe1kCIKDOXzF/2/S/d0s9oblsznsKk41Ufn1/+vigVODtXtWJD7
	 xtwZihuhE2sTJU/zy391n3TzibVZ6OcKlIQwnRtZHkFntqRzfrEANRQIuPTniKDIO5LzG
	 7TpvzaVcFYPdNE+G13OZJEm4QM9w3VgFRRFfW6k1+Uq+XC0H9hZhGRdFUKDsVUnieVGkF
	 dUiIvpNYI3HfYcL9L+oRW2FlJ77wfiG7aNKMC+OSw/iyh0a9K8f/r1/yQ/5uge2JeSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746088;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=7V+9u/mBqZmqOYGdyoT/7+oFKZYRr17cEQ3cVzZJ9rw=;
	b=sOX05M05bs+/ipiW/lr+o8KUxDegJv2BHO0sm4KTuoVIXlnlFMpJCHW8dyGVNCpzGTm9
	 6xIUFNeACd9ZTrUDx8tXvxka51UicEHPNqhiJ7uye81jKdVg/Y7/dR6Pry/ULQ6RtRQbo
	 kp7PVlqU5DmkE4FxYwKjWntbpBu7bXU9ZQqEtodnw8GqFZ8CvwOx2vthJ/956NCz1Vwok
	 q4FhJFyMIMXU/maxM/2bB8nBSAbiwSdV22Unksyh3CWyr9ZlITDNksvVF9xdVK5/XuyUS
	 sMjKCYZWZpl3TRAa51Q1lqDfYAahUMNRM9w09FdFQrzuYfU78/v08ToNwQQTTMJ6Pjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=rHGjeSwI;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670E606A31B;
	Tue,  3 Nov 2026 22:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C670E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=rHGjeSwI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=7V+9u/mBqZmqOYGdyoT/7+oFKZYRr17cEQ3cVzZJ9rw=; b=rHGjeSwIvdld7UkcYoi40YgoyZ
	JaIclCu/NOQLtcHJRaQCNk9QsExRXWMq1vaCRnKz+KWW093oQYAlSKpj/DmIm5ItQuSsg82BJUFGn
	ACBj6WsyIi7jBos+IFDv+UnbMEbCFu+5K8v4mkNiMg6q3OWp5YbsRxXBm+VoKy5h6PU/+6+WrUENm
	t8vlML31g3CXxZ4CSZRyjIB31nvF6aZ061bEidRTd10EzM1VKq0JQ2mz1Fft++mOvIAuhpGCqiBUz
	YRNoIls6dJOwJHvUxF+i06VArQYpjgXoR2rA4sdGawNegoCqkqG88HDBdQnPAwHmKwBhARvFNg3nw
	ZxClQfcw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler before
 resetting a core
Date: Tue, 03 Nov 2026 23:47:32 +0100
Message-ID: <3654048.cLl3JjQhRp@diego>
In-Reply-To: <20261101082307.151957-4-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-4-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 1. November 2026, 09:22:55 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> drm_sched_stop() does not wait for a threaded handler that is already
> running. Call synchronize_irq() after it, outside job_lock, which the
> handler takes.
>=20
> Before the sync, mask the block's interrupt and clear its raw status, so
> that an active core cannot signal a completion after it. Do that under
> job_lock, since rocket_job_hw_submit() arms the same mask under that lock,
> and only when pm_runtime_get_if_active() returns a positive count: the
> reset holds no runtime PM reference, and with the domain down a register
> access takes an async SError.
>=20
> Igor Paunovic's induced-reset runs on RK3588, including a two-task job th=
at
> puts hw_submit() on the IRQ thread, found no fault; as he put it, "this
> does not show the race is closed".
>=20
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
=2Ecom/
> Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaX=
Q8HoMtHD5U1g@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail=
=2Ecom/
> Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmai=
l.com/
> Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gma=
il.com/
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, i=
nduced reset, JOB_TIMEOUT_MS=3D2
> ---
>  drivers/accel/rocket/rocket_job.c | 71 +++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 03e5f094f60b..5b2abf40b618 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -401,9 +401,74 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>  	drm_sched_stop(&core->sched, bad);
> =20
>  	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> +	 * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK on
> +	 * every submit and only the hardirq clears it, so on an ordinary
> +	 * timeout it is still live and a completion can arrive after the sync
> +	 * returns. The next submit re-arms it, so nothing is lost here.
> +	 *
> +	 * Only when the device is already awake, though. This function holds no
> +	 * runtime PM reference of its own: the only one in the window belongs =
to
> +	 * in_flight_job, and the completion path may have put it and cleared t=
he
> +	 * pointer before the timeout worker got here. drm_sched_stop() above c=
an
> +	 * block for a long time, and it drops every pending job's credits, so
> +	 * rocket_job_is_idle() is true and nothing keeps the core resumed. On
> +	 * this hardware a register access with the domain down takes an async
> +	 * SError, so a reset must not be the thing that causes one.
> +	 *
> +	 * Only a positive answer will do. pm_runtime_get_if_active() tests
> +	 * power.disable_depth before power.runtime_status, so -EINVAL MASKS a
> +	 * suspended device rather than excluding one: pm_runtime_force_suspend=
(),
> +	 * which is this driver's own system suspend callback, disables runtime=
 PM
> +	 * first and turns the clocks off second, and rocket_core_fini() suspen=
ds
> +	 * the core and disables before it cancels the timeout worker. Both lea=
ve
> +	 * the domain down with -EINVAL on offer.
> +	 *
> +	 * The cost is the other half of that ambiguity. A core that is still up
> +	 * with runtime PM disabled (pm_runtime_force_suspend() before its
> +	 * callback has run, or CONFIG_PM=3Dn under COMPILE_TEST) is left unmas=
ked,
> +	 * because writing to it would mean writing to the half that is down as
> +	 * well.
> +	 *
> +	 * Clear the raw status along with the mask, the way the completion path
> +	 * does. Masking alone leaves the DPU bit latched until
> +	 * rocket_core_reset(), and the hardirq decides on raw status alone, so=
 a
> +	 * fault from the IOMMU that shares this line would wake the thread aga=
in
> +	 * and what the comment below asserts would stop being true.
> +	 *
> +	 * UNDER job_lock, because rocket_job_hw_submit() arms this same
> +	 * register and always runs under that lock. reset.pending is set here
> +	 * without the lock and read there with it, so a submit that has already
> +	 * passed its check can re-arm the mask after this clears it, and then
> +	 * the synchronize_irq() below fences a handler that is no longer the
> +	 * one that matters: the block is left running a task with its
> +	 * interrupt live. rocket_job_handle_irq() avoids the same race on
> +	 * OPERATION_ENABLE by making its completion writes under this lock.
> +	 *
> +	 * pm_runtime_get_if_active() does not invoke a callback -- it only
> +	 * takes a reference on an already-active device -- and
> +	 * pm_runtime_put_autosuspend() is asynchronous, so neither can re-enter
> +	 * this driver's runtime PM callbacks while the lock is held.

This can be way short please, the wall of text is very hard to read.

> +	 */
> +	scoped_guard(mutex, &core->job_lock) {
> +		if (pm_runtime_get_if_active(core->dev) > 0) {
> +			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
> +			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +			pm_runtime_put_autosuspend(core->dev);
> +		}
> +	}
> +
> +	/*
> +	 * drm_sched_stop() returns without waiting for a threaded handler that
> +	 * is already running, so wait for one here. This has to stay outside
> +	 * job_lock: the handler takes that lock, so waiting for it while
> +	 * holding it would deadlock instead of fencing anything.
> +	 */
> +	synchronize_irq(core->irq);
> +
> +	/*
> +	 * No handler is running now, but we might still have stuck jobs. Let's
> +	 * make sure the PM counters stay balanced by manually calling
> +	 * pm_runtime_put_noidle().
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
>=20




