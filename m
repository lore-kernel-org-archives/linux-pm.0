Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042591;
	b=Rzn9l+Kw9/QgboG2mrYuzRUC1RQgmOVbfTDK847VnLmBBRUzOonKbVIZIY0leqa/SAij
	 spyHrWnXcNkOq4nFzwWPQpc0MmTQZnhtqsW1BgJZXvq3ceWE2MWBJUK3Q2s4JWBuknwz3
	 LBl1QaxtmOqCNSSM5Sm/vxSOil3Lh25S/RIr1K690V5TB2B3hp2hppMhqkbvOI1KsfqeV
	 7KJssx/0BuZ/oxWGDLC1WvBtmWADPWdZhSBbQ2YXcUFVKHaC++HLLrK1WKksUcLg9HD5s
	 lfq6OuLAxfJJSeHsLiXahoxRnjf1KCAAXKx6AyW9eHDSclTnycEmsL3X/MCXBqG0BEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042591;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Tew2TYa3rQpGioNbT7CfeQl6rPBdaZqOIbvVXQwLbzw=;
	b=EcDnvyIlKWQsp1fN2XnnMiG8c3isVH/iJSYf9QxQNNAGAs2QD9Y/QNXWY7L1y5nha0kU
	 fDlXR4jRigZf9wHzknKt6K+4xXCw+PqkmwrruzdEhw9Vyi0yHmV1d6vUuLD+umEDZJo1Q
	 +eVt1VIOMmXUCwavXXroF5cB/9uSixLpWeI03BFy/SBRAcpc1uYHDegZBC54lrWOMno8W
	 gjJ//JoZ7shVd2EcVc2DSQZHoex2qM629SY1h4zmS6b6W4oQPOL+ZVJTtrIIl/IiIqdUE
	 3wjaJuyXgkgg4ypMCOM295fynGIf8mcvTBOV+JlyU6hAgePu3PD4josuCQuOG+W721w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYzDcHUt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C55606A320
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYzDcHUt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851361F031E2
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793042590;
	bh=Tew2TYa3rQpGioNbT7CfeQl6rPBdaZqOIbvVXQwLbzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UYzDcHUt/ARtoNJ+R2uEp4WcK0SQCX+8u+sThgPL2VyokZiREUA4rK0WAInA+VLaw
	 AShXMd8RMc8SU9pSngrWgZ2yCYYKHBgfxH9K/D3E4B5DrqmQxK9PhyL8dmBH8nkB9q
	 SgIu1V/dWiz91j1W58hzhHqWAoIj5v5aQsTA+odXY7toqla+fILJrVQr2sLIL8Jk8T
	 JGiK9qYizMGMJxiEKBoxupK27/AD9tgjJI9Um08SajGb1VUje5YteOjWRNSG3DVD0O
	 JfedSKJ1mRQCSoS2jCENTSL5RioVsL8ZESmajIIk2pPm0gBRejzJoUPwNLnORCRtIZ
	 xQVQxtMts3xLQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be4d648aacso3184962e87.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 12:23:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx8AQedtLwNs8XlXSvtsH7DuyOoGSPydUAHUSDiNxpnySf7fqh4P5FyhL02yKcM5eiyxvjJGGAzHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIG7LPLv9859a0g/5ZzPzZ7tqQJlvPdCW12k24OrFsQWzkNYsbb
	Y4yexpsPddKS5qZs1p/mubPnPcPgk3iuLowE6MGAGZsU5wqeG9W88je4NcNz3BJ2/NGE7zkCWwk
	dwfT0cKZR50ybZKnOLvKnUrnaJIKelsY=
X-Received: by 2002:a05:6512:10ca:b0:5bf:c27b:8e52 with SMTP id
 2adb3069b0e04-5bfc27b8f26mr873358e87.65.1793042588947; Mon, 26 Oct 2026
 12:23:08 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023060724.5691-1-dennylin0707@gmail.com>
In-Reply-To: <20261023060724.5691-1-dennylin0707@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 26 Oct 2026 20:22:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gKSuXT4zqO-OTs+M6ZfEFUsbV42sXOCK-pF0J0_Cd4aA@mail.gmail.com>
X-Gm-Features: AclHuK_igWyg2GTO7npcsDspF3bYbPoGIPZH3mSJygFCjzO8ygz-1d4lyorB0RE
Message-ID: <CAJZ5v0gKSuXT4zqO-OTs+M6ZfEFUsbV42sXOCK-pF0J0_Cd4aA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Fix CPU mask truncation in power limit trace event
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, javi.merino@kernel.org, rostedt@goodmis.org, 
	edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:08=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> num_possible_cpus() counts CPUs, but CPU IDs need not be contiguous.
> Using it to size the thermal_power_cpu_limit bitmap can omit CPUs with
> higher IDs. For example, possible CPUs 0 and 64 produce an eight-byte
> bitmap on a 64-bit system, dropping CPU 64.
>
> Use nr_cpumask_bits for both sizing and copying the bitmap.
>
> Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator go=
vernor")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/thermal/thermal_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_tr=
ace.h
> index df8f4edd6068..2f953fd8289d 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -119,7 +119,7 @@ TRACE_EVENT(thermal_power_cpu_limit,
>         TP_ARGS(cpus, freq, cdev_state, power),
>
>         TP_STRUCT__entry(
> -               __bitmask(cpumask, num_possible_cpus())
> +               __bitmask(cpumask, nr_cpumask_bits)
>                 __field(unsigned int,  freq      )
>                 __field(unsigned long, cdev_state)
>                 __field(u32,           power     )
> @@ -127,7 +127,7 @@ TRACE_EVENT(thermal_power_cpu_limit,
>
>         TP_fast_assign(
>                 __assign_bitmask(cpumask, cpumask_bits(cpus),
> -                               num_possible_cpus());
> +                               nr_cpumask_bits);
>                 __entry->freq =3D freq;
>                 __entry->cdev_state =3D cdev_state;
>                 __entry->power =3D power;
>
> base-commit: 503bb6e70bbf6304b8113373d09dfffcc4aa9183
> --

Applied as 7.4-rc material, thanks!
