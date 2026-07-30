Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251343B3BF2;
	Thu, 30 Jul 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449074; cv=none; b=JixdZv5n+H7mAFsq7QeGAA4YL+Wd7RHFs728gG+uL6pEybKRMFwXZruaK5usTrFHBnS197QwpwifiyMfml8+WF26RDehu0I9Jc9evfZPgVIZLVVMqNzidbVV8ZWMPlYIr/ntIB2w9Izx0wDNabieTzbabOgqJRbGHhm6fwhL5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449074; c=relaxed/simple;
	bh=neVy27YmV3bjS1XWy+vuLIXbxGjnquq2tI1/Cp2UmbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QrIol436sITeCZnX1tNoYtvshP+hzKippdFdBTzP0rIbll7ZkBhq4P3qe22nqFYrc9RMaxHgdMWtgj4eeY5SCsZAQ1vnK/kDdF2n06M66hf7p6lA+P8y8lti5Jw1Ura9OXzI4cU3xeYIxLKcREFSpvEhn7NsO4adTG4tnFxHZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40551F00A3E;
	Thu, 30 Jul 2026 22:04:32 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 481711805FF; Fri, 31 Jul 2026 00:04:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linmao Li <lilinmao@kylinos.cn>
Cc: Waqar Hameed <waqar.hameed@axis.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260730011713.3332913-1-lilinmao@kylinos.cn>
References: <20260730011713.3332913-1-lilinmao@kylinos.cn>
Subject: Re: [PATCH v3 0/2] power: supply: bq25630: scope the battery
 information
Message-Id: <178544907126.238864.1557009052294249280.b4-ty@b4>
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


On Thu, 30 Jul 2026 09:17:11 +0800, Linmao Li wrote:
> data->batinfo is only read by bq25630_setup(), but it is fetched in
> bq25630_probe() and kept in the driver data for the lifetime of the
> device.
> 
> Patch 1 moves the get/put pair into bq25630_setup() and drops the member.
> Patch 2 then uses the new power_supply_desc::init callback so the charger
> registers are programmed before the device is exposed to the system.
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq25630: Scope battery information to bq25630_setup()
      commit: 9092828e187f7cb3c7346a64e01a10d8f75ca246
[2/2] power: supply: bq25630: Initialize hardware before exposing the power supply
      commit: fdece8642eca8e20a218837f58c0ae6d83fe53a1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

