Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697882;
	b=FR2fq0yeLO86afNUbVHXYHHRldPjCmKtHtGJjvqpQmsFvRIKCoP1YkB1XoY8Q6leku6w
	 4gI+c49wQmWwrHnJaxH+VTKDImPl9DMBFdMb9MjDGwtklV33ti2X+NTfdDgTaP8xyOhuE
	 PaQyufONNwD376RiuAdfcUDOqF1+eGyzO3ReIyvdpudWwb4FmOB/9gZXwAdiajG4hzU3u
	 sV6cbtcRKnF0dyKTINXCU19S7eZBKdfyeBzzg6+O76S89R7uZiGcbpl+4zFM+5Za9Q5Ek
	 kl7KxB3ZG3cer1ooiuc77CkLOS/jUWLWZACF/yxKFiruDbHQxjgLqey3IBMKkMoIzgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zogW4wCFsq5UWNkLI/4xoNlFpn4BOZwJaLkB2jw5PQQ=;
	b=3zdmUs3ftOh8wlz4/I1/s6Q5Ry7+2bzS+IdmwaJCrCtyCZyVXTtVdcoqpqUoUXerklNT
	 pcUvC2A1fS4HYWKWS+ZCCrpDiHRgc2+BYHbgfk0sLnqk8hiwPeVv56Hzx0eDtOWmAUxdT
	 mDFpH8QU6KPly8Assc70PxjE15PflxXViLsGYYRdZA51QqDS5MBK+ztYaK4JugqyRc4Az
	 k1bQZvzmDppuXw9NmX8e9c7aNN1wziYxAIHt7lTt0GlK/mNmsUjQX/wfY8MUN04mSeqLM
	 KrJitxDgihnD1c6C/WytEojXw8XY6II2T5fkxy/KKj0zksyefQxV8gtMRMKOwH1A1Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e9xyUUnQ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B36606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B36606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e9xyUUnQ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so58565405e9.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795697880; x=1796302680; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zogW4wCFsq5UWNkLI/4xoNlFpn4BOZwJaLkB2jw5PQQ=;
        b=e9xyUUnQXLcue24+72FobV8GYWKabzhBiz71TukEHdYQv1T0RhmDA1CfIryDJ1d3fG
         GbtzMmkp6JDrp36KJfbEV3jyGRf6R3XInIzqnssudJ9QhU7la5DJm3rz9ku14qfBRypH
         2cy043HNo57KS352sTroyOTyK2LHkGHZoZkw2T2VoK7BXGSCTdWpUeVxmgAuai6ZVJso
         CNo6XG154vRExH5NKyfo46LV1KSyYBuPaPlUPID7Am/ixPJMR8ut9m76VQVuBA4z0aca
         8bq2cBTl4rI1HG1CYL9XtqcAWteQ1f+fbCp+faWLoDuR/d6K59MkV8woRkWNTnKrsMd/
         UPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697880; x=1796302680;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zogW4wCFsq5UWNkLI/4xoNlFpn4BOZwJaLkB2jw5PQQ=;
        b=e37p8DhAo+64YmBHOAeFuZwZ9YGEVe7P5eLjtzfYi2eRcWDRH2Yz9GQ8kqPsCC2kQ2
         2LLoCvV9pkzPrO4tlPMq+1dIBUqlZMEtLxjq7O+XIxBQ3WG9YwiJ0AVxnZQHrho2wN39
         X37LXwkmb0gzA0FhUVmsTyhjE7/8aS+tmNxXnPdKB6WFu/ck7yx3WnqfNdF2nREontfo
         Of591+fpLM2RExdIO08dFqRFdpNp3s8pWB1HinPTzftGGm1bn4GVO6PbP/O8QlCgDB/D
         pPrcyzBcw3ZiOPwXpB0IA2xpBkg26ZFKSCqfxzZLaYXmJgdLV4vTqtTw52cld2UCT3Jy
         itng==
X-Forwarded-Encrypted: i=1; AL+hErF9+cQoWwP4l7aUnmAMCawuiA7FiDKL2vj1W8nticcTGr91gtDR5AXOsi88wJ8crNalZ675go4U3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+n50VLGxy8YS2RX41KnU7szyUBq+jc6BDWEKA4JzYU5I9Ej45O
	jbz+60D7ej9m6nQcX5jL9Zo9kkRLlXzG0Pnpm9gTTD1eiuD0SzJbZE0+u4QuOZsvSEw=
X-Gm-Gg: AZFdTZeMkvvYV+eSqJnprBj02llDzd23wuayzy7RubRyCleFPR0IPAnhbZT0IveR+dF
	8C7K7TnKDZxJ2DJpwwW+T+u3rpMX0ICOQfy9zMYwD4J/+tFcl8M8oo7BvbzCHbiOAR23UvXNSco
	AALCxd95rJXL+cN/RNNLTnLBM3RQ9c9gO/XckXfATv/utt9OyUOwvkjz/xvGlqWvq18C2coquFJ
	jZBjtObB7ANV9gM9MUuX6HuxadtcnhbTY4E+WkU7Qleu9VuAUHvtUpluMTBJBltM3xoPXfua2wU
	bIDcg4t0+Tv5GEIzneFywweY0760kbId3cVh5+MweDeh8J5dgwfU15UxlqX05Xwa7TZowOF95gd
	/SjMq5uU47EnGwqhiiPRiFV9sDdqf/c3WSgKmOFndTxOTnEpgQBQa2N0+BlOn9hFJkK5hdl0xwF
	EIwYRikxrYFC6n076WU0H1GPG8g6eAviSYeKBWB0hSb/obQaXNO2hM/4vP5sVPV+qkN4dhxuru/
	0mJjr/ox/HnlLJL23BbRIM8kpB2gzr0f4FGs6vPyK9ObrO4+ZQ6syogn/4jtuz8UWn3czUHZBEf
	uu8cYaP8383Io4fCRD6d7EB+R6UeU9uX8g==
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4bb8881b511mr431408155e9.18.1795697880151;
        Thu, 26 Nov 2026 04:58:00 -0800 (PST)
Received: from [10.1.1.59] ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm541261675e9.1.2026.11.26.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:57:59 -0800 (PST)
Message-ID: <c3273007fcdc6e6e832ce3e24e6ff7052d46c14d.camel@linaro.org>
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Christian Loehle <christian.loehle@arm.com>, tudor.ambarus@linaro.org, 
	bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org, 
	lukasz.luba@arm.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Date: Thu, 26 Nov 2026 12:58:16 +0000
In-Reply-To: <20261125173959.2198116-1-christian.loehle@arm.com>
References: <20261125173959.2198116-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9+build1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christian,

On Wed, 2026-11-25 at 17:39 +0000, Christian Loehle wrote:
> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clock=
s
> independently of its interrupt mask. Setting it to 0 C limits all three
> clusters to about 200 MHz while cpufreq reports the requested frequencies=
.
> This was found through trial and error while tracking EAS regressions.
>=20
> Program slot 7 from the lowest active hot trip so hardware throttling can
> precede the critical trip's system shutdown. Cache the low/high window an=
d
> update the hot limit from set_trip_temp(), because the thermal core skips
> set_trips() when that window is unchanged.
>=20
> Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver=
 GS101")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> Since v2:
> - Use hot instead of critical s.t. it precedes shutdown. (Tudor)
> Since v1:
> - Rebase onto linux-next, including Daniel=E2=80=99s queued ACPM TMU fixe=
s.
> - Cache only low/high and look up the lowest active critical trip when pr=
ogramming. (Tudor)
> - Retain the requested window even if programming fails, matching the the=
rmal core.
> - Handle critical-trip deactivation and zones without an active critical =
trip.
>=20
>=20
> =C2=A0drivers/thermal/samsung/acpm-tmu.c | 76 +++++++++++++++++++++++++++=
---
> =C2=A01 file changed, 70 insertions(+), 6 deletions(-)

Thanks for this patch. I was indeed wondering what was going on... Boot
time on Oriole is back to normal in my debug kernel; just to add some
numbers:
=E2=80=A2 reaching multi-user.target drops from 99=E2=80=93111 s down to 20=
=E2=80=9328 s (saving
  71=E2=80=9390 s)
=E2=80=A2 adbd readiness drops from 120=E2=80=93132 s down to 21=E2=80=9329=
 s (saving 92=E2=80=93109 s).
=E2=80=A2 cold copy_modules rsync throughput jumps from 4.37 MB/s (1,727 fi=
les)
  to 30.71 MB/s (1,713 files)
=E2=80=A2 CPU die temperatures at boot end also reflect unthrottled executi=
on
  (46=E2=80=9348 =C2=B0C unpatched vs 49=E2=80=9358 =C2=B0C patched).

Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
