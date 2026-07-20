Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF439D6DA;
	Mon, 20 Jul 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584985; cv=none; b=Nj2eKqknpLjmsL755i/ANr98HMtZV4peHCweoBtobBcqABSavt7+oLZbkjqSXrzV6G/VB7SKCpo3m/4YAoxh/Dr35yA4cTqeViTc6y2S1q0cIN/6pMQqyEbLVD9mD3ICS2EkAou9F7F+zqfeDE3HYpim0117Y1VThvbe2XR/GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584985; c=relaxed/simple;
	bh=Qfw9hDyqtFtfK9X+9gcNPN12gmFOIKzrSAp3DcA7iY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VKjmF2gOtutXWGGTvNhuMr5F3/GWavzyKYImmRApSmsHQiHUVCd+cklKo9vHOUOo1qnRTMhTZr/OGdJallH/1LmlxrtuyEupNJn2JkypJLKihFSSvV2LFLW+XVi0bAKwqvm1V7nbbqPu9vdPxtc/gI1ofA6ewCMkEF5au0Ep634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FF91F000E9;
	Mon, 20 Jul 2026 22:03:03 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 52FA2180A25; Tue, 21 Jul 2026 00:03:02 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-pm@vger.kernel.org
In-Reply-To: <20260620011821.3568674-1-rdunlap@infradead.org>
References: <20260620011821.3568674-1-rdunlap@infradead.org>
Subject: Re: [PATCH] power: supply: bd71828: add a terminating table border
Message-Id: <178458498231.324529.11457934412998716557.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 00:03:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 19 Jun 2026 18:18:21 -0700, Randy Dunlap wrote:
> Fix a documentation build error by adding a bottom table border:
> 
> Documentation/ABI/testing/sysfs-class-power-bd71828:1: ERROR: Malformed table.
> No bottom table border found.
> ============  ===========================================
> 1             automatic adjustment of input current limit
> 0             no adjustment of input current limit. This
>               helps for more unusual power sources like
>               solar modules. [docutils]
> 
> [...]

Applied, thanks!

[1/1] power: supply: bd71828: add a terminating table border
      commit: b056f21a38276ead20353d71d50a52206609d242

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

