Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEE4B048E;
	Fri,  7 Aug 2026 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063848; cv=none; b=gZ8XvaHpZKzT00yM+lrv1k0LLwT1r+GG9rkQkjhRZDIHlbtefTwEIygtZxzZz2L2qi1X7YtkHQu3GC09ysJyeGb/vQAVBV41/1OdoHc3ecc/uNTzFiFjmlkyEGQ7g5BBXXm+fx21YwQ7b8CMhvoA6ESTv9j4LeP6BmAWyi7ZtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063848; c=relaxed/simple;
	bh=weo2qNIvYrn389DLytj5W1XNtj44Vck0yM6RSrzjXDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WbVR75fHyjmn/c/3L1rFYAJDsSa+7EwOhvEI4V7B794MwrH3XI2WhVOvCQYhjsxY94Mvg2vKec0fUkDWUN7+8yDsKkpHt1ytIArIyiXxVjQKOlL8qq6gjFEOHtscKmKfgCXiN28/t3AsNW6oFW9q6iB3hvaIfa0yFkXuKxOaggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16391F000E9;
	Fri,  7 Aug 2026 00:50:46 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 065171808BD; Fri, 07 Aug 2026 02:50:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Elson Serrao <elson.serrao@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260805185401.3625514-1-elson.serrao@oss.qualcomm.com>
References: <20260805185401.3625514-1-elson.serrao@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: add stubs for notifier registration
 helpers
Message-Id: <178606384499.107065.475250347908478923.b4-ty@b4>
Date: Fri, 07 Aug 2026 02:50:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 05 Aug 2026 11:54:01 -0700, Elson Serrao wrote:
> power_supply_reg_notifier() and power_supply_unreg_notifier() are declared
> unconditionally, with no fallback when CONFIG_POWER_SUPPLY is disabled.
> Any driver that calls them unconditionally fails to link:
> 
> ERROR: modpost: "power_supply_unreg_notifier" [drivers/usb/dwc3/dwc3.ko]
> undefined!
> ERROR: modpost: "power_supply_reg_notifier" [drivers/usb/dwc3/dwc3.ko]
> undefined!
> 
> [...]

Applied, thanks!

[1/1] power: supply: add stubs for notifier registration helpers
      commit: 99b38cda3f4c486cfbc40f3c8ede1703594e9f13

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

