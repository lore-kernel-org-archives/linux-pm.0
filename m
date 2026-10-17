Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FA426D0C;
	Sat, 17 Oct 2026 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279056; cv=none; b=sQ5Eq04zPmvMkMBPeAO4c6HPxhCN2sq0kYGhN9VauJq+CwGfWWOq0Xzp469JtOXchJ1guyvwWH1cEseJNEY+oF2es1n5lD63bYoG9D5XLnp2bbEdebzv1KPJkgVWf5XW2WVPIiovlMUQV3ulm6deRy0jp4W7LXFO+K3pOzHDoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279056; c=relaxed/simple;
	bh=WThRGlcMA+F9Xcl9pzx+sC+Y9pvKOk+ikVC6/zZ3ZGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bTqRM83EM83HMvLd3LOOO7ssk+HgEJ6TYt32pODmh9AhNrGhs7roTyANYOskse3Yd2M6lVrgcFJOdCiGnLEwLQz4x/83vzxMvkoneoEeFfrvrBwLtG7pmdrPew3v9RPKxI66xgp8U9fNQZzszs6zmCiZyZkR9vn37by2+5hYSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DF31F000C4;
	Sat, 17 Oct 2026 23:17:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DE96018233B; Sun, 18 Oct 2026 01:17:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
References: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: report full batteries
Message-Id: <179227905389.96098.12049189733859490861.b4-ty@b4>
Date: Sun, 18 Oct 2026 01:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 08 Oct 2026 11:14:57 +0200, Bjorn Andersson wrote:
> The SC8280XP battery-status response has no explicit full state. When a
> battery reaches its full capacity on external power, neither the charging
> nor discharging bit is set. The driver consequently reports "Not
> charging", which can make userspace show the system as battery powered.
> 
> Use the response's power-online bit and the reported capacity to identify
> a battery that is full while externally powered. Preserve "Not charging"
> for a battery whose charging is inhibited below its full capacity.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: report full batteries
      commit: 6c8098e04ee4d233399e40e7311715844910f8f8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

