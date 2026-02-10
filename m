Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3232ED141;
	Tue, 10 Feb 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739982; cv=none; b=ft5oMLJ8ghCF6Md94a66jO7wShyjn3zEDKAx/zZPzAZu1s5sa7vqKSwiJfNL+DqCPGYNaBAbo6IXpBmeV8PjijppR43dlh8+XUD+AeA5USHn1EPsxcuXShLi4dDSqbzROjhxvikzVDs+6llpZfDNF5ToOHRn8V0nhz251v6q3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739982; c=relaxed/simple;
	bh=6/Y48z1fheZE3rm3n9V+OK49uWYPIzUMKUetKEbFzf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJ2dqT/pn5aEg7xga3z3FIs+1HBBbXuAXgQf+A2DdC3gFZb6+TQGU3HpxAY4WT2mUU7POSnxbxTQ5nwENNEzPqyNLGj9CRgprgTTq7ep5xM+LinyKQUMd+d2lHR0/qneEXSW6JQuW+dYXGS8wMojm9Q3LsIQ8uw6n8p2YOdpLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MZ4YPhYx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MZ4YPhYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770739979;
	bh=6/Y48z1fheZE3rm3n9V+OK49uWYPIzUMKUetKEbFzf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ4YPhYxQqngBB/efBNc6lo8JOHegZZL8h0SQP2frwRiOmQjtjQhiL8jUuRUMwewd
	 Y4IlyUw4jyKyuYTZMcbH9jgonNijc5CbOD7VwNwOcKfRFS9oqVwLweV620qReufRiU
	 qp+7BNLDsdL8tkNhC0mrcMsKvwAlGKWIYAiN8hQSG91JyXZP07qZo3mklllPgyhgkO
	 UW+ArEj4GTywBvRwI4/Q2vyRyUUUlmxBNLj1CbvF1yl+mS0Z87c085CUy/x9sOjcbO
	 ylEdYTrIGvBbmtyiEelnazlJurLtYD+sPt761MNvdPJ+aKkW4EdyyNDw/+LxsYoamP
	 ZH6tCMJvYu7Zg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:7872:ec71:6d40:b8ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36E6817E0E90;
	Tue, 10 Feb 2026 17:12:59 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: aford173@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	broonie@kernel.org,
	laura.nao@collabora.com,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	nfraprado@collabora.com,
	sboyd@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 3/5] clk: mediatek: Fix MT8196 topckgen orphan clock
Date: Tue, 10 Feb 2026 17:12:44 +0100
Message-Id: <20260210161244.42828-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210053708.17239-3-aford173@gmail.com>
References: <20260210053708.17239-3-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2/10/26 06:37, Adam Ford wrote:
> There is a clock with its name spelled incorrecly, so when a child tries
> to associate itself to a parent, there isn't a parent.  Fixing the name
> restores the proper parent-child relations of this clocks and eliminates
> the orphaned clock.
>
> Fixes: 895ab0134d64 ("clk: mediatek: Add MT8196 topckgen clock support")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/clk/mediatek/clk-mt8196-topckgen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8196-topckgen.c b/drivers/clk/mediatek/clk-mt8196-topckgen.c
> index 6ace11ef6b69..2482597b9b7a 100644
> --- a/drivers/clk/mediatek/clk-mt8196-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8196-topckgen.c
> @@ -324,7 +324,7 @@ static const char * const emi_parents[] = {
>  	"mainpll_d5_d8",
>  	"mainpll_d5_d4",
>  	"mainpll_d4_d4",
> -	"emipll1_ck"
> +	"emipll"
>  };
>  
>  static const char * const ap2conn_host_parents[] = {

Reviewed-by: Laura Nao <laura.nao@collabora.com>

