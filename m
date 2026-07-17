Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6B3BBFCB
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280550; cv=none; b=LUcsf/0G6pdnY1v5pt+z/Hjg5etIT0OwngYCpg6+wlPyfIYfRpaLqQlpmLOANxTrtz9yZkMtCqRFpsoTI73D9V1+mSL+2upRM95IWpop3c3qoYixe/tdOky2V2iEvYC/evcI138eNTc9gVYpDNgaSxWVKEyLc8NzVNTTxVKlQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280550; c=relaxed/simple;
	bh=r3R5ScFg7274F+T9HApbZHGIzzPI122Nqg1TsKp8u38=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhAPJ0LPqn9jBQbNDkT5HpTv8W5b7/48ppJqb4LTaSzJN5SUPKs6M/KzQXuCrZTbNnS3hgIrdEwTLkQr3T7ZMseqB9CxAB4TbopjxjheHM0n0aDXWVrgiYWFtcHV1Z/Mycwfk1KNufLsS5b5GH1wPqnLMBF4epx4zyHvdvevB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4mXjR5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4mXjR5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E491F00ADF
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280547;
	bh=r3R5ScFg7274F+T9HApbZHGIzzPI122Nqg1TsKp8u38=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=n4mXjR5bqNKfs1WFV8/ViIClnLKroJMyBUnDrB9UX5/VenX/AKfO07H23c+nHm5jr
	 cG7vEdC0LT/rRMMfxQHZqNZhttSyovcxMg+QtgxmLBCQnqjEoBRta5TRVCR8Jpbk08
	 FODALMeyP7pVbX8f2FoSEiHEM3aiixPnvDYwFZsrtPj1P4mqIgFPJH+jhgJSZyxZTg
	 Cqsg0gmk+24b1XNFTmxL4cVEit+JHT0bpTSA8uxTHv6TeT9IDpcFTQN3JxmBggAGCG
	 JrmatJ3TvLlg1E43Gs4sy1FGn+yO90E9UnT/XnwRLI9KCw7hOwRGumsn1GqvQNR6o0
	 7kfND03Y7uj/w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so5737334e87.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 02:29:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RorgD+ujVJJ50Ms0oSLAnAYBBank/q2+/95nvQrvRxET9sW5dyaVNx3kl4f+x3LtpiSMcpJd0aMTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57uzqeTrDTOl9Lzsja6IXHre4T+OAXGWFNJ1FeAuFAf7LNfUW
	4HzIj3MJJUdSi617GP+Fs6wJQOt/089XGCGqyd/iRt20maq8J6JYBXjAZIL/WISvhQqGSfOYQWP
	ocNn0y8bW8q6MJk9nMFHnCqBgmNZMNN71lJbx2UUEqg==
X-Received: by 2002:a05:6512:6d0:b0:5b0:1359:3dd4 with SMTP id
 2adb3069b0e04-5b28f8471b5mr487315e87.5.1784280546163; Fri, 17 Jul 2026
 02:29:06 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:29:05 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:29:05 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 04:29:05 -0500
X-Gmail-Original-Message-ID: <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
X-Gm-Features: AUfX_mxBaVvltfRRf_wgVMcAU8b0JBxBeSmcms1xoL6Uk1a_ufBMkS2LBRHAuOE
Message-ID: <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable() API
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:20 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> On some boards a power sequencing target has no host-controllable enable
> for its function, for instance when the enable line is not wired up to a
> GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
> one such example: when the M.2 connector does not route the W_DISABLE2#
> signal to a host GPIO, its enable/disable are no-ops and the consumer
> cannot gate the Bluetooth function at all or exclusively.
>
> Add a generic pwrseq_is_controllable() helper. It reports whether the
> target's final unit provides a host-controllable dedicated power actuator.
> The target can implement a new optional is_controllable() callback,
> reporting whether that actuator is effective on this target (for example
> depending on GPIO presence). If the target does not provide the callback,
> it is assumed to be controllable.
>
> Note this only describes the target's own enable actuator. It does not
> imply that a power-off reaches an electrical OFF state, since a target may
> have multiple consumers. It also does not mean that power is uncontrolled
> for the target's dependencies: those may still be gated on their own. And
> it does not restrict consumers from calling pwrseq_power_off() either,
> which remains valid to drop this consumer's vote on the (possibly shared)
> resources and dependencies of the target.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Thanks, this looks good to me now. This series is a bit all over the place,
what is the merge strategy?

Bart
