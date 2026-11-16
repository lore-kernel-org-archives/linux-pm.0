Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865052;
	b=2TwlWlrRVmbKfi902rzJBrL0pCoqd4ZSnVBNixgI6KbvrQNMbKd8wwhCMHYl1SQ0fq8X
	 NZERHBu+zAUv9BfRVHLmr89S3b0gxB7SkE6MLqYwWHWAUzQqVpqn5sLNaxCdOWtwGdBBt
	 Vq02lR1HhpEWaD4oW9vyPZqv3rAS6ZiQER+bhpa7pSZZSlg4Lmh5Z5J3kxeJ98WVizhiG
	 Sk+whyHsUC1Aauvj8SgQcQ9d8LgwGUrF8g125FcJe+wTeWuMPdA0Su6AwV0JSZwCgqege
	 jF5VFG18Xz6f1thR7EGT+cK8IqEoxTe+fvrGZhI/DYf4mp0Ny/Y9KydwMslrEplag4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V/CIlexh+3dIbJj+uNeGrZODUMiRED+GiA9HD8bfoMA=;
	b=NReM/Ap0nepVFLyun1XyWcW9fgSYqZxKLVYklKxq6RypqvTJHL+jnb0TIVc6TEUjbDmb
	 DansbnWqK+48MqtGdtaz8ptZBQKXfbTCJtYPGtc7NS8MrTsBI8tBsqE7mEgBympXztxvg
	 mZx3NQehLcGJkQbxkSE6361fQJHb+kPvGNyv0v4I0inLLFWpEsMOSpaKN4DdsVlPPg2wE
	 KQEbqkDqss20Xm4Sg4CA1PlwLN1HgvkjTPnTanB+0UmnB+jr8h5krP5Uw6AQyDSmyttrz
	 XyrRRmWoB7CmVT/MGjJ3p51QBzvyfmjUFz6Q3a7Q34+vuDNl9VwRRvXGL3GT3nQZ38w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptrvNQMv;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF9606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CF9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ptrvNQMv
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so25214355e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865051; x=1795469851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/CIlexh+3dIbJj+uNeGrZODUMiRED+GiA9HD8bfoMA=;
        b=ptrvNQMvZGrDGdeRfZ7P/5XmtzRi3+skDCRNqe3eKv7RaDd6Px0lOlXBfXoXIPk6ar
         0YwYpsbidhWdqnfgy48BeWCNSb/vl7QlwrJKBPxuQRGtNHefKMLMVOyClKOYTWkpnQaD
         H+DQ9MVm2XoFQqcWczODgyK7hgRWffk6+5xEPPmve6FV6tMePnKAUBfirKfx0gvpVkd9
         ogFSv4rMz1RhVDyJ8FmPjUM5/S73uz0hqY7Bh2oa1r/jWX3GIUlLSlHQ1Q03tVGQN/Iw
         0wPvxlpMgYX/dWRH0uh+Iz1p3BWaKqy5vSIcO2o/H6uZKoYY6+qKQuFTykeXO1CwuiV5
         vlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865051; x=1795469851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/CIlexh+3dIbJj+uNeGrZODUMiRED+GiA9HD8bfoMA=;
        b=Y9EtZ93oSveDTXsGywE+QIrIvlrI8F9u+6L+3q7p6jdRywzicVGl0Kl3lmRqxsuAKc
         NAykodlyuXGlj2HPJbD+AzcafFTV3t5y7DubsYiDQUzk3av/TfFfcdQKw2PF0ZrzBziR
         2qh1DxUG60fCF0miJnNkptr9oEqbf8IYVo9Rmppe+Fxp2iK2EXuaxmA69bhgYrCRS8Ms
         nB06tNsTd9T1GrD4XcR9QkREhLIJcoSneDBL0jDfoPj3rcgphvBBvhlm4hTYDfq7gJS4
         MTA0GuNQD3MC1FA3KNlhE8gv+m2QjhM1d4NSD3H9Jx8+pZlDIJkcNOrEW/6gGKqCBnzl
         xs+w==
X-Forwarded-Encrypted: i=1; AL+hErHdhX9/VDy0dPpwK0qjRAt69xmYRnrl/DQPuh3QKC6hQQ2KqHs4GxISnH43HyAF/i5Jh1xs3yQVbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8GERjlr2Y2Kt6L8iXDLHprHMj303dsEgZDCsx5bUZAimNaFha
	bN+tT8z4/0h0IQrlkUN/A82dDQ0qri3c2nkgsIXqU8q31li0YYN6R7Ob89mEtD3cpP7UqQ==
X-Gm-Gg: AYBFou3v+MvfR4CuCgLfdQ7OKDCVX0UQRBSe60UqtVM+iPSKkHnlAcgU8a3Jin4upfw
	v69ADf7un2dFBL45Q/yPd0RV5oZdIgTaiV4sJEvbt8cF00kDrE+rE4CR5Tb+JWlqxzz3CzgKvEu
	Xtb9WOloEAQlqKiWgfrZI5ROKP7z4G3I6CNv3eWXpUL64GgeLoN917yyLKdTu4GG0iw36hbmBWY
	qRCgaCTt6v+4e/DhKJ1Ve6DAmIza/Db4sOcIQpbCTER+282vytpzrhiA+jqz/k3Ffw1Nip/8Yzi
	MIAurKfpb23v6bNXxjFqpa0AWoNPFWfdLjg4W/ID43Q5dPV6OJu2YFkZ5Sfa2gBCpfKZFqUbwAO
	rE2YPCf62rU9PrldN5BWfiFAEHf8DTOIFdsGcXH1diYSZEzgbVGWNzBgPTz+lBp1ETNycQgrbu1
	kwD0S9X6v62ShD8Jpz4t8A1zEa0GGoU0TxFseUO7usMrvdqGPjaK2QBpdH0PnMj/w8oeP/2rAr4
	KRT9ytjj4JFcKlqQhMF1/zj4U9UHOWLhT15fZqhInotWd8meUItJ/gZ38aPSl4FXD57JcbiOcN2
	av0ipQuCCpjoCgapnFiOIGQYYHAn
X-Received: by 2002:a7b:c00d:0:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4bb55a8a57dmr187933905e9.35.1794865050987;
        Mon, 16 Nov 2026 13:37:30 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb675200e4sm143331635e9.0.2026.11.16.13.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:37:30 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: dt-platdev: Add Halliday to blocklist
Date: Mon, 16 Nov 2026 21:37:03 +0000
Message-ID: <20261116213703.3774089-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <sashiko-outbox-217729@kernel.org>
References: <sashiko-outbox-217729@kernel.org>
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

On 16/11/2026 21:32, sashiko-bot@kernel.org wrote:
> Should "qcom,halliday" be documented in
> Documentation/devicetree/bindings/arm/qcom.yaml before adding it to
> blocklist[]?

It is documented in the DT series:
https://lore.kernel.org/r/20261116-halliday-dts-v2-12-2c92438c6c46@gmail.com

Stanislav
