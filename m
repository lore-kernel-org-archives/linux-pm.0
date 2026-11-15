Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784576;
	b=EPuYgpe86pHOUtSaLuxqhKfKChrXlBrlNlzV6AmwgzuV7vI7Y8YSAqjt5R3b3JKHdPC5
	 Nl7anoRLskovB+hUeYcbpdIFBLm2S2fBJIR/jcwpca+RIUj2ZeEJ0XvNvd1rJq2J/nLo6
	 p2fgzmAe2NVkotR7T2RzcHMzDm9M2ZGfEcvFma5j2mK98HTXzItQRyXPaALN8g8IwgkD8
	 olJwEVRBZiFUu/NH3nq5YGC7T3v9hIxhq5A3NC9chhxnxBHuDL9YkrUh1nZAkahR9pLFp
	 1MTo1JqyZ0saB4Sk+gfoKk4wAPYQzJOfuCk8cwoFoaGRB41PiFg7zyD1DPQneVTyXoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784576;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=pLVf/czq8X9NIYaSxWx5S64rb7klQdQkwOBiwWs8GKo=;
	b=TysUWE/7/gZNouuvJSbDdVkP4+h0tpQhFtpj41OWdpTRn637UIUZFe7YTWwu/idtBx2w
	 BBjjVz24eo5pkbPszjZWE7Oy6NVv6CvwXhIbQt+yR/maCjoWJSmgrwu7OUFFxJFH1u3R2
	 Kw+Mqs6vKY5oBif7o3qiSbEJHpf2EC4aO0GwKAWR2BJLJRUW7ffB9xUHRw7nXlsNTKqPs
	 HkXLJ+6RmnlXLP6gbt1AJSnOoq0malKl6mxiEnEo73iItT0V0UJQ9FmyX0se4eJBI5ICk
	 VWUS3BBy0bwd23fOA5J9pqBexCDIGV9zHAcpoDfEuLJzCl3BLLe7e1p6e3/yiQ972jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A70606A323;
	Sun, 15 Nov 2026 23:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A961F000C4;
	Sun, 15 Nov 2026 23:16:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 82914181BF9; Mon, 16 Nov 2026 00:16:13 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Subject: Re: [PATCH v2 0/7] docs: ABI: power: Clean it up
Message-Id: <179478457352.205480.15321547664455079690.b4-ty@b4>
Date: Mon, 16 Nov 2026 00:16:13 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 28 Oct 2026 23:39:30 +0100, Waqar Hameed wrote:
> While working on adding sysfs support for system load control [1],
> kernel test robot reported some warnings. This patch series fixes those
> and some additional ones that were discovered during discussions [2].
> 
> [1] https://lore.kernel.org/lkml/cover.1788290289.git.waqar.hameed@axis.com/
> [2] https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/
> 
> [...]

Applied, thanks!

[1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
      commit: 1fcebcdcf1f2110800fe2b2dac5d8ca59448caf4
[2/7] docs: ABI: power: rt9471: Add newline for paragraphs
      commit: 49f19c982f9aa802b9a2139e08d90a884a782f79
[3/7] docs: ABI: power: rt9471: Fix mismatched quote
      commit: b066270b9fee17c3488dfaf0e9ae2f08e87bf89e
[4/7] docs: ABI: power: rt9467: Fix invalid inline emphasis
      commit: ba7b1cd77baac837288d3a6acfc2508c92ab8ca4
[5/7] docs: ABI: power: rt9467: Add newline for paragraphs
      commit: ad3d1b0c3eb75f9d4d5c0ed07bc5e41fe88c1b69
[6/7] docs: ABI: power: rt9467: Fix mismatched quote
      commit: 0831bb9a3df81cbd3e5af8dae8737dc36d12663e
[7/7] docs: ABI: power: rt9756: Fix invalid inline emphasis
      commit: 4e66725bb93bba005ddefe6c69bcc0927426e859

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

