Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEB5221EB
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066913; cv=none; b=PTYV2odUn7d8q2/8zCW9sIAZ2fQSuTN0DixScXcMnN+nm0sxZtsIEW9vV8Aljg2POOZ0Z0JwJ74vcw2hCC+TneywFyQi9fRS8IK0rNmqm88ZzZ7KJfEtSPQfBKF61D4XMwPYwy1vSAMfQRpS6rhcUHZ7zOakk/TfwJQkh1GISJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066913; c=relaxed/simple;
	bh=DIk4K8t7n3jCRIWpgVm8y0dvfQS2Okp1cwxCtR87N54=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmIiU3kKqMVG/QJFLJv63CLy1E9/ijXLFIOxq2K2X13pcUDsqa4QQcJNIsIkddR3ugTv0TaF/MSXL2mtBdBmOeP+s4EOSW3PddZ0LOwhrp4AjDBsiWg5aldh7rXmVp+U4cdJ/O4Z1pwFxjWx965IE8jH0w7EXZ6HttWm0z9pEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVn5aAZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVn5aAZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3EB1F0089F
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066912;
	bh=xaYOqqiuhximCWN+b4H09mGRUg+IK9L18ExvostpRS4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=fVn5aAZZJCT3yR6xYahdUbVzmxMbAQdqRF2CMcExgm6rVKB+H7yXIPjG2GKPeLqXs
	 M/cwWz8YjSPnynZhFipcDUX0uK2b6ZCXihI91UqTBP1VANWg2bvizCXkBRnx93w7y6
	 i06nxasx+d+NDqoV6ZO0Z4Vvs35us2X0xmx3JkOpNi+bLE+nzor+qRqiUtmrT0LdSd
	 PtNr/RN/PdowGGGdu3wSEVEVhEIr8v4KIjhPqPTJxvPMXt7g/5hML4IbuFRa2QAEGg
	 zFCvmga2D6sZpq3oZNTgyOoHrvegV4otvxGKec8DMDuaJZMRQjuJyBFl/5HAYXRPeE
	 BuC7A0eG6lgPQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e21a5408so29124321fa.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 01:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwHbPUh1x5pSqvLJZxjo/TGnKwT7hWvpErMRZKsuROGI1+dPMP8sssMcRfvCouyQzJ+9E79Xqu1+w==@vger.kernel.org
X-Gm-Message-State: AFuF++kQhqZiFC+RhlIL9ytsRW5EwX+YQ9mE/YcQ7oAkYJWhmIXhbouP
	nQssDk5b5uBkMJyp3kAK67b1cWWDw40pnUkqlqifnTPDBKlYzHSLGx1TAyup1FBYDWJi/dlWtRP
	zohnxrg90/jEtZJP6A48U3sMNNgfOVP/J1aavH5gUYA==
X-Received: by 2002:a2e:be2b:0:b0:3a1:9562:732 with SMTP id
 38308e7fff4ca-3a5fbe36d93mr30039041fa.1.1790066910689; Tue, 22 Sep 2026
 01:48:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 01:48:28 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 01:48:28 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260922020623.398913-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922020623.398913-1-shengchao.guo@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 01:48:28 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfMNwJq_8NTLMx8dKEFysoc=MCQSoB9-L+KVbpDRnvmMw@mail.gmail.com>
X-Gm-Features: AcwNN1UiGOaChY5GhBxT4uEewsZGB0XkC6bYDHLVJJ0u79sSo-qQkOABnAsjEk8
Message-ID: <CAMRc=MfMNwJq_8NTLMx8dKEFysoc=MCQSoB9-L+KVbpDRnvmMw@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: Skip get_bw on QoS programming providers
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sep 2026 04:06:23 +0200, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> Programming the static QoS configuration in qcom_icc_rpmh_probe()
> touches NoC registers directly, and nothing in that path clocks or
> powers the NoC first.  It has been working only because the
> interconnect core used to vote every node to INT_MAX while adding it,
> and that vote stays in hardware until sync_state.
>
> Reading the boot-time AMC votes back from RPMh removed that implicit
> guarantee: a NoC whose BCMs come out of the bootloader unvoted is now
> left unclocked, and the first QoS register access aborts.  On Qualcomm
> Nord SoC, the MMSS NoC dies while programming qnm_camnoc_hf, taking the
> board down before rootfs:
>
>   Internal error: synchronous external abort: 0000000096001610
>     regmap_mmio_read32le+0xc/0xa4
>     regmap_update_bits_base+0x64/0x98
>     qcom_icc_rpmh_probe+0x44c/0x540
>
> Only install the get_bw() callback for providers that do not program
> QoS, i.e. those without a regmap config.  Providers that do program
> QoS keep the previous INT_MAX initial votes, so their register
> accesses stay safe, and the rest keep the benefit of honouring the
> boot-time votes.
>
> Reported-by: Bartosz Golaszewski <brgl@kernel.org>
> Fixes: 11a44c6087c6 ("interconnect: qcom: implement get_bw with rpmh_read")
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
