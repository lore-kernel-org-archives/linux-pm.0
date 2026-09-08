Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7994CA78D
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861091; cv=none; b=L1rHUvMKM5Aa0SNdx5zX7DH3AJW3biGRvlVUunq2dM4UWk3hHXS/OR3ckDHcYTRXDJyE98UvlSrnkM2mOQ/9BBCAncjHsqPKWrVwdl+6XfNwMklHo+t45YWNd+hY97j2I8HNStCuZooDqjLziRX6g5Aj3p9ME0X/1ADr5G1QxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861091; c=relaxed/simple;
	bh=5CWTOwOGmV0tbIBmvdnUvKYui1xJoatPFsL+LsX19RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdnQ5ikyUtrvqAUmfakKCJS/st//nBvDMSlDLx6tbZU6NpWNNuH8TmKx92vUCnPu0aExVxbsKlZmdYQubAsR4+02gbNLH57LxOIp15kxvgK3qR2YwENpaOSdgoO7+RL+cowSbGdRI6iGZq5E7LnsfPfWEzRh40FW0krOMkKeuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQRKJ3xX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQRKJ3xX"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396673bd281so753206a91.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788861089; x=1789465889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CWTOwOGmV0tbIBmvdnUvKYui1xJoatPFsL+LsX19RE=;
        b=CQRKJ3xXgW74OfBTd/g6J7KyL4zGi32EJIk2VBzvm3Uxh97turAx1KhRC1nNklLW7M
         UVho9kJ/5EnV2TEdq9i+J/pF2mDIYgvIHGux1aXTM2tzTZDFEeMNE7CdF7+ROA0aYIza
         ZDHg9ozE2Hay70DEoE2nyjTHPeaUVRcLO2qtPZ3p2n0qhuSo4JfeHwJ8qzmAZumtYGep
         NUEqnWF5GZ+Neeos/yH9fRHj0kSztsFJEYN+iv/EF5RvFZbyDJj/50MoPrMg3Yz06BUP
         p332zIRrqNbcifLslKO+0aacvpKUJn7aFG3RgOaMkRJV6GJ8WiQ56Uk7fB08E26Vg92C
         yuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788861089; x=1789465889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CWTOwOGmV0tbIBmvdnUvKYui1xJoatPFsL+LsX19RE=;
        b=WL0JfpaPPL7ZPFlHqz4jIqxpEcZp63CbXWWA6T9KQPESGVgiYn0IKO0BNF+miTJH9G
         WD2bl29sZagFEKlpanrmOi8bQeximpLoIRn0CCPJlV9pHh9nI094NyZ8QiOSGwQbL2ki
         DbCQMvY/4WeeMwiGycqMDZomyL/jMLJGvzH7o2gXaneZC/CTE2haee27Idu1E6jy8d3L
         ABvBfGlVb01NCAAef8R0iPhaL4ENIaPigDF+YrXKEi/z0xi43NPHLlYGyxyx4ul6aR5F
         6H0dlDjvpXB+gsmaX4YvKBYBJrQRsej5nwj1GlOjntTvZUvAimcDIAP3i+iKJEbfRAoF
         6OKA==
X-Gm-Message-State: AFuF++ko78OzS7uM3X+68NZdNaZ1KQzdcYXycLDI2/VIp6ZHaHnBDg8s
	NT6K8G08sNXTfPcBiKppVwsvF1RbZd89O14IdMKwWxInLGUm5WSHl+yG
X-Gm-Gg: AYBFou2MWIruuoQYdF1wfbBpHXELJ7Zqfvu8htAiOHV2YhxCj/PJIx+QOZIoNXGy2xW
	K/UHbhrILYvt7ZrFH0UXtbJQyIovrydxnYPByPlf15RFI0EI1No71ytPkBv5I78maV5v3N+mCY3
	WysC3h/CekNQyFoWeLOmKrJCW2+11sOAMzKSL8mZ3uW/oLRasVAc7U+YNQ2rmAxSb1TZV3gaGWC
	9h/xux6M1EN+GKDxPKU1KsOl3CLWxRpVtQXSk6IWEbSHWMA83Q8dBh0XQwR62DGf1MynKcX98V3
	xaQ7d/YiWUQTvvvoyr4RK9WF6hejHYO0Ep9IkN2rVYScA7hLy5LjYGTg/+7ZGBnj1kMLtH5MXSL
	+bvqtaxXwuyRTBE+HEEVfFk7Lm7+GzrLWc4FDvduphssf84u/waV5Fc0NT8JeduAt4xzQCLugGZ
	U6as8U6C20ecquv6HqKHx75NaBunsMxdHZNtr30MZZL5sAmuttDWdczWMu0CX5IMkhqI9PkFV2+
	mWXKgBMtLX6mpnjhIGKIiD98VggHg==
X-Received: by 2002:a17:90b:3ccf:b0:39b:34ef:3b24 with SMTP id 98e67ed59e1d1-39b3d5aaa70mr19661739a91.1.1788861089072;
        Tue, 08 Sep 2026 02:51:29 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm39414604eec.1.2026.09.08.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:51:28 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] platform/x86: hp-wmi: Add charge behaviour support
Date: Tue,  8 Sep 2026 15:21:22 +0530
Message-ID: <20260908095122.442670-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <edbe584a-c241-c3e6-9993-2783934885d9@linux.intel.com>
References: <20260531181326.1000801-1-navonjohnlukose@gmail.com> <edbe584a-c241-c3e6-9993-2783934885d9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the slow reply.

It was RFC because I wasn't sure the WMI interface was right for other HP
models. But I've since changed laptops and no longer have the HP, so I
can't test a v3 or anything on top of it.

Dropping it. Best of luck to anyone with the hardware who wants to pick
it up.

Navon
