Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448609;
	b=1ljsLXZ69w6oC/QBFYHzPBYiCj720eQHeKnUPj/2pTmMntWAUBe0ynGYUQlMX1Whr+RN
	 maxpRMKUr/fIr07R92dKLPsy5tdY30if3Ww1TDS3DSiZRxDb9tPF1t0UDB6wQW/RXqwjW
	 m0tOIvG/OQFC+v1V2tr/+/zYcV505LK3JJ/opFEbTz4rh1jJR9zgdWNqR0wDznNeLTJoe
	 qQJ0dXzDSajqlcCjX8Ew5X4qWsWlRFQnJRVZXLr8Q/jFpQygi68vq5XuavNzGx2kElyGB
	 FjRdO4Jq3AZa/504nWrUxylFfphcWIvMWl1n91JDxMaP/jZ/M7WOozeZQaQh0zV/KZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=gPT6TS9j605VglnGPiOuyPIG9vvgHc+cnJP2+2bHGmo=;
	b=thGPaYepbwciv4oZCZDgck4zbJX8/fhguVjmrZ4+IQdW9lM2kx9GV3bnfdpGHG+HVDto
	 +IcdUKLnpj0/lYM2XTTNepGyUOiZSbSLmYn7CeB0Xg1bgyylGLqzIZBHVcQNtOy81Ss6Q
	 dRjhC/hCF9hGkNM1hA3IPXzxLs5Hk6kgHj3anbLmRJn4EtqFVmRpL+oDnNwuugIVR11j/
	 pP00CB3V6LmgMHjOT5JbtDkUvSHu7G9M0ss+t8QcET+3o9b529tjiragxbeLHXzWrcoF1
	 rwOLOOQWAUS+9IZUxZ4Eg6DtB//CZEpp5omyOy2YSYsMK2YWkX2QhR6rtCnrVi/ilwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a58PRzpa;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EC606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 01:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a58PRzpa
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1aefd1bf74aso341754c88.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 17:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794448608; x=1795053408; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gPT6TS9j605VglnGPiOuyPIG9vvgHc+cnJP2+2bHGmo=;
        b=a58PRzpahy8j9d1V9rko3LsARltx5Z7rj9JFjoNVm9dMGHRHjmNvF+YTZHf7EO5hfN
         uGQqY3W8u+Nb0OpnFdml/NsYlSG+IJi0G7W3+H91dsBUVQKcOr8bcGHGgiUCrgDUTpXq
         qsdiXL4+/vccbduOm+TahFvS/+e0qvusP8WpCjes98GyQkt6NPE/HbeOpD4f0JRfLC+8
         Yv//zMPFAx0PH0LHGVYQnMclpGmXUwD5oOoh2QPxpfF9RnB6OI/MlJ5omrICa4tEC0Kk
         5Ot7HAY5pNonp6oXTy6UrYRqctzK810u7R51Feu2ODIVCa9GxByGCSubTjDKsOMtbFo9
         qEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794448608; x=1795053408;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPT6TS9j605VglnGPiOuyPIG9vvgHc+cnJP2+2bHGmo=;
        b=zcuiPKO2T0QD3I+/olzewgm6ekDq2hRg+GfBzb4tRq8sq7iwIV8rQvq0PUdbdXUixb
         kgbB8DLFElkSVX+VfBHZH8I2IM2RnFyEWz+ZlUXDPjvbejUBN3snRMy1hrRcRMjWdPa0
         i1dutzJ7vaG+Oa66gt86Rzra/RbdTar035848RqPE0TGIrrovkRWdkqJPVOFxs9bUQot
         Od4u1PDEqBLTFQR2ZQUKoUX+NxVFrjlGAkvz2PElkwRqovayUXi2GRFQKqtk5be4Wedj
         JBioMm8NhcxvBHbd+VaYT6S2WLq45DP62GJtmwutG5oUSIVtzlFEdIcoSS4JeLLxAJZf
         zzAg==
X-Forwarded-Encrypted: i=1; AL+hErE94UgINTPyRkhsvDsg2WBhlYwn0wIrrx7Qtveq4XWf4SY0prhluyBB2n3O2mHyKKO/JOWJmuZHww==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Wz1K4G51ac7sTLGgoCKPhHyonzspRp1yl6yqcprrBTV4b4fXN
	gCMRKn6BYp15pz8easPgvI4ScQTnRps0V7vaS3OJSdx6mYfc6Xgdr5U9
X-Gm-Gg: AYBFou2b8IeXvl1hJNrbh9SdCKGMdzsGwDhvQqDBLYe2/+f8tFQ/9IgdKh3+e2xsa98
	5viUKkfpUmNX4jlhMCg8R8HcBQRsnSQWTXyVYQBms+yyGO1AuAJs8eqK2RwLgXiC5dxmyhlqZLR
	zMubMKU767MvY2L425XwtLPzTu8U8SPE0u4Lx2U2zZTxVrHJ24iXuBDDsj/Wwo6TmznhZ6sL9DW
	gbbg4wGT0qM67OcGuDAEQ6vSXL4YuqxfU2eECcZNo+WkXXmYO9itf+G8DgomH+X/E5IG2isoWPU
	WQ8Q8FS3Pcf9PKBhQLxyoqkOjT29iV1fmKmtbJgC/tNGcoSa/rrSbYjxUlgdInRYVgdl/966USu
	d73GoGjxU20swu1oRQJmU//FmqWhu+KDzSghL9+aGE7WYa9jhM5LsHOcUMadfvu3kM3vNQ70L/P
	XLbpVYyZToilggziLODQGErq1UeCPYNg47pQpHwRKQZ6Dk6sDDbCK7kNjUjTnbznw8UxSMaH5vC
	tDTBVCp/7qHpQRakXoupNUrIJBoGLJWEW+f1xFujqwZODenQ4a9s3JqnvGv50IPOXBp7zXQwJ0Z
	ftU22qCZ+GlOO75OzfEJbgvf6day93720UCm0DaXEKIycgZKkz8yek17RV6sYo5kapf+Dm7PVC0
	5WsIZvC91y3TB2OJIYuJfW3RcVVaOQ1tFS1WA9KuKqIIdCQ==
X-Received: by 2002:a05:701b:4194:20b0:1a7:77ae:11f6 with SMTP id a92af1059eb24-1b4f5eb005cmr1104575c88.17.1794448608114;
        Wed, 11 Nov 2026 17:56:48 -0800 (PST)
Received: from [127.0.1.1] ([2602:feda:30:cafe:ec49:29ac:0:1866])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm21032435c88.9.2026.11.11.17.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:56:47 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: sebastian.reichel@collabora.com
Cc: johannes.goede@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] power: supply: bq24190: stop IRQ and work before supply removal
Date: Thu, 12 Nov 2026 09:56:38 +0800
Message-ID: <20261112020000.1002.yaohan@gmail.com>
In-Reply-To: <avEajWe1iAH-Trhr@venus>
References:
 <179378567491.72692.9015711605062239156@gmail.com> <avEajWe1iAH-Trhr@venus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Sebastian,

Thanks for the suggestion. I see what you mean about fixing the resource life=
time from the probe side rather than manually freeing the managed IRQ in remo=
ve.

I'll rework the power supply registration and runtime PM cleanup so the resou=
rces are released in the right order. I'll also check the delayed work path a=
nd the probe error cases before posting v2.

Thanks,
Yaohan
