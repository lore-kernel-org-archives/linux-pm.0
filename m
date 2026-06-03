Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DE4A2E13;
	Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522774; cv=none; b=k7S7RYnU2ym+43Z2jkTUpGq3rNeJf+yJL56l+7hYcGBCqWE1BKtdKtHAh4/mE/5Wn0Uy4IEtPjj4CpMXBtdhxe9ASlSN5uq8KWOMelVhnjnRnugg751IK/MBlVp6gNaTwHKULitM40XX3xeNt7JgsjpEJgWS4nwBw0oBwyRBZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522774; c=relaxed/simple;
	bh=KduvTRIYz7oePCFrF6Vv92JwkD/tLsaaEvebfFAvtbw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCMAvyhUKoQeKdwH2H/uVr5Oi2yG1s7vJg/OIKiIxXQluXDKjdGUEoZRKLRHboAIqcS3aWijAyX0sh6tpm3v2qvsVkS/rXDLDE1LJ/k+AdpNAWm5gyuCCRSqTcoZbEqoEQmaWDEC4i5oYQc0lJqw/at6ZwTjBN6u7OAXXP5Z40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937E1F00899;
	Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 8591E18261A; Wed, 03 Jun 2026 23:39:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, mazziesaccount@gmail.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20260504164017.467679-1-andreas@kemnade.info>
References: <20260504164017.467679-1-andreas@kemnade.info>
Subject: Re: [PATCH] power: supply: bd71828: sysfs for auto input current
 limitation
Message-Id: <178052276953.2678508.11817169873894095771.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 04 May 2026 18:40:17 +0200, Andreas Kemnade wrote:
> Add the possibility to disable the auto adjustment for input current
> limitation via sysfs because it gives strange results under certain
> circumstances e.g. when powering the device with solar panels
> resulting in no input power usage at all.
> 
> 

Applied, thanks!

[1/1] power: supply: bd71828: sysfs for auto input current limitation
      commit: e92786dd86a24bf02ab4503856799192b7f073c7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

