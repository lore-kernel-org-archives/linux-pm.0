Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509898;
	b=suP5JDpnoqryY4M+O8lStZbm1CWH548rG3MY386ne8lStUIYHZn7FC634MBfac6OZHJM
	 sx9LHupP5ISn3++kz3wDejYF79jGaXbeuHecnStq4XyUBBfsEAAqKk6EUdg4wroQME5Ya
	 0v6lHfAIdHjSysbr2T+5ZXagmobh55ngOjIn/hdaCRW99c6VYOamn9aNFt5I+pYB2O6q0
	 4XN+trGt8RSCxZD++qYtLzZn27uSADrNw2oHINAt1JGuYcoZE6Wa4VjETZ0IEHDj+Ow37
	 HzNJRgkbLuCi5+4D/9LXow6+lZ/Y9CkvK6fK8cBYILtQHy2wXiBD5HbdsGoKDjZh9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z0LqVPtG90eWIMD2SZHKU3bFXknR8F28KDHs5gdoi8g=;
	b=jL0PaewRe0JZa8FOn9aiiQ0LbNrpB85UGWOX3ybvwndQAk2zSMugmKdAO6TCjSkUMCmA
	 FoLmWKK+KnvIPYmGzAQgei5cc2zuRp1Vw4AhQlOr2QLLIXcRo0qWVpsZ7lg9siJ1YbfDC
	 iEMsGjNX6MbQLgFid+f3zUIyiA5ChK0iblGcwfwgsukDJ18X9YtLYuZ5Y2So/UMObIgHl
	 3axjmj4iKrIjWPuryfhrOJU2XJmU/H5/GzRuTi1gnScZkeLFkcGhN2xusT9SpBvBP58RP
	 elwrp8BnIeRWDRr5LWuWX2wBO9ykFk/w5A1qWyux7XARoaCKGkUaGKOIQirBTL2sZ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="H6/u6aMe";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD7606A8A4
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 18:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DD7606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H6/u6aMe
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so164005a12.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794509896; x=1795114696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z0LqVPtG90eWIMD2SZHKU3bFXknR8F28KDHs5gdoi8g=;
        b=H6/u6aMevFmaek2eIrsT9Js2G+OK1wpOUy0QJBVKr+4eLcwImjTGc0i1uPouEQRKUN
         HE4SHejC/eY2k9C0mc+1amAnDVXmFVPa3GSUTshA3EOfCmbqB6/8o1FnGIWbSZqP4tRH
         Gi9DmPc5ye/t3PsVVgPyj7pWV2MgLl+zXJWa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509896; x=1795114696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0LqVPtG90eWIMD2SZHKU3bFXknR8F28KDHs5gdoi8g=;
        b=uJaIdMVHmicDiAXUuQj9FSjaENsshoq2ukQPeEk6SGRHCtYEV1u1UF5EVngTaKJD05
         Fb+Tlnp94IPi0okbPQlkeyKxyFQODflUkpr2jlkMUOp2x9ccYdtQy9MZhXlqAqZLeD3o
         Coo5MCdLGdvZXiSQTiXKnUrcS0a7b/4CX9L6ytdwwU1R7yfiy4ECPL80woQcW84ebzfv
         fgRldYfdxwctO20pz2TxuY7M4it7W78g+BCk5/lAGUwx57jzLHs8AuqRhH20MqNUpSxx
         +u9mGUkgDj9dwIv+zcq0CE4bsmMCYIX3KM20o6dnYs1KCNj0FGXeCNly3AbtUk9xlJkM
         tFBg==
X-Forwarded-Encrypted: i=1; AL+hErExkuUnKBgZBC1RLZghkg5p5cyKjijBb9rIgYASQvDB+0VLLKEljur8oi4MPfF8n8CQ7JCHzV1FTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8UzS2Kd42NnFkbyNIArW9ck/1VmchWKyUy9R+dbKJfTKbSqkAz
	DFEjksaEhX5Tor2wtqRXm4/SJjWLU6IVv7aiFH0BrTTVQ4FkpdLWCAUVf8DF8G5EOghKJvldHli
	8Das7QA==
X-Gm-Gg: AYBFou38XFu2tPvFRAQrUQ3es+2OHQZXDLHG7bI1U178dhU4zJ1kvEXlyqSnPdiPg/B
	YJeuKa9e2IllzqjW7P6UySWPYOjBmLeQSxu5Y24ftuZV2SIlbgde2T+C8M4Ot2NOQnTWO8RHUs1
	LRwjMY/rvH//m4YwoSV5fc4N5jcSbJRup3/lo/VEixw+HrfFZQsqyvYPtFdN1GZGGIDfDp1icsZ
	DWPMDV6khJBVSRUXOC79rN/xeYEE6UgK9q8hGY9fNMJKbUC2W78k+iIoT369zaSkQNoZimq76KD
	/2RFe0eJpphThRD6HPqjZM/GfV9lsfbs8n3LVfnSoBK5B49Wr6pr+ND0LT70nXaLGcpRzrzVQ9j
	2Kh9pbSmpLkyDYLeHZrXGtQ9zNdUMUcdgujEtLOL0q7m1Fx/1ne1kuuprUlEWSQIieDpyWuN55e
	dV+OuNSf0qUOxBYgGGImMecJQ2dJDLLl4HzxZmX+sP9kmpbbohHDQ1eB1qztiMryO7v46z1/r25
	GblrrVLmjCEZEFt3s2H8sdGgB1SIx8AOMYTCvglnWm2PrFAlqx1IbLYQIcRoDoTAfoZ25B5fDM9
	IPs+dvbEiNEYFbpdAIvrgUlrCboIXdkS4sxgIg8Y2GxagVK1NW76meFFQfRcL6FPvbn1qA9koyl
	t+Gf0E1g/FNy70w==
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr457402a12.20.1794509896038;
        Thu, 12 Nov 2026 10:58:16 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b79d19sm7543166b.71.2026.11.12.10.58.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:58:15 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so1055585e9.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 10:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEkRMan9kpWAz2IVEx4um4Z0aoL70iywnPRxiR8EW3ejPSpvgE64FS9Ott8XSLhjxkqPpZrCSy6iw==@vger.kernel.org
X-Received: by 2002:a05:600c:1c18:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4bb55ac0e34mr2161075e9.27.1794509892596; Thu, 12 Nov 2026
 10:58:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261006231900.3230373-1-briannorris@chromium.org> <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
In-Reply-To: <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Nov 2026 10:58:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VbcYGJP6ag_pxwNB3s2iedeF8rey9QUZo3B2YQm25diw@mail.gmail.com>
X-Gm-Features: AclHuK_PiPmNrCWJDrFpHZHvHvTj2hKqQgB_JTPOXCKXOf56_rtdlcICXQ5xuAY
Message-ID: <CAD=FV=VbcYGJP6ag_pxwNB3s2iedeF8rey9QUZo3B2YQm25diw@mail.gmail.com>
Subject: Re: [PATCH 02/13] drm: Discard pm_runtime_put_autosuspend() return values
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Melissa Wen <mwen@igalia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 6, 2026 at 4:19=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Several DRM drivers use or propagate the pm_runtime_put_autosuspend()
> return value, which is not particularly useful.
>
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
>
> For this reason, modify these drivers to simply discard the
> pm_runtime_put_autosuspend() return value, and change the return type of
> v3d_pm_runtime_put() (whose return value is never used) to void.  Also
> drop the redundant pm_runtime_mark_last_busy() calls right before
> pm_runtime_put_autosuspend().
>
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
>
>  drivers/gpu/drm/panel/panel-simple.c | 8 +-------
>  drivers/gpu/drm/tidss/tidss_drv.c    | 7 +------
>  drivers/gpu/drm/v3d/v3d_drv.h        | 4 ++--
>  3 files changed, 4 insertions(+), 15 deletions(-)

FWIW, the hunk against tidss_drv.c goes away on the top of
drm-misc-next, since it's 100% identical to what landed in commit
2cc797f73768 ("drm/tidss: Drop WARN_ON() from tidss_runtime_put()").

The changes to the other two files look fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next.

[02/13] drm: Discard pm_runtime_put_autosuspend() return values
        commit: c88084027d0e922dd925b96e5a0d184ba04a8f43

-Doug
