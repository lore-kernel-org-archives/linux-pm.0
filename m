Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6523AC00;
	Mon,  2 Mar 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492843; cv=none; b=lKiG0Oh3j8aI5T5jkCphR5L98USD5nKtYXLdixEccYr0F1BAOZzJMkfwZJsEe22TJ1AFcge7qCDS/dNYfoNE3LiJ1CXvyKC9S+ZLBVHWMBbhmhQap5loHjjwN0HJNGnBAX+EDLtHxdQJtlgGzaIjG+Uhw8TYDTXHp0P3c4o+SPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492843; c=relaxed/simple;
	bh=xEjt4P7SO+BYE3zKoAXOx7xzcileDXfanVCVAu5Bci0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EwyO1MGgi8p/RHmfEHvV3ZG97Al7/eQ0yy6TgLxoadJ9XibneNsEuCrqAY+3RCve0voZX/yQ3bLvtdRCLwVOCeUosATzPM9bWYh1HqzJy5xDEzuRREXnANlv4jwTl951rE75TDjVRLOxjGQP1xeBMcakoKFDVkzgWUIFEje2gAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E69C4AF09;
	Mon,  2 Mar 2026 23:07:22 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CA6F6180CCA; Tue, 03 Mar 2026 00:07:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20260302193335.274095-1-afd@ti.com>
References: <20260302193335.274095-1-afd@ti.com>
Subject: Re: [PATCH] power: reset: keystone: Use
 register_sys_off_handler(SYS_OFF_MODE_RESTART)
Message-Id: <177249284080.588775.5940818200059871946.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:07:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 02 Mar 2026 13:33:35 -0600, Andrew Davis wrote:
> Function register_restart_handler() is deprecated. Using this new API
> removes our need to keep and manage a struct notifier_block.
> 
> 

Applied, thanks!

[1/1] power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
      commit: a06517630175468abcce250cdaafec81c4e05ade

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

