Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601902;
	b=erPoGK2t27IbCXU0Li43TWjHuLwQPOexOgTJqTEY2uQGYGoRJ9ig/tr6GiIof80s77xG
	 F3C443u6RMhSviJzcPXWUeRz6wl1tYPS4JE4kcxks3dKP0V0U3g8DP0A2PiYnrRGzHvaS
	 oMEJVX5sgIVSXAvYldF1YEO1a5S1XDqisK7Z95sPzpvS5oMLX8tkhYKVBC01sxbq8uN5n
	 ucN1p2oT9MfUlLymTENK8y9w+MKP282+g2jFTugJd2qn2vlx3AdV5G13toxwCF3/i8SZG
	 7FM3qPxAt6yn2ldA+IXdFhYX4uam9IN8WYIho6ri7HZjI+EEMD+8ejnkrts13JutEBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=YiZ77gIfuRvrG4OhaqVJrXWfgW4P+h0z/eTCC1VVgzo=;
	b=JrT8OgOXnWTWHUTFRsZ6TodCxwHNVxalwmquOijf7XBAimll4WQsRgOjQ1o4tS7BU7LL
	 RIGVVdBruWRTuNseW7tdatBW6Ue37DGG6gOS2Hdjds1OmVnsZ3s6Q84aWNmTDSg4cyyAz
	 okUBpMYEahhaeKNZ2UMWpe03tfSZ3WgXHtala8MnzuDtkBjOpbOoV03+hi1+JaTbS+GAT
	 ah5E5p0qiYZrY66H2LKY7sSJp9ttubJS3hhyrtn+c/r8xKTdTqKAMKY+rDW9N7tk8HvPZ
	 2879ynOEr+MXzcfQUv0694zjvdYtmLk9wieglsbTNOGeE1duNV2oRZB/ljkj7whC92w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eqIt7jX;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B1606A32E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 20:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3B1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0eqIt7jX
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0b8b5d28cso174155a91.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601901; x=1795206701; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YiZ77gIfuRvrG4OhaqVJrXWfgW4P+h0z/eTCC1VVgzo=;
        b=0eqIt7jXVqDpxvabrVe0KQBlX7BnF53VF/MF1sBMtS1BWLZtZcTYCrhX9bVfHRiKQm
         z9wQpmxs2sofJeTIcAY18T6FhFvLh3qN7tC57AgNBI5drGp/OOR2e9mhM3IKgL5lRjJa
         95vB8WZsBSjGP8fnKSJrqC0uCLGMdk9PYBRFIorS3oIBol7UNRrhAuSMCKKIxRVO7R14
         N1gxW+i630qYTk91T1x8kMq4q1/GZ/gTS6qS8wtzRSNYA1Q44/Gwdo/Dx6A46e+GABFX
         FygH8wTF3JWBT/Zjhdd8yuPK+Jtay6GrY5BpNjqKb8aOAkf83KKSaMQyF1kMZeS8jt/m
         H0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601901; x=1795206701;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YiZ77gIfuRvrG4OhaqVJrXWfgW4P+h0z/eTCC1VVgzo=;
        b=jSXH9mEg5luGZiMWi5BRo0At9CmIT62ngWHEcI4p4pnXt+ksuaWC0ZaLt+4n8HY9oB
         F4ct2xobrLrS0/6UxFf6nGdtPvk4V+E763DMWT+DovwpFvzIereOhpb1LHf6sbxgJQx3
         JjS+lNWn+6szmrcJSIi+rQNNPtL951UKjUnF0oNMhfb9bbFduXMmbTK7f+HJP23hELpS
         nPmSJx7cJksBlLuOMw0uK1l+FGb6e8hgVeiSQhhG51zA2FjCBzxrEs7Z/Xune2DRuqLH
         NomOsNj1hrVeYJ/bhjfzukK3sw8MAkIIFMoDmzR6ZgPBKliXUJxEetvkFrQVK1+NHzK6
         Jm4w==
X-Forwarded-Encrypted: i=1; AL+hErEmG6xGc7arOPRS7TYtmuZ+XI38YztJFUv/MYf8k8WD4cGlPMGtBaVIYCNKjc1ahsb/PqPWTLFnEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Swjn8GRZ2XMT5dabDhWFEMXkyvCk53L4yuY0d/cTPSlmlevwZ
	N0fGNEHTWR+neXP4rUbt4TFpFzkfp5eYvk36l29gPUyhweBhsRu/qyXn
X-Gm-Gg: AYBFou24EeQWkwNXk/F6ieCjykZnlWJSbZNBki9f2mcWgGt2hQf4WixOWcDMRwXwMso
	T1bKCn0lKJO1Z2J+DMZ0GZJFIt5CEP8Ul2SgCMEdsae0555vl0gg8vGC+6ssITphkvS+c0XdlWW
	Y276wBD4LzKed6w4EQ5l6ShodbB8B9uG2+t843zmENjlg6xm51knR9kwfvvKwdG/f4WGNi0Pgcn
	9gIvkdshm/3BkZnVAollm6tIcI70DNux+jBP0hUzoYYBP+nC5uzL4/3UIHS4WDyt5hjjiMD3Ys4
	RsqYcFYnADyht+cI4K02EnYfnk876zURn5Y/PAZn8rINd4EXxkeBxSd93/qrEwWP+YLHrVjcwKp
	81WoKgnjJC9BAP3RVaSgPPUwUpYpSjj8Bc1KMmLQUx/1LI/5AMyXvYa6UPkSUcmAk5Xt/7S5pBP
	OFQwDSZhvtMMILLUa99IQc62u1cRao0wtEFfhbP+C9+t72wnbZNwWUsyvhg4SmpdZ3Bo4UqT0aT
	8tPPI/OYdMw0lgs2FFn54PJK5Jk6ugJ3hwvx/5N/ejuRdKSn+3YMzW24VDZwjvcasaOswreS9GQ
	ePjWVLE7wc/KBlNqNT+h8IAfqliu+bb3DHmOicdwmr3ncpAiy8xqW5sm/34pox2/e/0kCY4ZOQk
	Jj/Nv4w==
X-Received: by 2002:a17:90b:590e:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3b1b0b85d16mr5379769a91.4.1794601901202;
        Fri, 13 Nov 2026 12:31:41 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm11051461a91.16.2026.11.13.12.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:31:40 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Saravana Kannan <saravanak@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] driver core: fw_devlink: Don't report refused
 sync_state-only links as errors
In-Reply-To: <20261110-fw-devlink-sync-state-v1-1-6385be961c2b@gmail.com>
References: <20261110-fw-devlink-sync-state-v1-1-6385be961c2b@gmail.com>
Date: Fri, 13 Nov 2026 20:31:39 -0000
Message-ID: <179460189995.183918.12921536578133287930@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

+Cc Saravana, Sebastian, Ulf, linux-pm.

This message was explained before, and I should have cited it:
https://lore.kernel.org/all/aixze8zFboY3huSf@venus/
Sebastian writes there that it comes from one power-controller device
providing all Rockchip power domains, and that it is not harmless: the
kernel misses dependency information. So "harmless" in my commit
message is wrong; the patch does not fix that, it only lowers the log
level. It also lowers it for every other failure to create a
sync_state-only link (found by the Sashiko review), which it should
not. One such case is being fixed at its cause: on RK3576, Sebastian's
"clk: rockchip: rk3576: create proper platform device" removes the
lines for power domains with a clock phandle:
https://lore.kernel.org/all/20261112-rk3576-clk-platform-device-v1-1-2f3ac9f09403@collabora.com/

Please drop this patch.

Arun
