Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3180476686;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936111; cv=none; b=YA28zrpYSEKrRWplhakbpLK4s4jHBDDnjef8zs7rEDVTE9iUYIi2Ar5XvXLUzplHDalQkNJ9bZXwXXE/ia8TmrVPb9zQosdF2RrxC4gYEh5G133Osh4e+K69/iY/t5VBW/pqqqgMc92/ewqeYp4A03NuKvoEH7e4zO9dVpwIT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936111; c=relaxed/simple;
	bh=a1Y+1qktpV6dQWtoUNiMc9BN61DJ7wml2FGJ28fwvBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qL4LIOORo085WVXhNckistTHM1UcFJ/Shx87z2PvchG6kyCkF8EVndIScXab3aH8dwVPzGLnUFdBGzUDB9DUGK/+xBJ+H6GycadhSDbFp01BYKWBIvJrWVzHhRdzJwdebX42o4NJRKw6MWiZCLcPQEv+Oem0t/OLMDhYguPnrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE261F00A3D;
	Fri, 24 Jul 2026 23:35:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 36D66181F18; Sat, 25 Jul 2026 01:35:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Pavan Kumar Kondeti <pavan.kondeti@oss.qualcomm.com>, 
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20260724-arm-psci-system_reset2-vendor-reboots-v24-1-ed5125785ef6@oss.qualcomm.com>
References: <20260724-arm-psci-system_reset2-vendor-reboots-v24-1-ed5125785ef6@oss.qualcomm.com>
Subject: Re: [PATCH v24] power: reset: reboot-mode: Remove devres based
 allocations
Message-Id: <178493610821.699463.8406176306210857245.b4-ty@collabora.com>
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


On Fri, 24 Jul 2026 18:46:04 +0530, Shivendra Pratap wrote:
> Devres APIs are intended for use in drivers, where the managed lifetime
> of resources is tied directly to the driver attach/detach cycle.
> 
> To ensure correct lifetime handling, avoid using devres-based
> allocations in the reboot-mode and explicitly handle allocation and
> cleanup of resources.
> 
> [...]

Applied, thanks!

[1/1] power: reset: reboot-mode: Remove devres based allocations
      commit: 42326d59391cf287bf21224f3fdca528be31ece2

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

