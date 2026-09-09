Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D933B71A1;
	Wed,  9 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986993; cv=none; b=Ihiy9A3NmlyMQkfmAo5IJoOgNIEYK/IOUkvYRuqqRSZ4eo8T7NSBHw1tt/Yog5eYAnU8srCtx70krdmU2lMf8YvXSGQHVZ8uEPiQrW0sNow2YnSKlHrAiz/YnkTR/Ql7BJzt8c6Ef8C4lB5vt/OuriQNswjDxl0LdVkghldByWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986993; c=relaxed/simple;
	bh=HUZ/6Qcvdbp0mmvie6g7UvbQ2JSJi++qvHcZWQNFsZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XwvKPGSXbAFyhml8vJpawSP7Z6aAMqttTmnyyU7cNlE/bcTj9u9sa7qCHlN6a88R99X87tUn0lpZ1sEDU1WWsTQLvj4Ktalw1PPopKgp6QWfCwznNlQKEP+tf8esFNtcFNH/O/KSw20tfOkfRF9gzowzklZhcYc0Zq/rzNGID54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3709E1F00893;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2F013183383; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260907063947.34852-1-hemanth.selam@gmail.com>
References: <20260907063947.34852-1-hemanth.selam@gmail.com>
Subject: Re: (subset) [PATCH 0/2] power: fix typos in comments
Message-Id: <178898697218.883277.18435006047420230731.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 07 Sep 2026 12:09:45 +0530, Hemanth Selam wrote:
> This corrects 2 misspellings in comments.  Each is a separate patch so
> that any one of them can be dropped without touching the rest.
> 
> Nothing outside comments changes.  Every touched C file was checked by
> dropping its comments, replacing each string literal with a placeholder
> and collapsing whitespace; what remained was identical before and after,
> so the compiled code cannot differ.
> 
> [...]

Applied, thanks!

[1/2] power: supply: fix typos in comments
      commit: ee0b9288afbe0af27f7257d17bc0c1d61ca52007

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

