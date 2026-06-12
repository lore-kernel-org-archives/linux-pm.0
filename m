Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FC279DAF;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301916; cv=none; b=k5NkW6IIIRNF8TY+wCnZQra2eRtVFWOrp5UDXeoyqvF0qvYfYsD6QyF5ypJGv0Fw2S3I185lZ3JIHtfMsVMo+gDxKFT9TxOcr+fHO4Rrpsl+jMed88dQD6phWECVzArO/A6qF+qX80RNQxVXRBXsXco4dFiNVd+Ie2p2Vs/1riY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301916; c=relaxed/simple;
	bh=zHvZxMIUK1hxyGZduFB3CLwrLsum5vWY5zRV17nX0vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WarmT7Wv5syS54GLj5uc5RT5Qkx6HR+NcWXKC2gpUoKFsfiLmtE89MFNotLTJWMLKC0XCrOKdWmLa6lE7myR6/UjME/ziiOzwVqXCpNeOn8prqfEYuumpoRiehHqXaWFncZMzj7BTaCU0Swnq/lx0ntBRSm1atgh/T1yqAh5fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE281F00A3A;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id A823B1808FA; Sat, 13 Jun 2026 00:05:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, lucas_tsai@richtek.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ren_chen@richtek.com, kevin_hung@richtek.com, cy_huang@richtek.com, 
 alan_lan@richtek.com
In-Reply-To: <20260609114403.3896073-1-lucas_tsai@richtek.com>
References: <20260609114403.3896073-1-lucas_tsai@richtek.com>
Subject: Re: [PATCH] power: supply: core: fix supplied_from allocations
Message-Id: <178130191365.340022.510567492860845220.b4-ty@collabora.com>
Date: Sat, 13 Jun 2026 00:05:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 09 Jun 2026 19:44:03 +0800, lucas_tsai@richtek.com wrote:
> If dts property power-supplies has multiple values, then accessing to
> psy->supplied_from[i-1] in __power_supply_populate_supplied_from will
> overrun supplied_from array.
> 
> 

Applied, thanks!

[1/1] power: supply: core: fix supplied_from allocations
      commit: ba61aed9a34671222d1149acfc2f0179a9ce7e80

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

