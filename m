Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2460351C3A;
	Tue,  3 Mar 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578808; cv=none; b=jSKXqCSryMk3J48TfNKmXmGqzZySoawO15WEqbiOmSuW6rWq8EoBS1N8CDv7BVywIBp+umW3Xyyqk4x/vBpu/51FsjJYXSNCGA9cSiwznCzEBZEDT0uvqGWPiTXlMfJu2GQgpDtqjNnM+XVRypD4CrFH/k1whukQPXfx0nNXTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578808; c=relaxed/simple;
	bh=o22TXmcqQuQF5iyQXMGXcG45k3u1ANWh9bPqAF68sbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MsSyNIJGffb/uG2M3bI45eYIJxLWjQbLJY9YBL3MWt39lZ68KVwhKbQLr9lXUJELe1++nysUDukW2ijlHhagl76U1i7W8Og5P8CIKd4rPHDcUAffxl4uVikklc+04SZ5rkP/Q2V/dC2uEqBr0o//LRmq3+RjbJqonG2+1Y0AxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6032FC2BCAF;
	Tue,  3 Mar 2026 23:00:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 38699180D07; Wed, 04 Mar 2026 00:00:06 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20260303175959.75647-1-afd@ti.com>
References: <20260303175959.75647-1-afd@ti.com>
Subject: Re: [PATCH v2] power: reset: keystone: Use
 register_sys_off_handler(SYS_OFF_MODE_RESTART)
Message-Id: <177257880621.673153.6832215237201765827.b4-ty@collabora.com>
Date: Wed, 04 Mar 2026 00:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 03 Mar 2026 11:59:59 -0600, Andrew Davis wrote:
> Function register_restart_handler() is deprecated. Using this new API
> removes our need to keep and manage a struct notifier_block.
> 
> 

Applied, thanks!

[1/1] power: reset: keystone: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
      commit: c2bfe2edf741b6ae03acda7ab795974cf53d342c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

