Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514D449985;
	Wed,  9 Sep 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986992; cv=none; b=leftWWxDF1BLnVsbrT2Cm8dSU4Sz5aN9c/8pl5Y0/8xoIB0twjVG7XIGHYvoQbIjJ/8xNCKEz9OArJd84hUh+N/Yf0bQXziSGzFjgYdnBV8g2vmAZZ0op+cq5uIdObtXoD1v/DhsrUzC9p4LcwzpVUAyMIWCnlhKqYyz2Ldro+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986992; c=relaxed/simple;
	bh=VBp2K204Qg5yshQXRcn7+xGsoMsGquK1U4TgDSUle6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjlXwfwPBZD5SPkpbcbUVRffQUSlxnrl+bwgZPyPuqXRDtNsGvjJCfhfIlPs3HP4CGz+6eO+AsgksUlCnxJRZV8zSxr6UBj7F+RaCgzHndDL3FMXPTlsCxGmU7GlbvHR0LzWfdiQn+DtJ/6omjLG+yp1XXXvF2KDXhaJrN7j/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231A71F0089A;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0DB6218337E; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Konrad Dybcio <konradybcio@kernel.org>, "hpp.iscas" <hppiscas@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260905134500.67832-1-hppiscas@163.com>
References: <20260905134500.67832-1-hppiscas@163.com>
Subject: Re: [PATCH] power: supply: mm8013: Publish the OF module alias
Message-Id: <178898697204.883277.3903389419972849312.b4-ty@b4>
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


On Sat, 05 Sep 2026 21:45:00 +0800, hpp.iscas wrote:
> The MM8013 driver matches mitsumi,mm8013 Device Tree clients, but
> exports only its legacy I2C ID table. The I2C core emits an OF modalias
> for these clients rather than i2c:mm8013.
> 
> Publish the existing OF match table without changing gauge operations.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: mm8013: Publish the OF module alias
      commit: 95450ccb3545c8ecbd61a41d4727ff8df86d3bd3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

