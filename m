Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543A355F43;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583828; cv=none; b=nvH6C5miAJlIB9J6VsKGjNDaZyc0wM9YgAcW3vKyp34lZwsR9lLVLyEUCmhbMNlbs0B9TSG77D5D+17Pw/ktDCQUH28ZFZTD0YPmzxP93/tXKbcGhPaPPX4R86Gb1YhQbCkJnbpNSfgKIgYxmU6l+BuWVPpSGG+efx9WWF22J5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583828; c=relaxed/simple;
	bh=ToarG//am5AhA+91IhD/g3hcXqp125VXmQqFdOO82s0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ReGlBVA45ozFByyDyWrikliRhH/oVAGEY9uP49VJM5jtb22NKQNhBYhioHgF8gWzINnR9WOODk95iMTkJj7O/ZnvJrCAXxoTIcH44koTySA8vdbbmj8/X1gsdIlOOQwLQy3SO5D99n/t5yh1eVeOUsPaYgowgb3v4+gkDanxBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD21F00A3D;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D5D7A180A25; Mon, 20 Jul 2026 23:43:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260612215325.1889302-1-robh@kernel.org>
References: <20260612215325.1889302-1-robh@kernel.org>
Subject: Re: [PATCH] power: reset: Read "priority" as unsigned
Message-Id: <178458382586.311390.6532895011954826052.b4-ty@collabora.com>
Date: Mon, 20 Jul 2026 23:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 12 Jun 2026 16:53:24 -0500, Rob Herring (Arm) wrote:
> The restart-handler binding documents "priority" as a uint32 value in
> the range 0 to 255. The syscon reboot driver stored it in an int and
> used the signed DT helper, which makes the helper type disagree with
> the schema.
> 
> Read "priority" as u32 so the driver follows the binding while
> preserving the same default value.
> 
> [...]

Applied, thanks!

[1/1] power: reset: Read "priority" as unsigned
      commit: 6539d798e9faf6e98d64ad7cb3af91d42180a886

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

