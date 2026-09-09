Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA63E410C
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986987; cv=none; b=WetCSbDPDWIP+Sns0I5as4e35DP24V7NeRubjuQtLG6avmXk72nezDzz+zpm3r9d5XHqTvf6khGFCF/L8EEwDYeBQ3OZ7fFw2sBtc+aMmmqFb1PvpcZUuSRekRvg2XGv+4WxzQ92pc6h5CJqjeqjnZEuX5dJMs7whM6FCwN3qlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986987; c=relaxed/simple;
	bh=cGardJIS+1IsLMrmU0rJR+9cpyjnWiDO/eEfPgrk6dY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r94zN8yVHkeC8iBpIEMHy/EWuKtpUNq3kgcLlk/90zbLKEMe90Mqj8l+5nZt8PPhN4ILYEpGGv22vyT+NpgBxjv4g+6JSh2tP7K0KBaoPKqUwAV8oolAqgH7IuieY4agKX1F0YUkDvmB+azgmeBwVtT4BDByOQp7swMGnWwa7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3341F0089B;
	Wed,  9 Sep 2026 20:49:33 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0842D18337D; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-pm@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
In-Reply-To: <20260905101849.42830-1-kmehltretter@gmail.com>
References: <20260905101849.42830-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] power: supply: mp2629: Use the full
 batt_impedance_compensation name in the ABI document
Message-Id: <178898697202.883277.8707302698183273713.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 05 Sep 2026 12:18:49 +0200, Karl Mehltretter wrote:
> drivers/power/supply/mp2629_charger.c creates the attribute with
> DEVICE_ATTR_RW(batt_impedance_compensation). The ABI file documents it
> under the truncated name batt_impedance_compen, which does not exist in
> sysfs.
> 
> Use the full name.
> 
> [...]

Applied, thanks!

[1/1] power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
      commit: 3da2ab1e3b8b1544b1a57612bfc1343f396e83e9

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

