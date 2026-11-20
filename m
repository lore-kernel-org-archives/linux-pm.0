Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152516;
	b=ygn+5fO/ZJjVXq/UkjzuAv9EyBcoSCJ5dV38D67U2OvFMRnDJa/mnzKbZVbzruQ/JxrH
	 GOCoRze14RoSkugBFgDF5MpKINRyPiXnve3elRoSUSjpBMIkgOYUkOCWfBEQWyEpVp7du
	 acSO7JiW4vASv6Ygi8tONqJ6MAXAS2jIt64p6IrV+ZSxa7RgVqPNnxNuxB6sgz/60goIh
	 3EPi047irdiJjO0FPC8rRPtofS8Cqe6rPSFgvKQMK8jAT17rnpfiK6eKxyFRnApftrol9
	 87SYUOncp7eWAx3faeH7GPiDqo0Av8eGPuITZU1V28v+yfW9NVAQkcWHLbJAQN2Pw9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152516;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=fp4aSYvYTDfzsDPLToNjdbEI7hj1JqfcLVUsVq5WVh0=;
	b=ChojvVKuiKK7rq+zXleO9Hv0IvJdhJPXuJgjjc1yJ02X6IjXqNYzxszNKiJgHzhPhhei
	 fZZZqxAII6bamxhtc0KAt28GcG1kShcugs9go3UcjjbTA/m8RoPZyTUH8BGE2H1OGI6na
	 pKQdDzNVvaen3I7oCTLx7aahCpL2T1wtmD+4SfaTZW7zBFPNBiuzMoHKqYDz3D4prITyp
	 +ZQxTzlPZ2A19Hz6DHaHol/lzaBpOWog2wGLnFLrF9vElH2fuc6JoM0SpjiiwzaK7lC/4
	 +ev7MvYE3G8YAEMlwUawyUC5DFUTPLInSZgPtBpA+RC+hFSiHMjg/sVlyM4mdMq1PWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=G6JZ2axA;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A1606A326;
	Fri, 20 Nov 2026 05:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=G6JZ2axA
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jW3ld6XnDzKqgD;
	Fri, 20 Nov 2026 06:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp4aSYvYTDfzsDPLToNjdbEI7hj1JqfcLVUsVq5WVh0=;
	b=G6JZ2axAfxzVocZVPc1BBFG3Z6a20ar0ukHEYQurxoJZV2x4DDGfdh1dz7ONQzYY824swb
	RbV1/S51+AoFNVn7dgl6XhfCYxds/iDldiTurmlh41tT2s6RN79sqyils7MGdomMBIdkNG
	B9VIsQrn/c/uTx5G+ZYVmTCtCcVdAU/u9C+2SQlMOuzybs0TEV0Nvpz5baj7BNtzs3pN3g
	YDH6Z6wHHp6XvHTVIsa1zrWf5dge7nXlGUz7djz2oDSg7v6ZrztmklYtyBHu8wsDA+yLLF
	ohj+3ngWjZjsOZwoylEy0KXjkp8vaV1bkaZGNn2DWhQwbDJG2uPofatoR1Hwdg==
Message-ID: <e9e9ed8b-beef-48ca-a7b6-b9431ff620e5@mailbox.org>
Date: Fri, 20 Nov 2026 04:35:24 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] pmdomain: renesas: r8a78000: Drop MDLC name
 comment
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Paul Elder <paul.elder+renesas@ideasonboard.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1795029012.git.geert+renesas@glider.be>
 <11c375d15b5073212ca79e11330e422539eae4b5.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <11c375d15b5073212ca79e11330e422539eae4b5.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4f4a12289c6e5c7e00e
X-MBO-RS-META: huq6z8expskmc871pddhkis4ozgmsr4e

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> There is no need to document Module Controller base addresses in
> mdlc_info tables, as a mod_map initializer already contains the Module
> Controller's name.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
