Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82A25487C;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521296; cv=none; b=gO1TdUOYARUJHXhvWFqYlha4htFCiIIjmUlpWDBLv3oMvAHUqt9ZRNEatrkwyxdVXrXZDwj5x+o+e3/F6KHCukVm37bNocZwM7fbZEsugbkvoOTcP8R5WCQYLH4p/WBZvDRvSQjOcq8FEJUVqGsY8c2xiwWEOLA4n+2VRcM/p1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521296; c=relaxed/simple;
	bh=2Z3vH3at6zW/FEXglHlXdD3/rBAIHseOzuZBC7SzmPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k62MdTdkofj2kNCLJFs8rOcXVi2/4K0aBK/JXVOrZ8kdSSUg6XkGeaHlFFz91JONDveRDLpH4ZE1EUoDHio/ktWskLArmvA3GOZxR61EI6ct9/7x2DP/aj5Nvw1xd4Rh/j3e+p1jYkB3IYmdqTK0D/q72N9oG2X6hIX6PaS00FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B67B1F00899;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 18936180C6E; Wed, 03 Jun 2026 23:14:53 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20260519004144.626969-1-rosenp@gmail.com>
References: <20260519004144.626969-1-rosenp@gmail.com>
Subject: Re: [PATCH] power: reset: st-poweroff: Use
 of_device_get_match_data()
Message-Id: <178052129306.2671410.11540232880870258992.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:14:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 18 May 2026 17:41:44 -0700, Rosen Penev wrote:
> Use of_device_get_match_data() to fetch the reset syscfg data directly
> instead of open-coding an of_match_device() lookup.
> 
> This also lets the driver drop the of_device.h include.
> 
> 

Applied, thanks!

[1/1] power: reset: st-poweroff: Use of_device_get_match_data()
      commit: c05383b9074d72d244d3dea34832eeb725317575

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

