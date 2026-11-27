Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809788;
	b=Lvy2raQlDpGG7uWXQK9nztd1fGXF9zkxsUcsRR6sKm3851G1TgmEEJY01AI/GwxbwfXH
	 JTtgeOwIjryyfi/weXL+RPMGdt72GAs6U2bwIHOh00Ux4mqHLtA6z/eSCFNS/PJmjVB9i
	 U6paLMVU39bZB2l9cmvauRZ248NGxSGxRaQX8fs7QIFni3lmj3XgsoO5qhExwWS5FHC/t
	 H4uOutzl+8wEeJlY0HnbUIIOeUJx4OLNFC5sKmt3tLEliMcKZKkpGJvXzVkPTtROgjDWS
	 YVkJlq/5Al3wUKcHfJU6dMYF1dfBY/TQe73C0CE720cnDd0SFGYqTVTdTwY/oiU3CbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
	b=mzfuO9qWk0aNyAXw1jk7sV1N6RsUC7AdtvfodXf4BgEWDLoSTuGYjt8K8hXY8Aqgd3SE
	 MXFEb41viiUeU+M4hF4Ma+CkXafpmiY4t2D2+alUtPLcWpG3fqnUZKbCwhIlq1ny373yG
	 LLphxr+XaEFT0qfPyDctF6C+nd+LOx/dX/NAb2ByaSxsQxst3j7QnYwHTiGv/Pd8wpZO+
	 /BNKLktUiC66+3O3w+TjE6FCVo+YjCQ9RtDBhvHzsC9FulZ8j4XgdVW/s9EwyzwB2at0d
	 fSWtIw8ZFPuFFau6T8nXKu2YwyrjLmOiagiOVsnA7L7pLmhhAtHu90Ln02MC0eIDTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n2R6FiKp;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF42606A32C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 20:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EF42606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n2R6FiKp
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so1066967266b.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795809787; x=1796414587; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
        b=n2R6FiKpuo8g8obEOm2WV36wL4nr03F4a4p5Nyd0b2wdtPQbbdxheWIYRfJxzmZb3+
         O2uuDZi0uiaRR82uvCRPvAceWhP6zDVXz1OoocXKjcgBdfGYu5+22YfyBooVCoPKn0vb
         r3D8qlvSHEZrhAGWsfmzXQbzDcPYrHAIRTqsZ8RA+mGo9ottqiGedVNrCrZjIfpbMUbK
         daqNU1T6ZxAeN6QzRxvkmpuSn/9lf6SmQK+ByQ8IC8jIHeNICeMgIr5qlFtzEkXyQDnP
         aumrrQUn8yPuqlr1pakQcTxfinAX7L31iaQpgA14Yqa4x1BmedsGkQVWOQm/ejRHzr28
         OTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795809787; x=1796414587;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtusPwl7oTxkglScGF7WcIoLENdcCkcXrxudV6XyW/M=;
        b=JrKKCvPRDQQitGwvKxc5ct9IG6pxfgmjbro+A7wcVftwZR2nSsBuoeOAgBUHpYhPy4
         QNgVoI7NSmh8FPt9qBdbKoZS9SB0JnjGRghdfZBLVY2gfUoJSkYlUJJPgbFqSvtKn+Bz
         0HSos8NtxM84rwnlRsAzbmP2WR9+x+Oe7IqS+rkaiqrHt7p03JLrsr9P4SQO0d6APtAJ
         ajYfPgF8EtEFujQShCnNqewTtzFh1M/b09hcUDY6gFsoMIRVpp9yTAnorYUqzlJw/1cC
         QJqaW6tWnNcNcCpqA4fSLpXr3x6N0YVDyjvI4HlZf7qWkXnI50IIG4ByUdUSTvwAgyct
         Ckew==
X-Forwarded-Encrypted: i=1; AL+hErGZYPTMXCQyPspHK4WfV3OtoKhOsGhdHcIpz2+ZYCEnacfF/PDBA8Jpgi0rkSfH248uwFht8ooqYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DtxU0VLDGZdbZ2Vu83VZhhTBEBQ4xJfnqduHsLNYCErzS1Q5S
	dMAT2sj7k7LPxS9eiHinJqJgfD6zN548HBiKNVF9lauqPf1yJfMewI5oGbawgAQd5hc=
X-Gm-Gg: AZFdTZekruDdP0M37nLWITdkfpnUc0tagVreMdHLsCNwuhbbpQOhcr91wYEKr0rvPS4
	yZf3d6vfKpQh6dUy4dNGkM/oa4AQNJ/MaLJ3P1md5L4h4TA999Qhys73pc3m6VQ9ReiNc7lEdA+
	kwEHB5LMQs6Fn8ipiXv7RDHjqu1sGoU1R/gpoYagOSlEM0s/B/dATiZXYjLZibpSPv9rpLq/0fP
	Ko8NDyI4dbxIWnXCiY/79ng5k+zac8/EfYUKkVAKPrt58DUsqJD9XNduliKcVCamAmlhbBA0TlN
	N0OgKUktV+e173ZVaMJxXAMcMgDC8WfJD1gublES+SKZjBsuPNA7eBacG8sRwxy35BGt9nkKOkx
	LKem31QqG0ZR3U4yiwS/LWZNpzbryYFUBApUX5AkNJtX3IcvDoXj6izGkX36lmCtO5E5j4IX/4f
	RlliWoTadUdfjuD55on5J9UTWZN8iIjGyOrgux2gMMpQJx7R/CtWjdmp5ZB3hHUgQViDpQTTZqE
	Nt21lZorJsZY/yhF6elWdtaH3HJ+Gim2CJ8GLwITewev8Glj4wOQ02ZUvXpEch2PIxdTxFjnGpR
	VhHmFBRb5RfaXBT7/eaCfBd2ZN2Sx8BtdkRTNPDwny9GHT8a
X-Received: by 2002:a17:906:5908:b0:c3f:d8f2:f08e with SMTP id a640c23a62f3a-c513aad1aa7mr1591096666b.44.1795809786817;
        Fri, 27 Nov 2026 12:03:06 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae661b3sm897861366b.16.2026.11.27.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:03:06 -0800 (PST)
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
Subject: Re: [PATCH 2/6] clk: Add dev_clk_get_from_provider()
From: Jerome Brunet <jbrunet@baylibre.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <7155949aea78042fd399da5ad23a72765b2b6cc7.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977969.3028968.47907747276860033.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=576; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=w+BoHiPo+P6YGPZSkRwTWt/kGI08hfYqlVrPoLWDzrs=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD781zBdazCsg9lL/zber23mznz9vt33xqqNRSyql5
 9/lP4XqHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZjIejtGhnPrDj/t/PYpMF4p
 5/BazfN3D21QT/A6eNT9yBfJZ1dZop8wMpzYzS/A8uDOTLmdR+uChb9oSs6TL/Rb7JC9947joo3
 LLnMBAA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On Thu, 19 Nov 2026 14:40:35 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Clocks obtained through of_clk_get_from_provider() show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> Add a new variant dev_clk_get_from_provider() that also takes a consumer
> device, so callers can provide it, and consumer's name will be shown in
> the clk_summary output.
> 
> Reimplement of_clk_get_from_provider() on top of
> dev_clk_get_from_provider().
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

