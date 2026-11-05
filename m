Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837616;
	b=rcsOIRzm3MJXy69JuTiDdRcRkPlym0loOhF50LnlF6uvDjR2+xTJovDOtVsJn6QOLFcX
	 AKnqVAAdlr6Ch+MsbleIqGOa4GQFnK1qoL3Tk9U8TV1i5DlBWD5kldFDl4hun/jNeGfup
	 MKCvxZ5W2SlMvsXKJ6zglBq1J8UubnkSzNc3khLSAMGT3TbPhc30uHZ7pGdPrbfvSOhnl
	 J+i8wudn0Pn/xq1a3yP3XVu3N9B6RGltAYI8DYrQXQSWEUGWkapR4dEF4ELVdEGT7qSr2
	 6VkZ7ajwYuLIzJL9T9UFqdoLS7moarX4/pyk3t0JPDzLo0k/vZOGgK/sxMGBbhoRX8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837616;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=EE+ZxZ11bOn6PDgXUu7s+7JAKoOJklP/SEl1SyhfFOs=;
	b=HMqF5KcpyIAxNkGi6rMZyRwEs8C9RA6lljqiXqxlNddXbtJ0QSt/S1/HRmhS1WzZn72h
	 /9rKzKwCwLROz470TI9KmYROoN4ZpWgdgautsa6fg0SOyfBQ/RCah+ha0p6wiEiRxgeGd
	 41eTdoWClQSA6xnynmMrL2U8CLOapEk9PepyuK+QiMOoHMG4LsWyY0z9tDqgCILQnr1bn
	 zXt6150fkML2OWMD39CaEZPsEJXD/E8TwWeCT4C1ilSaFgkCVXxnVvW/ARW9Vic2Pd9Bi
	 FoXIrjso13fT950zqqSPkLr6WXrMFg00vwF3rDWVmdpX4XPaEngtJLsrcpvyDPmulfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=OWNzIXAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05934606A32D;
	Thu,  5 Nov 2026 00:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05934606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=OWNzIXAr
ARC-Seal: i=1; a=rsa-sha256; t=1793837589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KN6sJivP+ulewEprS0Ie5syuGH1Wisk/n9PDxZp3/0D+HuWfsQ+UdoULduj4Or60hkChJ4jrJOEropVNNBzfZpxCijGZAyucwDML0eZh58EXVfPC+3tw5MIrrPmJt7N0k/JOiYvnNdJrambtDKGNqSO/lxMi+RTHWYn/NIU5HNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793837589; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EE+ZxZ11bOn6PDgXUu7s+7JAKoOJklP/SEl1SyhfFOs=; 
	b=VcRckM0to6DXtFFuX9fen0DQUoBRwSv1Hcroup4AUutZTG4UwuJTbK+EFC78PpExRb3vmTf6C26chREGkzw09rrexN1lVPUT5L1Dv9jSQGstjgx31Ywtk/mcwhZB50WOSLoXlQyTlARu6+N4KCzp8EuqQn2xB/paJ6J7Tol9z2M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=OWNzIXAr6AUirRbubqzv6Wg+bry4GBLXkUfFnLbI3J1bw1l6pkrMLdBZt6Gc7KpYe3wDSQdzwc95IA0Z8cbWD9+yqsr4SdHEZsoPpXGwGEgJ4DUxsYBF1OJHfbu0ttegLppY/z2VnJfeUNMQQsS4E8U60m+mDVTO4KKKNX2m9hA=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=EE+ZxZ11bOn6PDgXUu7s+7JAKoOJklP/SEl1SyhfFOs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793837589017224.5474271944463;
	Wed, 4 Nov 2026 16:13:09 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Yao Zi <me@ziyao.cc>,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Midgy BALON <midgy971@gmail.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Zhang <rmxpzlb@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kevin Hilman <khilman@linaro.org>,
	Caesar Wang <wxt@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Error and deferred probe fixes to Rockchip PM domain driver
Date: Thu,  5 Nov 2026 00:12:55 +0000
Message-ID: <20261105001257.1368266-1-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

These issues were found after I upgraded a RK3528 board to v7.3 kernel.
Here's a configuration that I used to reproduce both of these two
problems[1].

Thanks for your time and review.

[1]: https://gist.github.com/ziyao233/a5ee8862d1baf21ad756cf4e959e14c3

Yao Zi (2):
  pmdomain: rockchip: Only put clocks that have been successfully
    obtained
  pmdomain: rockchip: Don't log when of_clk_get() fails with
    -EPROBE_DEFER

 drivers/pmdomain/rockchip/pm-domains.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.56.0

