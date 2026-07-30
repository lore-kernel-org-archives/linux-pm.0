Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526F3D45E5;
	Thu, 30 Jul 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449074; cv=none; b=lY496gTdX3Iuk8c6cUR+m8bOcjth1pcH5se5ndNPTiQNacURqtk6KEf7gbU74mdNTaWtdnD7zaIJbxpDe9SjxY59y0gWcNEQNG/7qs9ln0soYlg9R83JywEJcJ49g/BZFjUIvp5rhIpG58qW233X2q3t9Zu0ankStMPGJluDA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449074; c=relaxed/simple;
	bh=uBRH3lppt/RGBruWe3TgsgiqCr3KzlW/QnBS+E/bhTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hFMkQ9C0i4fcXdG96ZbuT7ZwFEeoTdYSPvQADCO/Ump1EANMnAXi3v5lHRK3K4GBel47/46X3arIe9lit6JzIWUwEbdUnN1Aggp40UnIVRlgCGLBu4b74Dw/SDTarVMZV+L67ZZZ81xGTrVdWMO+dnzL2/bPnXU+c5OqFCVK0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DC1F00A3D;
	Thu, 30 Jul 2026 22:04:32 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 69411180752; Fri, 31 Jul 2026 00:04:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, 
 zhang.lyra@gmail.com, Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn
In-Reply-To: <5d48b827687168cb1b1bfe85f17945566b42829d.1785321763.git.getshell@seu.edu.cn>
References: <5d48b827687168cb1b1bfe85f17945566b42829d.1785321763.git.getshell@seu.edu.cn>
Subject: Re: [PATCH v2] power: supply: sc2731_charger: cancel work on
 remove
Message-Id: <178544907141.238864.15876891010261286730.b4-ty@b4>
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


On Wed, 29 Jul 2026 18:46:59 +0800, Hongyan Xu wrote:
> The USB notifier and initial charger detection can schedule info->work.
> The remove path unregisters the notifier, but does not cancel queued or
> running work before the devm-allocated driver data is released.
> 
> Set the platform drvdata used by remove, then cancel the work after
> unregistering the notifier.
> 
> [...]

Applied, thanks!

[1/1] power: supply: sc2731_charger: cancel work on remove
      commit: dfc859bb8d332c525872f1a44028137724fa1998

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

