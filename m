Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751712;
	b=PFCPaflhPtGE8RQL9b+LW3GSFo7U0GAxhmWJo+Pe2tlqU/IRBvt55iq/f17veoGg+qRK
	 Q6AftnMNpUwH5Qt2F6U2zV73yde0ZT04r9fZicJdbIsy7j2/6UiGJSjnYPAAAyTS7/YyT
	 PYE4N1ZbL5RCubungw2puniGeq9LNjVnliVKkVVQ2ij+HrQa22XZM2x5LnmrVw5g9xNZM
	 D7dBVH+IT4owmKHzYe7xnYfu64mmkCGb2anXMfSjYjzZQ/bRkdTrUacJeb+50Wic0fKjl
	 V9FTxUZ3mGQrJtT84jAqg3cP7u+YVo/UHTiQFauiWw2Xa5a50i/fNrriJnNsu1SJGNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zheX+XNXZRQsqnxaQohoj/DUJpNDERXKGAb12Po/cyU=;
	b=PjN1RNbdPcBn3H1qriSB1LCf3WNBdRLBI8cA7BYKi4fryXnGtpdds4a23NaZ3eHFLFcW
	 ziYPCEGCz2Th2jiHlJE1O5Aly1AyucucYCHTOhLvOk+BPk2Mfy6aArHYfIZrQ4Bu3gwyj
	 he66OH20b21JkN+DeCvK9nB2sBSCrYCXJ+j3GtE48SNwM5mZ8IC5o+QfgEnopTjElhk70
	 wVo79grmQNar0aY4dfYiqQq3Hz1mS6VfZlqTxhHWgpUOmUtKYO3Ko3U3xUicmtPJE1Oye
	 tOMtvgopPN/3lT153ebV06fv/wTcrAlhAe2IkjTMsm7M3XuNWdA3oYYP8iVq1fNsL9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jbPi0Iw1;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78B606A338
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF78B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jbPi0Iw1
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1da913so538599f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792751709; x=1793356509; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zheX+XNXZRQsqnxaQohoj/DUJpNDERXKGAb12Po/cyU=;
        b=jbPi0Iw1aJHhHQpSTnENb6ntTeL9VEqxE8JllgVE/SMQ4nuhMEkh4zx+11VIoWuI52
         3BTFTNVDysE3hsDjdcIrC2ce8jd/csL8SC+1aeLIcZ4+eSLFIFvrX+y5gPvk7HMT/0WE
         PotStsJWLKnX+8JwsooEHCrpzu7Bh8L3dLMVoaomEU8ipIABlUPyrfGIiCyitROzINV6
         tr/iMvmyjZLrdv3eXDH+ialHhWtIkgGin+FPLUt+s1udrl42teOU7mHymHjLD+ZvNvUK
         3f71xIKR6b70XQGlVcDFXYqOWG6/XUWAC1yzb7s1B6MsYziJ36L/8EZMWbiWtQ6sFS37
         MXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792751709; x=1793356509;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zheX+XNXZRQsqnxaQohoj/DUJpNDERXKGAb12Po/cyU=;
        b=sMkYV/y+FP7nVNrkGT80SZ2uWug4mMfJtU2DiN6M8ADpuCK30DAufU2gHy1ZdPSA5o
         8LSpqDrgBl0FVvxdvMR2XoBiJAPatgZV0QbDaqd2xlb8RQ/764QMjOZU0RIYSTZ4blp2
         2aaNA1pj258kwXW9IZfVun0tWLz42xn1OD/iXEyL1KUz4aM6g8vkgghQBFrzSbzlYmQ9
         uDWzLrqWcwZe2SS5/9ick9O9Vq3yGn3SYIKCWny14SsP02OYc+GeF1SyFwrNETrUv+fa
         bD/cNFO75iyaIwfRWlLiVGRf4XjB2ZyzvZuVEO6vcDWmqDq4y6/vUT6IBLwQsYs4noIv
         rJjw==
X-Forwarded-Encrypted: i=1; AKwUvBx3sPnA3EJZuf5uzSkYH7JgeqYRENp7r//pHw0AZ01YPddup33wTXolCXULdIKj6l5rdsuoYLErGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLHlYVkCFBLveiliYLuM/Pg3/qwLhdk3NpBrutGr+QIS58ggmZ8
	n8RwB7nzeR+9z6WxUzkKpwO/4m83ctQ4A04kiInsWjsP/SPk0uSb1oeuWIArq8pSMbA=
X-Gm-Gg: AYBFou2Jz3M3AJVV4lJdNW6Hb4Ah2RNwQrcA5xm6lItsaeEtWyCbUvWj5Cb/dIbf4R0
	3Y1494X0bBfgfMdI7QfD8kDk4fhwIfEPm1rg5ZbHB2NinqH6gnGDS9/BGf/t52+t0acmJm9ddJA
	+uRt3S7zkjUMC+fCkClSYE0+ybb96/jaWd4pG0Cql6QUDv63cNjDWXctDVDhWLBh7TYdnbYLWri
	OeRWYc1k+jHbPu/CwISeslBani/JMXu6xv3eyMwIFkNEuF+rHnxz6JHSuNglsuh8wBSaC33JbGP
	S0OiK9Oa1w3MCSpi4vw6nd3L1MOpZb7XQNfc0sBeNbA565msuyRBoEo1mGAiL7o3wF2+2W7foy0
	Jo2T/cEDkJhgb3gIhtVrRsYnFmySt2qzsG5SqLd76gKtPLouU5QEPGI97kJccvKf46wJzh8MqLN
	Ymob8R7WB2BjHbhgWdLwqIcZFpEBZwGG9Tpd7DHFs1wZK+KBuv85pE0oxm1zK/94X1bZE8Xxteb
	4icRbTxyaoEAxopE39tv8I5Cib9nBleuXDbyXHfFNkoopY0Mh9sDCcQFpwM6AXCX/Acv+VYuzk=
X-Received: by 2002:a05:6000:4713:b0:488:8566:9986 with SMTP id ffacd0b85a97d-48e2d0ff5ddmr10532774f8f.2.1792751709131;
        Fri, 23 Oct 2026 03:35:09 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edef81sm4665234f8f.5.2026.10.23.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:35:08 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 00/16] Centralize the ownership of power rail votes
 for Qualcomm clocks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:35:03 +0200
Message-Id: <179275170360.4070168.15401690927522463377.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ib/lADe6pfUlXtQQRTg/Q6ldBcUGQ6EizR7YFWwG8S0=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFm3LaKslnNIt9+eW5eVWGnBkLVM2WF645Ynpy6/Ti37q
 Cmld9qwo5SFQYyLQVZMkaWGu1r8naTWl1nTdW7DzGFlAhnCwMUpABM5ysPw3yPFaaeKL2ODTfM7
 2y2CDQfkp32sXXf4y0xfpxPLPxg2qjIyfO2Yq5Icx6SspT1v0g6hZtY2f8FY5fvTF0oU3Nu7dct
 CNgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> On Qualcomm SoCs, both the PLLs and other types of clocks alike require
> specific voltage rail levels to operate in-spec, but through the
> separation and decentralization of clock and voltage votes, these
> requirements are often not met and are never explicitly stated.
> This results in clocks being undervolted, or at the very least a state
> we're unable to reason about.
> 
> The devices consuming these clocks very rarely have their own
> requirements in that regard. (1)
> 
> This series moves the frequency-power_domain-perf_state mappings inside
> the clock drivers, ensuring a single, trusted source of truth is
> established and that the silicon is no longer driven at out-of-spec
> conditions.
> 
> To illustrate the nuances involved, here's a couple examples of hidden
> dependencies, as found on SM8650:
> * video_cc_mvs0_clk requires LOW_SVS to run at 900 MHz, but the
>   PLL it sources the signal from requires SVS (higher corner) to
>   produce that frequency. Similarly, to produce 1140 MHz, the clock
>   requires SVS, but the PLL then requires SVS_L1.
>   Analogous story for mvs1_clk.
> * gpu_cc_gmu_clk requires MX to be at SVS to output 625 MHz, the PLL
>   requires SVS_L1 to produce that frequency.
> * A number of camera clocks follow the same pattern.
> * Additionally, some clocks like cam_cc_cci_{0,1,2}_clk require
>   MMCX to run at LOW_SVS, but the PLL has the additional requirement
>   of keeping MXC (a wholly different rail) at SVS_L1.
> 
> There's a broad agreement that a consumer should only have to care
> about the clock it consumes, and that configuring its parents is the
> responsibility of the CCF. Requiring the consumers to care about the
> above cases (as is the expectation today) is a clear violation of
> that contract.

This is a fairly bold statement. Yes, the CCF's task is to make it as
easy as possible for a consumer to enable, disable and set the rate of
a clock, and I agree a consumer should not have to know what the
parents of its clock need.

That does not make the framework responsible for it. Taken that far,
the CCF would become a de facto platform coordinator, which it is not
meant to be. The clock driver knows what its clocks need; the framework
should give it the hooks to act at the right time, and stop there.

When coordination is needed across devices, there are dedicated
frameworks for it, like OPP and genpd.

-- 
Jerome

