Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C24346E59;
	Sun,  4 Oct 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791142440; cv=none; b=rjFnRiuBXMCeNp8moouYlHkaVWBmOQ7VyQZNq88VDvR2tNLSwaCi3dvSLqABxO6t6dzFu1f8eaFgez+6s1nLazoXmePfDloelRk53Ipurj1PUu32IrEAgmvRLF5YbDw/zrCHXCPFQMUpqM++lOZfy86gDzvw3jUnyhyoltAmi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791142440; c=relaxed/simple;
	bh=yEMjz3Y37juxZwypZqzziVPyVSYfGxu41Y9d49Y0jdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M3R1Zj20UVzXiJ3BVRI2btp56PP5UllqzMVZ77RYeYUSb8K6iCRzJ026SMNxqH5aS1ch+7TRknhpdJE4J+E7fnHGWiXDroANgwDUyJsPnT+DaZlQFHW/a2X11UIi0skDMt4v3Q9raY/A6pnYGxs8SMuUpbjnH5kwyAzroxZZtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B61F000FF;
	Sun,  4 Oct 2026 19:33:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C7CE4180A51; Sun, 04 Oct 2026 21:33:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <error27@gmail.com>
In-Reply-To: <20260915052529.7-1-bbnpreetsingh@gmail.com>
References: <20260915052529.7-1-bbnpreetsingh@gmail.com>
Subject: Re: [PATCH] power: supply: max17042_battery: Make the fractional
 LSB macros safe
Message-Id: <179114243480.217534.13196281643425115321.b4-ty@b4>
Date: Sun, 04 Oct 2026 21:33:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 15 Sep 2026 05:25:29 +0000, Babanpreet Singh wrote:
> The fractional LSB macros expand to a plain division, so they only work
> when multiplied first and evaluate to 0 anywhere else. Take the value as
> a macro argument and apply it with mult_frac(). No functional change.

Applied, thanks!

[1/1] power: supply: max17042_battery: Make the fractional LSB macros safe
      commit: df2914e2048556478980df4da89d16390c368e4d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

