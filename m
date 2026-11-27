Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809787;
	b=x8dvEXNk+DUKh8HX+solWuHkPgjBUgs9beV2oOAmZAU3fmvrjjBeccclNMVo7Y6XQj9j
	 Vquccxh2Vu7W5vKuCY8w4vwVxH/br0WgtlGAOSBIPNBTv5DaMcRocl/UA3i1O2tyq1q2v
	 n72huh57OpaQ4qzh2DL3+w/2NwCDTbV6+mm+HxU45i9OmVjWRydlGOUToGj/Qg/8EqkSe
	 EoqVAPinFevbBw5CcIaJOBAwruSpk9rScTFj5Z7CTcwxaGDFdDXvNMXtv20tkctRbPlUw
	 bkARiKPHZSrMtIx38GTUfq12WW+dlsohKfRZEfLd/VbErTm/fzwEINPs6ygjFfd1+yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
	b=SjJJ7PxmLCbW2i7CrPryJU4G7P6pZSmcro5NwhTtJ+kpZUWWBijQzX03CeF5ljvWtFOX
	 mREhqFvhqLsfqMLsMeW0ZhNNVH4/0DfiP/MS/tm0X2QrlaGenqV4UKt7dX4mtaU19A6GW
	 kskjyMMQ7MoU+ZjSs+43lrVRfYJBufkwyL3bY97h5qqrCakL7XC26IpZtfdiLJ9hlkGp7
	 opY2eOzxGZB+Fi5teo4QXuAKnIojGMlpACweJgLTkkWoF7zFlM4vXWO4VqsaEYqKN8Jg9
	 8myaMn9tJPGPpgh3y/Aq6MhQTaWzbP8hTJ4QRLfc7pLLCWh/x1uGgHDykUv/PLMLPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USVugUGJ;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173E606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 20:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6173E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USVugUGJ
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6bab10842f8so9959514a12.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795809785; x=1796414585; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
        b=USVugUGJ0OGFei1oWOv3ixK8kXmdxW89ohPqYbYPFavNwb4jr4xK/cCB4y9hnjKBRM
         aMOvkgqxflag6ZhfKgZn6Crc/Q0pKn6tBIJr46jAuxAaLmM6loQMdtPdlzh1ApFcCcIo
         B9aE8+dPxpxuHlLdrD194YCNFEvbZV3F+cl0P53tTPOcbIF6UF8cTL4S14CNVv4DUmuA
         AEgFaEREQj2bq+B/IQqtj2BIkyBdW4uRS3Y7P0eYNo5+b5iJKu53Sp17WIb/C/drqg3q
         +O8oCjm7LKaIgd6H5wW5LXl6/Pd9/2GoHH9kdvrEAwaYwOXV+667Uk+wJ1cWl86UfOSi
         Xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795809785; x=1796414585;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/E3JJyk32BLVSmJPSu88QD4Xx3KecbTtSFMtKZvIaA=;
        b=CfElkY3OjH+F9cvTqmFARzP3u4CRDLdti/853dxUkD3k+MS9DxXOUi/dP3HeqIj5gh
         KjlaW23TnvrGsmTncg4IIpBRRlyi17sYZ/mNdCkr+1suJKkkqCiVC+fnXlOXBnU2MfQ/
         7l5xBrALuMYxv0UDKL1c2JMIq2yt5hVlRPe607+hjGqA0FSzKkSjQkhZ6SDDt/RfFgLE
         3jlQz2LzT1zMWAZte5mv6+1YVucAbXbU/KIHnLG8RquQUAZKl3wTfNtyxT3TknemnvGc
         Jk5Imj+Nt5idhDJNFdca61DAbTQO7P5fIZ0D7vy6a/D7rg3Cocscatakc4snfdSJ2/Ri
         WatA==
X-Forwarded-Encrypted: i=1; AL+hErHYj1bOt2lynXuLWKjYVZss1Y+3NIzGFeaF72+amlFEI87v97ckFSHQ4HktOtU/pttb/NCpK8hdjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jse8VRpFxFJv+BX4008xQJdNg1jb4VP53wpV0ycu3IpiKboFX
	5rTWEkfUVPsaRNzS0rOrgBS8qMRAxtYH6jWAJc7/RbkXdpsPtVN9nizExxG2NhGaNwc=
X-Gm-Gg: AZFdTZcDJea+NlDyf7d1aLJw9XvNfIEFJrbZuMYmzE3Zku+Eux+KEFy/8lZpM1I/7T1
	/taJACEtVeURix4QYQdCs4rtgiqdoQpprn+d2j/bS7AlkDTH28EXvW4bpPCu0D8/dN1FxFq+8s2
	i7l1ZYjc2zkG3smKH1ZMwO4AFIlIb0UuQmxQEIxxc4V5TDE4wYZ02w0M78bFmWL4dkw0DmLYwD0
	N72kjkDLcnooV1VTpAaYCqWFIPrZ2UoN9xbX5TX7Xpor/XIZJqUC3eoHK6vluSc4ouj8/v7V+Zk
	PAf+qOvCIA/5gAtDnvslmDQToT8LeW9c9TvBaLufc3qDGCn4FLMWk+Ud+CudrhIPQjp+8RAXcMS
	eAzeOf5W2x49JIiF4JgxRJCISiAqlHUF2ThgzoV+8CRAsrem5x8zHWFrmFsBwafP6evJ7YVhgYu
	aGc4TJRqrKeeIJ67Qsx2qVyYb3Rx4v6m9dLBlCV7pC3yfIjCsMR3iITWLqjiD4Bca+QP6CbAwhf
	F/KQXCDtGKymX/bDIx1rIQ/2d9gbfJ6UF1i1im1K070YRmqTnhXN8nYBKkiOnEv3WUV8NX3Xg/R
	X3+fULb5xJ8eyIAbKUUchjQzt0bXN6s/ddCwOwEWT8uyimum
X-Received: by 2002:aa7:d402:0:b0:6a9:8863:ada4 with SMTP id 4fb4d7f45d1cf-6ba1fae103fmr14763271a12.3.1795809784883;
        Fri, 27 Nov 2026 12:03:04 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba6f8fa5b9sm9906969a12.37.2026.11.27.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:03:03 -0800 (PST)
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
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
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
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
Date: Fri, 27 Nov 2026 21:02:59 +0100
Message-Id: <179580977968.3028968.220600254133838233.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=438; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=1x7I9OxtWjxbS+wEVDFGimHZA2zKBIWqfRJtzMCbXkE=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNmcD7/5dtokM+ZkaTF6K2ZGVttk1rMrH2fK8un5tvb9D
 fstDRc7SlkYxLgYZMUUWWq4q8XfSWp9mTVd5zbMHFYmkCEMXJwCMJH4Q4wMmxfdaay4eymZS6GK
 Z55007ypBev3ur2PCN636eTcxxoMGYwMv2pstwfXV9w7/0GsKypkd/dKC/bAd4cr1ViY1xxhVqj
 nAgA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On Thu, 19 Nov 2026 14:40:34 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> [...]

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

-- 
Jerome

