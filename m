Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660910;
	b=YQ+FCvLAbK4SazyMoTPBbVjq2UeQQpeyOyowVcDo//gu3shw9hLreB9Pc4cUwixAqrkO
	 BT+wIZAMMwlsEsEs+bhaYVLebdAW/k+gs34WohuOzpPDN1SJTY3+9ZyAUbngrMCvoSbiH
	 HNDMvl269LMNBCBNampJdhNb4S1q83ZZKh8Sc0pftYnEiegGajdwNfZv41JiKcQynN2cg
	 Tl5xj0Ak2cgqszXL376MwHOwULgGKK5wg5Mdql9ciB3bteQs7B7CK8osItVWNgQ471Knr
	 WDVn4DUATC+iuaYaVUYBpTz+t42Jk84m7d3hvhSAllAZuXC1KKZmF/yYDo5KJDQVZSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RIAjwWAB/1kSNYGnZwFAsdhypWK0Kwmt4wTEOFin5Vs=;
	b=Pjwczvhfmhn6b/C98aQcPwysr+4ltSBDtRYvyqRL9Io+/i9BjNsqdRvP38HzrCNVTlkQ
	 29HBlzBrT39GPIqh5CIjeiwixobEidqXqSUkT806t4M/z8Lfl/e1nA7hutZ6krWxMinif
	 2hDcMVQiOCpwk0QBmy0sstlh6gA9dzHBhxVXXE+aszUVxD8hAsKSs/FEt60o7CkG/eC46
	 IVNABjArQIbOpIoBBxq0P6hF/FOeREftb0iu8k2/wYmtggNvHwRejD+5UT5MC0LExyp7h
	 bLOdkWX4p360//k2Oz7sKS+p1zSAoljhUGSIlcBopGv42OtBondi9BM/G/8USS/Kkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=furiosa.ai;
	spf=none smtp.mailfrom=furiosa.ai;
	dkim=pass header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b="PJ3Q6Ow/";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B58606A32D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 12:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B58606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=PJ3Q6Ow/
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36f6295304dso1639024eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1794660909; x=1795265709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIAjwWAB/1kSNYGnZwFAsdhypWK0Kwmt4wTEOFin5Vs=;
        b=PJ3Q6Ow/yGYfFa7Vm+cSR4ycIax/mRn1SybqO76yWhPktwr8NBG0e+5alDCSfdnWUR
         rQlyYxmqLAZnSeJnfPLTknFFvvXuODjEWtE5LwD61dVRfEUhyhK09njJoCIed8hviEms
         35g8877IO3ATyTgwYEavO9vOyg+fuZkp4KOdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660909; x=1795265709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIAjwWAB/1kSNYGnZwFAsdhypWK0Kwmt4wTEOFin5Vs=;
        b=gMXttbDjbakfEG2j3AwVA0ZdtofHOJBc0xc5QPYV7HQX1b126xeDX1Tpf7KPXpt0zU
         2H0HsdQnwJ0z98KFtA93Xi5sEYbsbi5VIheFJS74unEOGnqXi+WApmr5qcteQ+CU/AuP
         yP00c7b2jxp/6cos+q21mrll58iQX2kk8WaysbYOZIKlRKYyYs1a28FW7in7N+a2XkYo
         EbyIJekG0qi670gCRPfGyiK5L/7DDuM1lDPRLbDgYWdAbs00GIyzt2cdZHXQzqrOV3Bo
         5kI3/sLCliqsRwKAla2AE2wcYPLCjKb35MEPkQI8hK9AEggRil6Z3XK1PRxDYvOjc6rM
         5fcQ==
X-Forwarded-Encrypted: i=1; AL+hErFjFahMZF48BlS5iUzYpJ8zwxrVdDYtK8P89AgGBxFq8Dy132u0x7Sjvg4r2uQUQ9Gw5vVzOzTDfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/sv21L3u6hPgGZy52gi7BDlIK72li+0oFJVzhuRRi4h7m4a0ij
	zWKV8QMZyMQxg2+CNugiV0Ipe/OqH+aICCJVInuEPToXLBk7jSzq0poXcxm7HX+Ji/aK793Sky9
	/2BqP81w=
X-Gm-Gg: AYBFou0zB4E3fnweFpxApr5VqYEKxdxBH2MkVvulunpMNoI3H5j//Ba7W/lmOc/NgX7
	biMh/TNrfBeinOiae5FwSEykF6r7EqkEl1PXHJ8tMZ0ti6znNbaF34KrkUpJjrB8VosS7ROc9mM
	vd+PST5vMkOgEn2fsjKsOK/V3lxDZxaQF2CPK8sYPIp30cOmQfTi9UBmNmHFNYH2uHsfg5C5dqr
	uV3G59hKXoiFpu/e+w33i2LnvsNwV3vdy9teaj42Ai20e8YUxRkul/ejOt18dcg3uWFl5o0LMwa
	LPzZdoQ76xKeRqaIbiGqCAM8HXzmTyd++C6HEYlE2TZ00pL7qsOulMY4Vxn4RnSggtRbB3FYGS0
	h+/Hynk87v3kn8pV0eh66QomHBwZ8cN0SQVDbVCTpiAXkUwdflGpk3LtcdoyULMViJJAof+6UVy
	GK0PXVV7f0Dx/PeY/+13gYvPMSmxcKYRB9WyLQs4i9onuManqESf5dQ8BlH2K5fxVpcNN/Deooy
	V+yR/mlkVoT5OiujFy+xsmUdNtuazc5oRS31ieAvg4yau3h5ieUJx7uj33d+Sc5mmbfCfrQt5lV
	K8++LaU76YoWiLuAvkpZsOfkuzNxaBRtdmfUXsGeyLNrxX85rFtSh0e0zA0UISE4Rvmf/o3tX8x
	KEqfKML6sWNJe
X-Received: by 2002:a05:7301:1528:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-37966d4077dmr4508914eec.26.1794660909271;
        Sat, 14 Nov 2026 04:55:09 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm15904809eec.6.2026.11.14.04.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:55:08 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: ulf.hansson@oss.qualcomm.com,
	ulfh@kernel.org,
	heiko@sntech.de,
	finley.xiao@rock-chips.com,
	shawn.lin@rock-chips.com,
	sebastian.reichel@collabora.com,
	vlwwwwww@gmail.com,
	leonard@lausen.nl,
	abel.vesa@oss.qualcomm.com,
	tomeu@tomeuvizoso.net,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 1/3] pmdomain: rockchip: switch off the subdomains of a regulator domain at probe
Date: Sat, 14 Nov 2026 21:54:53 +0900
Message-ID: <20261114125459.10030-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <733b921576828ca70a3f5048691400130f8a5dbc.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615323.git.gahing@gahingwoo.com> <733b921576828ca70a3f5048691400130f8a5dbc.1794615323.git.gahing@gahingwoo.com>
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

On Sat, Nov 14, 2026 at 04:04:59PM +1300, Jiaxing Hu wrote:
> Mark a regulator domain and every domain below it as off when it is
> added, and once the subtree is complete, switch it off from the leaves
> up. If a subdomain fails to switch off, leave its parents on and warn.

This also changes probe on RK3588, where npu, gpu and vcodec are
regulator domains, so I booted it on a ROCK 5B+ (backported to 7.2).
It boots as before: the NPU and GPU work, the video codecs probe, and
there are no new warnings.

Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, ROCK 5B+

Thanks,
Sidong
