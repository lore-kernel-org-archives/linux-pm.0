Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746285;
	b=kjlX8GDi8ZsoK/xbuUvzJzz/Gpn+U049MpkZBywRRDLDhQrja5VFPuxqdXJW27Z3K0Cs
	 w/3DwRBHakiyi9RpxaeHEmp0hZaredeFu62hzPVZ0rj+2CLoiZhost3KSpT/cL4BbCABE
	 AY+D45m9yZttXc1OJb0DnKMZYdKj5bne06cBTO9vqD83+LmO4EA8gIekcHcgAJmVQ+NJy
	 Whm1dVYCGgHCo/4v4obZ65UnMb9WwoPLrxoDBWsKdf07wlt83J+hPu1dMMsQdBaf0NnSO
	 Qk3r/K1Ev5b3nlG/mXoA3kzivkjAjSgOkKwrEBmeAOkJzzJXoZ9e//sjIAG4sxzo1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746285;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=o7HXQPomhFEfrYFjVcsrdsok+Tx5KNS+/so3Un5/lrc=;
	b=JZjrtkpFm5V+pbUXUH3djJFuHH0JcPvKm9f6qDXhKXQ9T14auPBr3iLUhXMXweDdfALP
	 pwhIg39x+iRmufmhF3rPKrfTGLmcNu7NAo3PGo0wQDl9LX0uDSuin2bkdav+njDhgWMP3
	 KecRGcDOj0cttJqnTp5u+Uvd2cw+nhqjwyh1VXsuHDvJ5REa3zJgn/jCN6W/X9evUTdGM
	 NAwGww4rngxxLkWx0DYjgQExnFFaldAX+5O26O7/g/8yPmnUGQJb9VpXgVdUpEkP/zKeD
	 MosaEHcPHBqLCKWimxwYKXx9doEehXX4wRynXsC7MVbv3HElTv9viMYcHmayYK2Z0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=e8agXrda;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257A606A31B;
	Tue,  3 Nov 2026 22:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4257A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=e8agXrda
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=o7HXQPomhFEfrYFjVcsrdsok+Tx5KNS+/so3Un5/lrc=; b=e8agXrdauKRx9EGxkmib/g9VuU
	mDkazXkDbRhtV8JTfmGehKVWbki2agxMfivjwj3H4Z7DrWaQ87OgZlnjv96V405f70UM8mEHiCoEK
	TLd4STOnPAShQ8B5UpqgNF77zT0/kgRPw/bgf1mBJTSHL5/ItZgiw07vjqZMz8ri84ErO7Sqn5uY8
	BjeUx54xkn3O/6fjaNdEbOCVTI2mJDProM+XKVHiSN1FuQdZXYUhw8KhN0mtqJkPCyJOTIMjnsun+
	Ct9vIUE/vopzPCY8Sep1G/z0WMU8T4JLlqhKjt5CTs/Lcr32soSSG4RSYht1Z/bG5OHaAT0LNrfFx
	R/xopxBA==;
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
Date: Tue, 03 Nov 2026 23:50:58 +0100
Message-ID: <3311623.TQGk6oTFT5@diego>
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

Also, why are you changing the original comment here?
The new wording below, does say essentially the same and you're changing
it again the next patch.

[...]

> +	/*
> +	 * No handler is running now, but we might still have stuck jobs. Let's
> +	 * make sure the PM counters stay balanced by manually calling
> +	 * pm_runtime_put_noidle().
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
>  		if (core->in_flight_job)
>=20




