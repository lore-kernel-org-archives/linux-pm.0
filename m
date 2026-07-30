Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B463403E0
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391073; cv=none; b=gsFhbbnvurBVFkQBxyHnsXwk25PEtLMHVE9j84ci5eCaWEGQqoJBxIpF3Gvo2cpcYt6cvvRDBwg4MVHEyVcaf9sKQZ/SrCAPCof1TNKmS+t6tq2wMy9CQxKu+1Krpp4KaHPp71eQrvsB0d7Rm6fViBnbJXvjkb5mA5E2Y9nzWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391073; c=relaxed/simple;
	bh=elrJJODL1Vl6dYW/ghsCTBe3TiiL2VuRJbi5aBpjw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgIGjygo0cA+7lrsIyDteqvHQ7v/m2OrWIg+oih8WIrIfR6KQRt8YcztD/nGkAO03ZPZ7pfm1pTPyj/Q/4xyedCY/pObI2I4+xL7aIHRZ/Xdddr7ZHanIsT1QxO8ZtqlYhAl475rRRdPxq5p0eYlC4tXW5FF0lV3E3IShOM7YCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=FkwD79h8; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="FkwD79h8"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1196446a34.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785391068; x=1785995868; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G1YBtjGWPIAJs8RYckw93SW7NOctckdT45mokOADGow=;
        b=FkwD79h8TyjKfaenSqW8aOzBZ2cVc2dmk+kp5Iil6++ndY5Ykx5dIzsvE1qZZ3jbVv
         gesBiEl0wfdB9H4F/Z5gCC2ZW9f26/63DPEmSKt6t44LsPUJiDXHeqvYeeBI5zx2xxWt
         hdVxrhKv8ry9XMhKyOgLCc7cYUnGqI9bQu+cvGsTV4g4mbrGUAKk8FQ4Vx8hxilBBDGY
         DMGlr4YR6w8e1T6Ywlw00rK8eNHIhQkkI/Obat9m4vZtF9LtVISqZj7rsdMDslepIozO
         dTKOZFiGe+43piJpyLcakXqEsz8gfUwGmmHOqghzmomMXl7gDeFyIZ4+tHvilOasRLQM
         vQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391068; x=1785995868;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1YBtjGWPIAJs8RYckw93SW7NOctckdT45mokOADGow=;
        b=QfWq/wU8NmXSPoYM1zMCexoolahm9yct+G5urtX0nUhcQVmgq56tStHrUtFBxtJnZp
         R5Cx6TBc+ODfNeUln5slFRTjK524teEVC9MF6o6Ux3cHJUhdjGJMlykZmLXuhIAVo1ft
         a7aik6PjBbcXRFpjXMYsVxveNCrp82pWJoCSyX1Pycf92CBQtNIyllYXMbd/YOedo0eU
         QGqfOiKF2KU+kVmJyi9EBfDl8Umzvd/syXRwvMV/OAii3s1SB/hZgegBGknnKu3kqZqj
         6ldmeyD2Jdsh55tOqgFeftCWV6hxwO9b3LJGzx8TDNfxtzHWj6rzURLs1/15M/BGX0jU
         l04A==
X-Forwarded-Encrypted: i=1; AHgh+RrIzF94nNVZ71czmeXhtN/Ex/nhUq3jDiLq+5V740sWmrjSeVTJ/+vEYn6bh6atnDp7s7X++CE75A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mfaE6sfKuOqU70x0rhmfLThXZ9jw/lwbLwJ09VzeXeWEFAYm
	8+TfLzOnp06iaoUdUTKajuaWq2AHi+Rr04xLzpmnjG+euiWsJd/czlFWSJ9NqB3aQVA4
X-Gm-Gg: AR+sD13TD5Pwj52xMGz+ondIUlqxY5dVe8NDNGYv0lirvoCCU3KxyWsN+xKIrNtDm1I
	Kv7nuHSY+pzibzOeL3Z5BsdyDgbnQuELYG41aCRw9m6Ah+28aftwLcd+cUQKAkXNnLq5hd6oEAo
	9YcJrWWIyJ75Ya/FbjSIK7KzaRlDikaOFISiOmY5siTEEHCcSiB6ysgi8idJC1VG3sLn6zso+JV
	4n0l8e68bLtYbohFdRywFGFJMw1r5PHypD68SdFJ/XjFxoH4ZAL8HsZPYtNJRyPNiCTR/JMDqzo
	HFzuLkZH84guCKFobqhnnLIroJA4nqQOX9jNJPxbYKKGD3gD0nIUqWra0sziK1deSRSlIQK/LKR
	N2DK0ZWL7yRpytfK9W12j76ZCI9/2iLEjyOkOciKDUwWNSuDvvv6FHL91ou0wxWN0vxRWJ9Z08U
	+IIW78zIFQD3V/iRgNCvI9cJuztNtCKYpc+kxIMmfnV6KV+igmOjhkPZ+5c3fd3CGmlhRaZXFQo
	LObB0nIKxdNksZfsrd0+guHuFB2a5BQcP4=
X-Received: by 2002:a05:6830:310b:b0:7e4:163:49cc with SMTP id 46e09a7af769-7f02bed52d5mr669619a34.7.1785391067870;
        Wed, 29 Jul 2026 22:57:47 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d591de0sm3955057a34.1.2026.07.29.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:57:47 -0700 (PDT)
Date: Thu, 30 Jul 2026 00:57:45 -0500
From: David Vernet <void@manifault.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
Message-ID: <amrZ08BnDP4OriHa@maniforge>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wtdukudjwzownic4"
Content-Disposition: inline
In-Reply-To: <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
User-Agent: NeoMutt/20260105


--wtdukudjwzownic4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
MIME-Version: 1.0

On Tue, Jul 28, 2026 at 03:17:50PM +0100, Christian Loehle wrote:
> On 7/28/26 08:31, David Vernet wrote:

[...]

> > Testing methodology
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
> > mode at EPP=3Dbalance_performance, using the Civilization VI graphics
> > benchmark as a single-thread CPU-bound workload with a repeatable
> > built-in benchmark pass.
> >=20
> > Comparisons were run as interleaved A/B tests with 6 iterations per
> > configuration. For each run I collected per-frame frame times and the
> > busy core's frequency, and derived average fps, 1%-low fps and the p99
> > and p999 frame-time percentiles. Deltas were evaluated with Welch's
> > t-test, and I report the p-values alongside the deltas below.
> >=20
> > Results:
> >=20
> > Default settings
> > ----------------
> > The busy core's median frequency sat at 2.43 GHz despite 98%
> > utilization, which is the frequency droop described above.
>=20
> Two things to confirm for my understanding:
> -Median frequency is the 50th percentile when weighing the OPPs by
> residency, right?

Yes, effectively. It's the median of 500 samples of scaling_cur_freq
taken at 50 ms intervals.

> - You're also using busy_pct =3D delta_MPERF * 100 / delta_TSC as
> utilization, right? (Not util_avg or anything like that)

The 98% I mentioned in the cover letter is the render thread's on-CPU
share of wall clock during the benchmark window. The trigger in patch 3
is busy_pct =3D delta_MPERF * 100 / delta_TSC.

> Your observation looks like a firmware or SMU issue.
> Can we confirm the (short) sleeps reset the demand-estimation, i.e.
> by tracing cpu_idle/sched_switch and sample APERF/MPERF alongside it?

Good idea. I ran this experiment and I think you're correct that it's a
firmware or SMU issue. I did three 60s captures of sched_switch +
power:cpu_idle via trace-cmd during the Civ6 graphics benchmark with a
pinned sampler reading APERF/MPERF on all 8 CPUs at 1 ms alongside, and
it showed that frequency drops from 3.5 GHz to a ~2.4 GHz plateau
whenever the render task blocks for more than .2 ms. This drop then
seems to persist for at least 8ms after the task wakes up (sometimes
persisting for several seconds). I also don't think C state matters
here, as this happens even if I restrict cpuidle to POLL and C1 only.

This is the post-wake effective busy clock, controlled for how long the
render task was blocked:

  idle time     pre    0-2ms  2-4ms  4-6ms  6-8ms
  <0.2ms        3.50   3.50   3.50   3.50   3.50
  0.2-0.5ms     3.49   2.43   2.42   2.43   2.43
  2-5ms         2.43   2.43   2.43   2.43   2.42
  >5ms          3.50   2.43   2.43   2.43   2.42

> Also rt-app might be helpful to get a feel of how this behaves (and
> create a similar pathological case like the single-threaded game).

Yeah that's a good idea. I can try that this weekend.

--wtdukudjwzownic4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCamrn2QAKCRBZ5LhpZcTz
ZP+uAP97ci2qOjVPXysUzKo09+70aSVYX0X6eRdsu5udrileWQD+PXhWoCsNsVwj
U8CqTR0e6AOp/ia7yjI9bmWkoRcongo=
=ZVUo
-----END PGP SIGNATURE-----

--wtdukudjwzownic4--
