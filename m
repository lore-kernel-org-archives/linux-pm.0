Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9E3FBA7;
	Tue, 23 Jun 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223970; cv=none; b=hf70u3+1w2FvN32KwTB/XMh/JpPKKq3GPUa1LuGRMu4CX9nPIGjMA+sSvPrkrLSOUmfIkd6s52U5cujXMuUBkRiIyVGnpBjTnSIuwYXxsS3fyfELaQ90WwnWfO1ZAq6eqmuKuyf9ZvphlPLFnS4j8ylHTC7Nhg3jcsxHwlD9mwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223970; c=relaxed/simple;
	bh=t2zMXVUbUq6ERjN/fIvEWYa6XlPtK/FgPC26NjIAjXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKsNKoGy+67BWvxqj39wu2AxmknqyOKnHjJKJWH5ivPwkXsvI2UTixvFJFPPKH/HoaJRv3YD/v4rBE1SHnBNjHk3m7hBQ+TIQMpLC+9F3lKpSo4BHDHI0FlIv/ejuxlvB2U2Wj5fXuhCX+W1jvS2536ztzf4zjGxOzhgP70TAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Djvc0Qrg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Djvc0Qrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782223954; x=1782828754; i=wahrenst@gmx.net;
	bh=t2zMXVUbUq6ERjN/fIvEWYa6XlPtK/FgPC26NjIAjXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Djvc0Qrgjv6G7JA4Y8fsoFm8STKZCHLc3tbtpKFwnSHWKc5K7ls6L1rlGbt57Y2j
	 gcGLjVA7ZaS8485LANJRzxLqAfm2+G/OTJBBwih6lM//1wEyQCB6ysS5GHYCDS+nX
	 eyotElWIDS0YW59hu014z+PznhlawITvaPbTopx7JzFEq/UXGskRHVvCbm2KV0NY3
	 LDOHQVPKQ8DrYB5p+4BX0kocnmb+o+xzWfyw6m+CF1GCuFQnM2vKMVDh5lMtBjawp
	 1aS8rwRCk5+MNSiMfqlqbC7AVqyAgy0QmcDc3nIjFUTrlHNo/EuP+U+V5M0nKZ7WC
	 39q6pwMlw2tU360vgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1xL5Vt44Si-00zqLN; Tue, 23
 Jun 2026 16:12:34 +0200
Message-ID: <82b9e37d-6ae8-4df6-81e5-2f75ea490297@gmx.net>
Date: Tue, 23 Jun 2026 16:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835: handle genpd provider
 registration errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Ulf Hansson
 <ulf.hansson@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Stanimir Varbanov <svarbanov@suse.de>,
 Eric Anholt <eric@anholt.net>, Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260623135937.60740-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260623135937.60740-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xzGZzmRsHcnPPt4VQyVgWztQG5yYjbncqGKYZEmpRWVtpp9Ievy
 WjSPlNCbWeIlwSsLaVkBEpCuIiQhQ22lyAGr3evMzUULRnRdhYuPaBiGiuuq+c22n7gq336
 vGMgYF7W7O71+ggNREhjz2Xl4T7Ql8xlc950JZGLeKwESIRVX58SQVno8WabDpkN8X/OBI5
 RQ4+mRp7+8DkzJOQZTDgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KSk85o12X2Q=;m8oojhSrDPT7Xog9EzI9Cqdttf1
 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
 E6YiOfxYnm2EDUImJ9I1ww0zif5xdfmXjZDHo54

Am 23.06.26 um 15:59 schrieb Pengpeng Hou:
> bcm2835_power_probe() initializes all power domains and then registers
> the onecell genpd provider, but ignores of_genpd_add_provider_onecell()
> failures. Probe can therefore return success even though no provider was
> published.
>
> Check the provider registration return value and jump to the existing
> cleanup path on failure.
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
