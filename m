Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDA4195C8;
	Tue,  6 Oct 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293577; cv=none; b=fPUt7T/EwGEV5YFAIxqtE+dgbS4laA9dt/3ltTvhKSS6/9z63TSsWR/L0+rzkwdqRE2uPrFmIIheS9n9sKGc3U0Ox33O31vn5y/KEnhwuKNFSEte0hFVssIGtLUPeejKOZfqnRTof5VKV1jYYCrtzzGn1W7k5Gco6M/XtEh+OwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293577; c=relaxed/simple;
	bh=rDBfT6pAvhNxalF+kSQQ02i8OGbRSXeGMZh1ZRM8VEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b1MeNVf6+hMwrqt5DjJwRB6C/mFcLvl72mDkdHWx2JM17flxWaHb6OLsz3M3/mMUPAxVgjHnlBBAipT96xxwHCTx4ORN9jPxic+1mUODAp8tSioen4g/m7VmQa50XLPVqtpfaK0Vl0KejpCkWO1BoJXwAbow/Zw56XYjgWWLLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8BaYucA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8BaYucA"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7520F1F000FF;
	Tue,  6 Oct 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791293575;
	bh=6CZikXboQ4pJcmLiTLM5ulPxyvEM102hfSjAIL4v6vU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=h8BaYucACLeuFvkOnlGfyIh75DNQcKCrpxM0dABHEBNL9cA2ScG1G5IdfMJNBjaKt
	 77fZ2SVWNl0zPmlQtmDq+w02mOnT149nxE/OWIFUmB1KiTDESmuC1MhjY1dFUhlFZd
	 Mc23Akff+DL8RyVJPKKQTNwQFN2s6PrOzQ8A+vQ8RPu37LHJGOgjJbJcH//glHuBC8
	 sLD6LpxWGDllIHhb2XUoQtQP/fQbpvRfPuKRFyeaEpLKe+qvtxfMGV0vYfAPfS2QBj
	 Lkkc+WJlBfxS0v2CjTu9a8Jxb1wjR6b0JKNFKyG1VTcQXBS5z+xvwktxaR4wIfLXlD
	 vrxSf+DLZs1Vw==
From: Kevin Hilman <khilman@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Daniel Lezcano
 <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Maulik Shah
 <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] pmdomain: Support system-suspend-only domain idle
 states
In-Reply-To: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 06:32:55 -0700
Message-ID: <7h7bjv0xa0.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maulik Shah <maulik.shah@oss.qualcomm.com> writes:

[...]

> All domain idle states described in devicetree are currently considered
> during the regular idle path. This limits which states can be described in
> devicetree. Due to hardware constraints, some domain idle states are only
> applicable to system-wide suspend, including suspend-to-idle (s2idle).
>
> To allow these states to be described in DT and used only during system
> suspend, this series adds a boolean system-state property to domain idle
> state bindings and a corresponding system_state boolean in genpd. The
> genpd governors skip these states during normal operation. The system
> suspend selection path remains unchanged, allowing these states during
> suspend while retaining the existing wakeup latency checks for s2idle.
>
> This series applies to cluster idle states with the "domain-idle-state"
> compatible string managed by genpd and its governors, but can be extended
> to CPU idle states with the "arm,idle-state" compatible string if the same
> restriction is needed for CPUidle states too.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thank you for submitting this.  I have been considering how to add
exactly this feature, so I add an enthusaistic +1 to the need for
this feature.

On TI SoCs where we use s2idle, we have similar reasons to have
domain-idle-states that should only be available during system-wide
suspend-to-idle.

The current hack to supporting this is to just use absurdly high
residency numbers for these system states such that the runtime CPUidle
never picks the states.  But this is a hack, and is not describing the
hardware, so I would much rather see a way to describe this in DT.

Thanks,

Kevin
