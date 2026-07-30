Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F13CF1E6;
	Thu, 30 Jul 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449074; cv=none; b=kyvFupOI4V/1FydIVIdyt/514wtwCa+m5ddrUU3v+UggDo7ENm5d0Bub7CMJgtqrftOTYyHSHmcd/vab3EFCZX9In+tBuNlTerLrfOf9XZZddj4b0fQOdhdw6Us6J7ZcngoBgrtzdlAvyvvItKORG+WHkBvekINvjxV9ayXWO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449074; c=relaxed/simple;
	bh=4FA1+ZcZSyt99iyY5aVGreWM1JCk7Ct3ccYs6H8/WEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uKI89BY/xkaHEGbmYZ40Mu2kddMRfKYxykUUU8ASMnGVJxeksvtFUeEJP1UXcTIa9TqS/kJRm2aquOklaNTH69p93FHQoWDApRTrzTooHDLLhxjHtZw+s6eFRafsbWMHT+OZXQjCCTkv3soTFiwxGmFJW/qIUWrUHFQ9YF9GDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAEC1F000E9;
	Thu, 30 Jul 2026 22:04:32 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 610AA18073B; Fri, 31 Jul 2026 00:04:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: pali@kernel.org, sre@kernel.org, Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn
In-Reply-To: <20260728123423.781-5-getshell@seu.edu.cn>
References: <20260728123423.781-5-getshell@seu.edu.cn>
Subject: Re: [PATCH] power: supply: isp1704_charger: cancel work on remove
Message-Id: <178544907138.238864.16061378690960655968.b4-ty@b4>
Date: Fri, 31 Jul 2026 00:04:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 28 Jul 2026 20:33:39 +0800, Hongyan Xu wrote:
> The USB notifier and initial VBUS detection can schedule isp->work. The
> remove path unregisters the notifier and power supply, but does not wait
> for queued or running work before tearing down the power supply state.
> 
> Cancel the work after unregistering the notifier. Do this before
> unregistering the power supply.
> 
> [...]

Applied, thanks!

[1/1] power: supply: isp1704_charger: cancel work on remove
      commit: 60c5b8a9ef4dbc5d69bbc1a960fe55826cb3b643

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

