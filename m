Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532301D2B37;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114919; cv=none; b=C7bopQELwC3YRAZ9NUjoWXizatzDZLo00pTbUYTE+Nk7696I+lML6EUkxORWopBqTrGZn4pvEc2iNAVHB2IlIHc0QI5qdPP+iB+68zTxARwEh4jSNeaiFopgd5GBExIP2ZTrkZZJln0K77WdMLL+SyQ/M7uOxGnK15vAW15utVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114919; c=relaxed/simple;
	bh=44oAzDVjlJcp6euPtfPhNF4v7QH61ESK4rvLm/EPupg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ostp9HpyfO9n4tYfMiKkx8RogU0/0r+USqIwHhvz8W4RqFYkYvmDtJLXoI5iNcp0lhRjdwMvUadRSmEZLPhMgT1wZInpVx3daDAcy9qB/mNVGQEnmi9B5HAQd145e/0pRU6KgMIllUNeXMcqq3QARGfb7Po4iEgl4wk4mEEvALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46BC4CED1;
	Wed, 16 Oct 2024 21:41:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4A3A11060455; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241016-fix_bq27426-v2-1-aa6c0f51a9f6@mainlining.org>
References: <20241016-fix_bq27426-v2-1-aa6c0f51a9f6@mainlining.org>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Fix registers of bq27426
Message-Id: <172911491629.630785.15560448236855910472.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 20:54:05 +0200, Barnabás Czémán wrote:
> Correct bq27426 registers, according to technical reference manual
> it does not have Design Capacity register so it is not register
> compatible with bq27421.
> 
> 

Applied, thanks!

[1/1] power: supply: bq27xxx: Fix registers of bq27426
      commit: 34f99d3b706a519e556841f405c224ca708b1f54

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

