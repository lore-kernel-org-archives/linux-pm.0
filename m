Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4342EEE92;
	Wed,  9 Sep 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994322; cv=none; b=of+RjiPcnPX6moeDjDTcXNIZXZ/BisM/s+cyFKBqgy1PW46aBn/9uCtji4t0TU+Q53/tTScwkLfcc98p7QIFTF5Iht/rb1jfMsuT0r2SAfezFFjm+a/F5pVgsHnbbMUktu6xxBrO28ajFciDjkiZkS2B6Wb+JTgRKUTHy4koCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994322; c=relaxed/simple;
	bh=iGZNlc1HG72it6HekTJNKXtkPsVUsyYztoj7vzZkdTM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nG02TekNvwk9L1TBnSXU+hxP7fTs47bLAFYwoTUFnZdagvGIjUdvFK02cHaiyM6NqFymf2WvLf9SfyWd/AIJ60nIMQaUWQU6oi2D1bXmDWSLk1UDZCP/rgW1ZHBWJV4t20+lgr4N1H5HsSufm9WeYPGlXJxYnpZ4UZqvcXQ7LJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8891F00898;
	Wed,  9 Sep 2026 22:51:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1D2EC183378; Thu, 10 Sep 2026 00:51:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: hansg@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, 
 sebastian.krzyszkowiak@puri.sm, kernel@puri.sm, sre@kernel.org, 
 Xueqin Luo <luoxueqin@kylinos.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260901053653.1668492-1-luoxueqin@kylinos.cn>
References: <20260901053653.1668492-1-luoxueqin@kylinos.cn>
Subject: Re: [PATCH] power: supply: max17042_battery: Fix vmin assigned
 instead of vmax in DT parsing
Message-Id: <178899431009.982928.10125011976245638659.b4-ty@b4>
Date: Thu, 10 Sep 2026 00:51:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 01 Sep 2026 13:36:52 +0800, Xueqin Luo wrote:
> The else branch of the "maxim,over-volt" property check assigns the
> parsed value to chip->vmin instead of chip->vmax, so chip->vmin is
> overwritten and chip->vmax never gets the DT value.

Applied, thanks!

[1/1] power: supply: max17042_battery: Fix vmin assigned instead of vmax in DT parsing
      commit: f444a42dce5caf5856b5289c48e0d48e531649d3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

