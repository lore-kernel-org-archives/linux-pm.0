Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C87489FD9;
	Wed,  9 Sep 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994322; cv=none; b=T9C1nStTfZZsmV8dLJhXYIVERl4HtNvxyRe3B1LlCri8ybMqm52VBLvIUAjAjabc/Ub6KPxEY3RqIXwFjY+AuHunltrBrIinvRidupKFJPfUF7acOguq+koLw4XAWYDoG2369QmKrjBvCOG8tSONjFDO+LbP8clI7Iv6UUGAnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994322; c=relaxed/simple;
	bh=S7HrEjZFHCfAYz4Gs1UMmsNL3g1or3BBMu/Lp9I+EFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rBOec4vkuIkz30fjWac13dIQ9sePsQ/MN+ftmFIsZOuJ7ketZOUnk9LFPrdPw03FauK83CgBUmXYMdm9SenGXZ1ZgH5lavTCvY0yZoKmD490mdXdh6fZ+RdXOEil3rTi+ZRe+6fFZGWBiKo5ZWkoP2xOW3kOpENEL+f+jzPqX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3ED1F00893;
	Wed,  9 Sep 2026 22:51:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 228E0183379; Thu, 10 Sep 2026 00:51:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
In-Reply-To: <20260909064623.90737-1-kmehltretter@gmail.com>
References: <20260909064623.90737-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] power: supply: Fix maintenance charge table kernel-doc
Message-Id: <178899431013.982928.2759698669106964355.b4-ty@b4>
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


On Wed, 09 Sep 2026 08:46:23 +0200, Karl Mehltretter wrote:
> struct power_supply_maintenance_charge_table contains
> charge_safety_timer_minutes, but its kernel-doc describes
> safety_timer_minutes. This leaves the real member undescribed and adds a
> nonexistent member to the generated documentation.
> 
> Use the member's actual name.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Fix maintenance charge table kernel-doc
      commit: 45d4af4e80a25881b6b75e8e34872c555c43a41d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

