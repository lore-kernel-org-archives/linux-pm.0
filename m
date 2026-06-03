Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B54A2E09;
	Wed,  3 Jun 2026 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522773; cv=none; b=iTA8JW1ySn8DADPPG/2+2ay3a03VIl9z4n1jFAuhvNABtRsJZ/X9wT+HlMw3Sh/A7jSmMTj/6x36pZzZwsBfyyeOel/5D8jfUPnNSe6xhJn+h1Uan++4WqjZk/3/FufEev2DJf6Z9OzDiFPBL0b2qDprwl+21NZ1QGlX4BIOqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522773; c=relaxed/simple;
	bh=oDkdB2+V1Wk9rZ1DMHNgbZGa+HPOO6ftAp5QufG9cJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OPk5p2V97QESZTdgrozBHyNLyry669ETRKsg3Sp6R9wWCiDsL6hNm+eGr+o+/BBlWQQRPhrgPPqzMTPxuaL/fy1KnQV8IEwdoRNgF49G9R+Ns5pWimtt64VoOLxtfZ8DCb2zdWH9ijNO+PD0BNm9Rvm28zekHj698L39CYCGv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C891F00893;
	Wed,  3 Jun 2026 21:39:30 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0F5AA180C6E; Wed, 03 Jun 2026 23:39:29 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: sre@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260507191840.25941-1-shofiqtest@gmail.com>
References: <20260507191840.25941-1-shofiqtest@gmail.com>
Subject: Re: [PATCH v2] power: supply: Fix typos in comments
Message-Id: <178052276903.2678508.16723736594560829245.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 07 May 2026 22:18:40 +0300, Md Shofiqul Islam wrote:
> Fix spelling mistake in comments:
>  - occured -> occurred (twice)
> 
> 

Applied, thanks!

[1/1] power: supply: Fix typos in comments
      commit: 15384402c94a55b05d06a446aedd19e242367b6f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

