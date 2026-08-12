Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B0470433;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573434; cv=none; b=FESAFoF0+n9e+TUuR0dapXO0AM+2EgIoCOUFd5Dd/P8rV7KP3jZF1+AaYOtcCxq4dPd8HyLGUYI8ZHp8TbpAIiMdrPZTxlU6gs92lpV9/gH61l1Y6VEJiWeB7Lv8zBgJZ+X3FkePppecU2pHoIEmP0suLTlhvKIsC7OjJNAkSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573434; c=relaxed/simple;
	bh=I4N3GkfnWBrdnGVWcJ4/0T0GQBm6TU+YSXmN3mJ96Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CD6fHLZ7LtsILKHYyWaukAPZ0ZZU1dAy6MogCwf/v+62BqgHuY6F2uQQYAZ52uLwcoyoa5W5Enu1lxLbYdz0VThL3OoUMk2L/r+RncJVeqLqFJcUzvbM8cFFYj5Y/bwcJCye8V//FYhRSRV2WQO/vR4hnqc4zTdqW7w4n0zRyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A223D1F00A3F;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7FB681830B2; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Cc: Rakesh Kota <rakesh.kota@oss.qualcomm.com>, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tingguo Cheng <tingguoc@qti.qualcomm.com>
In-Reply-To: <20260812-fix-qcom-batt-chemistry-strn-v1-1-458545e02641@oss.qualcomm.com>
References: <20260812-fix-qcom-batt-chemistry-strn-v1-1-458545e02641@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix battery chemistry
 strncmp length
Message-Id: <178657343050.347615.7967420952689531445.b4-ty@b4>
Date: Thu, 13 Aug 2026 00:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 12 Aug 2026 00:44:47 -0700, Tingguo Cheng wrote:
> The battery_chemistry field is a 4-byte array without guaranteed null
> termination. Using BATTMGR_CHEMISTRY_LEN (4) as the strncmp length for
> 3-character string literals implicitly requires chemistry[3] == '\0',
> which may not hold. Use 3 instead to match only the significant bytes.

Applied, thanks!

[1/1] power: supply: qcom_battmgr: fix battery chemistry strncmp length
      commit: 37689bcbc41b3850781b6c84f90cb4bd632bfbf0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

