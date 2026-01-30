Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EE3074BA;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811872; cv=none; b=timY6ezIb3AJ8IhwzCA+DTTAes0yhbsQZJbx1hyK2XLNUeV0ba5iLQHBuRsVJ8iTacy+uob/8KveQoetW9AHybw6dzft5y3rHYpl2YModAeFkHqDLV8xvqY3yYRuKAN1/r14nFS5Vll7a8bZbf89S+GrtU0Vf7Wr+v/1WFcFMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811872; c=relaxed/simple;
	bh=NavC2bb9AEBm27HWFCCpX0NYxKn+Bm1XTB0FfrsTJ+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TyctlbVXZanxlETZPH6hXl6ZxutRMOYVJaf2Z9hRZw/BMgjSKx6XmdKmR4Xnl+GTKaZ4MgZ+gyuQoCaYnvJSMDRXhYEhJDFo+uQn1Gy8McZG0DbiIH+/MraZOQyaMATIaVTfF5LOb7anZN3S5euEs3WrYfjBDCmMZNyI176e3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5924C16AAE;
	Fri, 30 Jan 2026 22:24:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B89A9180595; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
References: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
Subject: Re: [PATCH] power: supply: pm8916_lbc: Fix use-after-free for
 extcon in IRQ handler
Message-Id: <176981186774.331784.1512073948945933608.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 23 Jan 2026 11:24:20 +0100, Waqar Hameed wrote:
> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `extcon` handle, means that the
> `extcon` handle will be deallocated/unregistered _before_ the interrupt
> handler (since `devm_` naturally deallocates in reverse allocation
> order). This means that during removal, there is a race condition where
> an interrupt can fire just _after_ the `extcon` handle has been
> freed, *but* just _before_ the corresponding unregistration of the IRQ
> handler has run.
> 
> [...]

Applied, thanks!

[1/1] power: supply: pm8916_lbc: Fix use-after-free for extcon in IRQ handler
      commit: 23067259919663580c6f81801847cfc7bd54fd1f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

