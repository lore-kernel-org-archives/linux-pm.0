Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B23E1696
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034012; cv=pass; b=d7X1u1Tj7q/FBFRhcHmZiniKckIXzQgGQjQCNzL2n0VUgWielXGEbAjdKGzwt+nFgX9R4UXEhbpfWSZY+mqOUEWu7snYPe0gWntIECEzeE9BcQHYlGDYKAI5TG+4kKiRwmQZmKaKiinbfAVhObSZ7ZfUJq4sEEyOVswWXM+xXxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034012; c=relaxed/simple;
	bh=3QU1jfCWX7LaB00N5H0qL0k+c5PTLtBxL0zT3CyJSO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly6GXfFRQCFgIg6jnPsD1Qhrx7Fx6hXZlIjoCk2upsFBDxjBhEboHfsGv7y8vPxX0VONn10MqVl6eIGbO3IPTR+HVsemY4n22ISZ9REaNgP//6ZL3weRGf8SwL4i55LjUU5YbWjCqKVkktmj/Tt/j6NgbnijdNmresCWzv19W+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=rzo/mAU2; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="rzo/mAU2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so860302866b.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 02:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789034005; cv=none;
        d=google.com; s=arc-20260327;
        b=i+avYW7LjL/exQ3t3/iSfcp97eUgSob5q+poNi6wCGBzOe/bn/xKr9FxcJSTML/0vQ
         c5Mi5gGB3H0Qfxl9rmhtksKONS/3gr8Be2mhJGKgWNZD+l3LYYzhtZphF1qGly79frUv
         OXw/uO4YpSILtU0YWJnIZJraDFSnVnMnKlQImzE4PMprj78HhmBsfTmqRIhNpafaaVc8
         ADoaJGVc/7GTG6zbh/TMowFWiCm1CXW2o+Bb4AhiGF+XvhR5/zRoJ1astO27YOz63GVT
         NiRjBE525SIbLutJIGj0/Z7K0xNjMBzyvLkAWbbk1rzFtcH93yqHn7+OLN4aMsFpcbfo
         LcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QU1jfCWX7LaB00N5H0qL0k+c5PTLtBxL0zT3CyJSO0=;
        fh=Vt8rCwFq0NMGyD1XSvJBrPDMEfFq49kZ7Ziq/t8u2WU=;
        b=nsdFACTKikii7yiiWPu53oKjU+f5K1LRJktox+ZZmy4G80Q59P08kY+u9Qr8iYJT8d
         e0mjeCusiT4d/8y3LQnJ1c5nrOx53nciA/O+B/CGZcPu+iwKeIQM5gs9imq39kLufo9U
         pWMK+DCyv+mkQ/S7RgN7eABqKbNgl2P3Tf7jiouuLeFHSTuDE+vxDxQxdBZQdYoULl9p
         /knTm8h9G1/asD9mbpDanmgSo+MIrBvFdCyWTWaIf7v44Jc88zgqhXUe3t8U16zijQLv
         /+UZE2urg9ClTikEhdiimZJj1o5tNYeyMdPFOxTLMlZDPMDUNpxCtfvYwinBtLjqNw6i
         ifLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789034005; x=1789638805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QU1jfCWX7LaB00N5H0qL0k+c5PTLtBxL0zT3CyJSO0=;
        b=rzo/mAU2ziGKLpvybwiDmCPq5Fq/pFXsTMY8qPbQ1DruoEIR7hpQoPR0v/JmiXPkyt
         FXjV6kfdvzaLGlAGDrwmNtfqXs7m3UmTvykHh7cKQkpMQSLO87t37QRGMOWqkS3sxnlJ
         OVg2P3aandCQZuszWHXZA3EJvnm3c/IsrvNQ8TGxzaa0JnGghW2K4Vv4TWRxCV7zOy/t
         OyAILl4ce386R/9joBv2BrKak74sFU9I5Pkf35oOIF5rO1DBdCqnPW6LFZfpoqxaDuCp
         gk2Gj3fpKFr2mxEhSbvo1q7q/hHT1lBNoBNsO+4QsCWBE9gCzQ/yUdfJynvaHkqlU2u9
         dpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789034005; x=1789638805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QU1jfCWX7LaB00N5H0qL0k+c5PTLtBxL0zT3CyJSO0=;
        b=UpVCaUVOPilLdR0/GLiYwFKOY22QX42JV5+enzsXVgQFGOBnxrwAH8MmrJrBohUeKu
         J7q35vIpJLB542R9NtgChbnIAOs6GGzTK+0GdsLLd7vCJhk24FfI87OUv76nr9+HvelH
         mzmWQcpCn24P3cp3LHXTvTcrcoejB8LRvi/eBREZ0i2x8T8PzCOa/vRuUVhzO/HXsur+
         7hHSC2bz73LzpyD0tGFeUCCOz5aojrfXV0Fs9ESDMsFH1h1cXqYKjBUiPLqJgiddiEjq
         SpOaylK1jKFd6NjFEyHQn1eqKocYZpJkdrdohDEasRt9fKdTbRSrXB80PSPic6pl1Md9
         v2vA==
X-Forwarded-Encrypted: i=1; AKwUvBzJDCHrFjxUiig2bSdv5cyYvrOZd6ESSih0bBMHMbFQByWrQc0gkXErr7NtOe7klQcoS29GYMZKYg==@vger.kernel.org
X-Gm-Message-State: AFuF++kkbAFMavKK8ZhdYTK7k1N4XT2mxmv0mHCUgyHdc9bXsARpBO5s
	JQCCkjo20sFk1bktdkw+nV7MPy2ZLrv3vxgamKjglNJCJEttqvC1eYWEQN5nBwu7Hf+m9PNv5V+
	pVx79TS+fXju5NSk80AJOQ/U9DWtbdSQDBHD7HZSLkA==
X-Gm-Gg: AYBFou0CWP8x2xAW4yxBvJ+OCCLhZ+DTAz6EUXrvNmDLz7dJpWu7+T4Y5jtkc5EJe7e
	SnH1Ik6+hxHjrJvxgB6ZZTVtqAXmSmnLKYl4UGyh4d0lVE8oqcuq+7tICGWc0zstUOJaVUODjdz
	10wI/PJMkD6wzkqAUY6nJR4D3Re5FfxIhjVL5GezLfJ9eN10YBSe9/yoP/Mkx3f03fv98ia+ZG/
	NgSk3gn2/1t/R8odbpCRDP+Mv82dFDq0unvUvqIi7qkQSpkrfsXBtjLMMy7WB52Dz6F4Dy8YLjn
	WkRop8u8orXqKbWcHjCkDB0MAg4G2ZwkJ8yE2iQZ7hjr9kZxzeHYcYHfQRS2XGgFK8NMQxll+c8
	rbEnZnrcaYhBG
X-Received: by 2002:a17:907:7b82:b0:c21:9b4b:2690 with SMTP id
 a640c23a62f3a-c260c9e75e9mr1533229166b.17.1789034004977; Thu, 10 Sep 2026
 02:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
 <20260909-bq257xx-init-v2-2-deb4076b1f02@flipper.net> <aqG3p_GKtncRCRI8@venus>
In-Reply-To: <aqG3p_GKtncRCRI8@venus>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 10 Sep 2026 13:53:08 +0400
X-Gm-Features: AcwNN1W2BrkdebgjQ65zbLYQqJgSpk3t26ruwQKsK8HzTRUFbxoKV_vgeb2TRlU
Message-ID: <CAKTNdwHCN7D=W1o088RnEYQrNRf=RzfZ=qJiUa0Wz1N-kubgPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: supply: core: Allow getting battery info
 before psy is registered
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Wed, Sep 9, 2026 at 11:52=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hello Alexey,
>
> On Wed, Sep 09, 2026 at 07:41:45PM +0400, Alexey Charkov wrote:
> > Some power supplies, such as battery chargers, may need to program the
> > device parameters based on what their connected battery allows. Current
> > API requires registering the power supply to access battery information=
,
> > which is problematic because a registered power supply is immediately
> > available to the rest of the system, but the battery parameters may not
> > be set yet in the charger.
> >
> > Given that the battery info helpers really only need a fwnode and a str=
uct
> > device to hang devres-allocated resourses on, add a pure dev-based get/=
put
> > API alongside the existing psy-based one, which can be used to query th=
e
> > battery information before registering the power supply.
>
> Use the new init callback for that, which got introduced in the v7.3
> cycle:
>
> c1eb5905fdce ("power: supply: Add registration init callback")
>
> See for example fdece8642eca ("power: supply: bq25630: Initialize
> hardware before exposing the power supply") for a driver that was
> converted to this.

Indeed, that should work quite neatly, thank you for pointing it out
(I've missed that addition). I'll then drop patch 2 and rework patches
3 and 4 to use the init callback. I believe they can then form a
separate mini-series only touching the driver but not the core.

Patch 1 still stands on its own, though, as it prevents a
use-after-free during teardown. Would you mind giving that a look?

Thanks a lot,
Alexey
