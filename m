Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794894081;
	b=r5L3ZEWEBNb/Hksn+dzcGCMLntcxwZRELFyxZyNnk71wuIPqkH+zU4CS2HXsOaPUVO/q
	 c0h7rIuVEY2vhvzu7fFaWmMJzdgyofhLxOoYnw99utmgs/vFVboooRX6dIvSJ9HsRNbWL
	 cCiEi38TCPi7NxzxxIu6/LA7L6D0XXldB44G78YAeAZf5X1OTTM0JNsNzjMqJCK22ZfPS
	 9Ovj9aw5w1m+2gzPv3YaLrvmc6lyLD4qyW1OVLdgHsKIij3mUSq0kEBn4FvRS4rTyVeip
	 6uRhvcwX7zw83+rID0sJxTaFr3P60ToUc/fmzzTAyxQhttKrILHk0FgZZ3xG+k8oUeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kgXAga4SQ2gGcYIcOPrgNzb4Xfca195d5V/zBY0TA5E=;
	b=B2a5AU7oVQEtHAl4KbDqO/1Yhs3dWC1v2hXj7M7B0SxbCfXUUdFHHcr/i34kGJWlvDB/
	 9CMKCo+H7AEgcJQbWxdwm2Uzx7L1gEYd+zODz5oZn2/Wbf4nSicSeCPmVIlA9FPJRfmKC
	 GGPA+1zwg301tiH6ky29SU4jZMbeQpZ1uTqWlO4o0SrRPptJJ2zhpN2URmJ1bcwFAC3C7
	 cfEPQWantRlAtlvKjriWW1x5V150eDA+rEbksYxEuBf75IIJPLHcpgbweq9pvZ+oO1veG
	 u4n0HE2xpAhy1nW81DbmoqlMzMx529SnG4uSVRQ3auTVhzK6D7CXhscvQKzoiBFXOCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PQr3PgP+;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6136606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6136606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PQr3PgP+
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b244fb7fffso5149428c88.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794894080; x=1795498880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kgXAga4SQ2gGcYIcOPrgNzb4Xfca195d5V/zBY0TA5E=;
        b=PQr3PgP+hc6DT0aQU/F4mOKsRUSEulybv2c1ObP3i+DkihztlWEctX0OrUgl6usesp
         LjVss/ez54+GKqptmSO447ZTgQARt4/Hqnxbxe4wKrARIDHxATiTAuXAUYnd5srby+N9
         vIOlcV7Nd504l6AaiMlFfzLDi9l5+R6A7aeaaPeYS/SdAVWDOIhSPf47Riiy2R6M+m75
         Ukgmqhi7cJ0OgnvcKLaHEGrytFD+SRwSV0uvePUfCnI6UPFqzp3h2OWF+CpLD3vPaxqN
         L2GFjD1uwlGTm474BmzBxVLJXBEP3UcTQIALBo1pSXC6QfWbbogt02vvQ0hKRpb2TPsp
         1BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794894080; x=1795498880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kgXAga4SQ2gGcYIcOPrgNzb4Xfca195d5V/zBY0TA5E=;
        b=f0pdogPHDAAsS/n7TTH0vaQQrWsL16EHSclNXP99pjT8mHY9fKCvGnjO7/OIEDBAzU
         XXuxVfpXuw4SlGYRZBh6orY34MMYdPPiMJTGRglXq64hUoXCdOb5zHiIFUV/0tzS46Hy
         Iv6sTtRvq/oSZHmlCESycXR4L3wskgBkToo3EkxfFZ3AGaOsq8LoiUSCEiUjj6Jz6UUX
         zk8m7pZYid8po7GaI5E0m4pO7D+2N3Utqq6l8va7yzyhj+1pO7MIYS4/GFpePo3dmpMn
         fdxaqePQyPpsYCf8ZYOy7eW1IqPADBjx4DEyJVBfD8w3i8T/vNlSbcKNo7MnurrsnpUj
         B7pQ==
X-Forwarded-Encrypted: i=1; AL+hErG6/EoQiY1qvFkj+hKm7PCGWVSbZLvUIhjlDwS9TXLwL0wYqSVMT2BobsiJjtIixqExeMddiU7B1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9jdKYCi7tendLzQ4DNvNxtSJOS+5BtJbG75bLrbSVZaDfVkT6
	6RdBVWkR5CNaUyU+gSxMpbahj9INTZFVSRxpq1mPUfrXv8J6BApYQIsiMSLF+eACdCs=
X-Gm-Gg: AYBFou3kKTPXQbgU8y/xONU/+oLfMiwnzdcxW5cHey7ozhG8RZjCoFyAovNFEd/rhX7
	W1L/y335yiNElCeA6Rt/WOvlYYx3e6KKxibiI8oode7nV7MXR1soWgNxJeXshPYpCdAa4uytGln
	MXdRcslYYyr/4cCYvae/zrJ/tgKkG/TTC6nCfPxk1NiSt/5Er0d0kRUrz3dZ9f6T3yVYoY+xpGN
	DU6I1jss80P/rv8Ujm8g2ZwGekpZZeoqACGEnF2FjDbzy3mOegLs3jysZ+tX9e2orAMyWjb/s/T
	bZ3rsEaLHnxXPhjW8EPWtlwQB+xCe9BfgBosbOf786WrCn4bh8KLf73HCmtLbRwbPf8SSkG7mPK
	VTlj3Oxg7mYc+loz08/J0oKZtZxachndLq08lE+jtcozOyBv9r5XsFiwwYHSIHZk5bDL5ftdJft
	xL8NrhmEHMqnXv7dDKQoxgAdRxc437ijD2OSzkcW9nUUEz/RoY05AZi62A6J23mpifD/qr0X/8c
	FzexWyaqwqtC8kBDqyNjIRX8lSxe/jkFUcWxfwZHzq2lInQJiPkhMbNl4Zz9tXLokgpJ5seyl2u
	RWHGmWiTxuVxZATKjy5uj18O3qd0ng==
X-Received: by 2002:a05:7022:290:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1b503068235mr10688010c88.1.1794894079483;
        Mon, 16 Nov 2026 21:41:19 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm17957878c88.4.2026.11.16.21.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:41:18 -0800 (PST)
Date: Tue, 17 Nov 2026 11:11:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add cpufreq support for Qualcomm Halliday
 (SXR2250P)
Message-ID: <avvo-0Gj9u4ZdCyh@vireshk-B250M-D3H>
References: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-halliday-cpufreq-v2-0-e518cc055457@gmail.com>

On 16-11-26, 21:25, Stanislav Aleksandrov wrote:
> Document the CPUFREQ hardware (EPSS) of the Qualcomm Halliday SoC and
> keep cpufreq-dt from probing on it.
> 
> This is part of the bring-up of the Qualcomm Halliday SoC (SXR2250P)
> in the Samsung Galaxy XR. The DT changes follow in a separate series.
> 
> This work was made together with Claude, ChatGPT and Gemini.
> Reviewed and tested on my Galaxy XR, where cpufreq runs through
> qcom-cpufreq-hw.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---
> Changes in v2:
> - Add the qcom-hw binding from the DT series (12/17 there), so that
>   the cpufreq patches are in one series:
>   https://patch.msgid.link/20261109-halliday-dts-v1-12-289114ab8197@gmail.com
> - Use the "cpufreq: dt-platdev:" subject prefix (Zhongqiu)
> - Link to v1: https://patch.msgid.link/20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com
> 
> ---
> Stanislav Aleksandrov (2):
>       dt-bindings: cpufreq: qcom-hw: Document Halliday CPUFREQ hardware
>       cpufreq: dt-platdev: Add Halliday to blocklist
> 
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  drivers/cpufreq/cpufreq-dt-platdev.c                           | 1 +
>  2 files changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh
