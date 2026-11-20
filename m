Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152519;
	b=UqmKy8i/X+oGyCJbCuopg8nTDd06SPcnk8Vh6xdfBttTb0zBpxNNN/0kmbfMuVrkVIOM
	 AM2d1vCyh/1JO+NZZahQgdUuTmD26QKcCKBb0TmSyZFswG9ol6xsRMZytjczjHfjpBdeW
	 Wq4dko+xQYBwT0dpJZL5yZ/QtqgUOs2vGpVe1h4cbjAEp7m0xY4+gqGaP6tnFPhoxMb8v
	 hNRcB2Wd60r7LiLy8DaU5pjXYGeMm19If363pFPifgwLyEpFpZccriXn4j8K7Wx7MZ19G
	 nyMfJa2zaqRT//PbgF2k7J+mtfy4Xo5GrOR7U+UF6v71Rsf35AnqBZd+QW0CjLDV/yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152519;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=bOtRn9pWlnVKBkrN+sQPsmyroCxtIQHYzIEKtafqJws=;
	b=dNVNMnGgytORIvbQZWbdWaCjHT9Y7uW9wp9Uk+XJv7z2JeQXYUBy90hP6rDUUC6EUB8q
	 W6cxIFjuZxISnb4TOmYmofekhBGRLogQ9EXr40v9bAVt3dtEifXByZnE3R1vS22LiksYr
	 K0FBNHmwMiVNEXmQD2dWEN6NjiXH+vYkyi9XnBU9tpol/TgeP9rtuTP+ft6f7G1Cec4Dj
	 Bxcf6fYbfx5z69FQkaMhdvJ40wcOLxr0hCsR5qpwetp7fzKtwJ6Tf10477QmKdXmgYehU
	 cqMGJdQ1S7kEC0TXRY60h3LC8gxUEQD9oTRSd0/DYRgVwjZR/ZYLDzg6rvlxrvfeM+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="WH/z1X8C";
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABB606A332;
	Fri, 20 Nov 2026 05:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71ABB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=WH/z1X8C
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jW3ll3FCTzMlwH;
	Fri, 20 Nov 2026 06:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOtRn9pWlnVKBkrN+sQPsmyroCxtIQHYzIEKtafqJws=;
	b=WH/z1X8CpIYz8PCoai5azWInGByNIzM2UuSLsj8C5ZVqvfKVerpdcJ84NMZpxbHlnEYZnL
	mQXl6pJoja9kAU83PW/W7VmgiKDqf6FfWiJbmOQKhQ4dqY5XKSllXo72waOMj9lo1Pa0QU
	JXNahzkOwNAysxkzg3RWz0H2pgJXtKgDDyjj5ZctbjoIDPDs4yPiYhZZmRMIg6Sf0p4tUv
	BhsmkJ1LH6rghJH0he5WB39fFjp42mSdyYT3TSZRXBzHN2GlDQfALOE+uRb6eGZCFZMNpT
	LAMggAb3zHxEaqyjfsUOxea59OYMhLizVriJjyW/z2GWbqNJxagTZltyCJNIdQ==
Message-ID: <1bb22478-6ed8-432b-bfe7-efb29b5f091e@mailbox.org>
Date: Fri, 20 Nov 2026 04:37:36 +0100
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
Subject: Re: [PATCH v5 13/15] pmdomain: renesas: r8a78000: Shrink IDs to 16
 bits
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
 <72f8eae23faefaa169cff7a52cdbafce2cd50e1f.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <72f8eae23faefaa169cff7a52cdbafce2cd50e1f.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7aef4dacef87d464d56
X-MBO-RS-META: 3nc4ods5k8jsq9wxn16ge3piqdifkp9y

On 11/18/26 8:45 PM, Geert Uytterhoeven wrote:
> Reduce table size by shrinking hardware module IDs from 32 to 16 bits,
> which is still plenty.
> 
> While at it, use u32 to store of_phandle_args.args[1] in
> r8a78000_mdlc_attach_dev().

This could possibly be a separate patch, but let's not inflate the 
series further.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
