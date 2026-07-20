Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D29B8D0;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589180; cv=none; b=H4js2Y/PPgdfbWBHovakUh/V5Lyu46R0pRlYVnNY6RM/Fzf/64Lz8NGnXGer0vmbrpaWnTiJ+1DUqEnwA0MGS32bBAwTo53eOkXl9ZATYONtbPnTOZ5SVpKP/fG2Oi24HfE81cU/gK8JZRohQg5HYlWRKgmNOLLpBWNdCw85c20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589180; c=relaxed/simple;
	bh=tj/Acjm51K3m2QA5JE4EmnzfXv6yJBpT6wZWDv2WjPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n0K5Et8yzqSikv6EhfhrQ177WXwhA7kw7qq8PqBs1nZ1aLmJmx3NyFdIhzuiKrhMa3sC9BDw1Nkqy/+ZSUH03oLb40oaAbefuJzzt8wcl/EGG/WlXeDKLbycBhDhA5Z7P9pEFst/XcF7l4CC4bvokwUtGMTwC5XKQQgpMtM9S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741321F000E9;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0426C180882; Tue, 21 Jul 2026 01:12:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Anas Khan <anxkhn28@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260702194547.65209-1-anxkhn28@gmail.com>
References: <20260702194547.65209-1-anxkhn28@gmail.com>
Subject: Re: [PATCH] power: supply: bq256xx: drop always-true inner
 condition
Message-Id: <178458917800.375902.7827717389755566253.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 01:12:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 03 Jul 2026 01:15:47 +0530, Anas Khan wrote:
> In bq256xx_array_parse() the inner "if (val < array[i])" repeats the
> second half of the enclosing "if (val > array[i - 1] && val < array[i])",
> so it is always true and the "else return i" arm is dead code. The
> function performs a round-down table lookup, so returning i - 1 for a
> value that falls strictly between two entries is the intended result.
> Collapse the redundant branch into a single "return i - 1;"; no
> functional change.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: drop always-true inner condition
      commit: c41f57bb3b65fe0b2f5f556752dc03ac66b8c5db

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

