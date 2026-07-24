Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A434476689;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936111; cv=none; b=b1uzG1IlN0Nx+bw94+elRGK57XQxRuA3hsf1rEa2y3K5SWFldNtRPT8zMM4oVuHiZRAhf6jOa5T8fEMLnW6WdcY54XwJSy5FkftpzLagG9aItk3XGtSxldbpmfLShyxEnNpfCGbqOhlVH4UU8J1iwCxzj4FlOmkqfcsoMV+llnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936111; c=relaxed/simple;
	bh=F3/tCE7x6Cqg/jVmMsd9bq7Rinyr7sZcb4LkSCQymRQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SiO/wmK6tzSrHTKYzHLO8ickkYp4M3jfRDNxlWsA1DM42DOjfZ/+xsvRp+Ra5lqgwywHTIWbc2XN1eVgQndrUpgRs9VgjPfWoEMnfKDVCVicncMmSu20Q/MNPUcbX3eD1OcPvG18jta0BLwu+PDTmGmS3WCkbeaAKJHZl/rgMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83EA1F000E9;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3A945181F1A; Sat, 25 Jul 2026 01:35:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Steffen Dirkwinkel <lists@steffen.cc>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
In-Reply-To: <20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com>
References: <20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com>
Subject: Re: [PATCH] power: supply: hold extensions_sem when creating LED
 triggers
Message-Id: <178493610823.699463.8029797889539744312.b4-ty@collabora.com>
Date: Sat, 25 Jul 2026 01:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 24 Jul 2026 09:27:35 +0200, Steffen Dirkwinkel wrote:
> LED triggers were created in __power_supply_register without holding the
> extensions_sem lock. Since commit b04510c3af6d ("power: supply: leds: create
> triggers based on properties, not type") we call power_supply_has_property
> during trigger creation and access the extensions there.
> Move power_supply_create_triggers down into the lock scope used for
> power_supply_add_hwmon_sysfs for the same reason.
> 
> [...]

Applied, thanks!

[1/1] power: supply: hold extensions_sem when creating LED triggers
      commit: 25453aaffac01909232a20409dff1a9e6d609a11

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

