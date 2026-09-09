Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E13546C2;
	Wed,  9 Sep 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988990; cv=none; b=OKyug7JS3h+QVoV0Drv3DneI5BdX9Oxs9mHrJe/51JKRjx49bsDjWnOvm8CJEpsduuTVSv2SJeZNL7AMwrGbHIKkHZjmQhZBr45C2VYdQHvi/VHJCm4xQMmqUQdDW4wqa3lqeJpGXNbelRtBUNh0M772QDdxx50XWUKTO5XknLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988990; c=relaxed/simple;
	bh=Kl7xIJCHzb19Ame86LrNh+KspetgUlOp3MxhTCjxOBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ghxm8a1f/0vhbqxVmyFCb9RWuvvqlsbexFpvd5LSa8SEzT2Fs53B6CxWaowdpl9CRLLIQdjqh7LzGSz6KJqy2IknSlrybYhqtbJ5Q3uz+DD4AFp+ZXVDVNwDbYpewBFGN2vvLJiOjalAIO2Ja3g1IKXyIFgCFeXCZGzNlrmkcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B12F1F00893;
	Wed,  9 Sep 2026 21:23:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E1DDC183379; Wed, 09 Sep 2026 23:23:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linmao Li <lilinmao@kylinos.cn>
Cc: Ricardo Rivera-Matos <r-rivera-matos@ti.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260824084217.670213-1-lilinmao@kylinos.cn>
References: <20260824084217.670213-1-lilinmao@kylinos.cn>
Subject: Re: [PATCH] power: supply: bq2515x: Propagate charge-enable read
 errors
Message-Id: <178898898591.889628.3925086465501870975.b4-ty@b4>
Date: Wed, 09 Sep 2026 23:23:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 24 Aug 2026 16:42:17 +0800, Linmao Li wrote:
> bq2515x_get_charge_disable() returns bool even though reading the
> charger-disable state can fail. A negative error is therefore converted to
> true, so POWER_SUPPLY_PROP_STATUS reports NOT_CHARGING with success instead
> of propagating the failure. The GPIO read is not checked for errors either.
> 
> Return an int from the helper, check both reads, and only convert a valid
> charger-disable state to the charging-status boolean.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq2515x: Propagate charge-enable read errors
      commit: 35bb788549d45f82f82c88e569d42826e3005c65

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

