Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563483;
	b=nDm/aQDBQRVv25nQwseDBT7ssoDkEG++DVzFKdAhpBr9Ej7Qtg9dQIi8uEZWBsjBNRxy
	 Eb7Kex+F/Ruuu9MQ3DEQU7R4GLP7nivcZ9Y0/vrVoGlO05DNCD52sdIAYYjGSlihcfA4a
	 2Ce0wUvDSkGXGHdTXHL234rRaTJpWImjCFHbGGmZ+OSVzeAYcKRZN5F22sC1U6mvdr2aJ
	 zKybwLeEvj+jyBlbu2/02nmc5xVWJKPKF/pQxVWVIrD/+2/8mTysjwxhSJC5ZamuYgGou
	 cy1cJFC6vTkFdC/ZH9RUmq86Zl6f7u8IPEytXrOp3gQhNeYuaB/rEL4iNiNMDRilzXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563483;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qM35vwS1YLDmGN+uv5ChOSkJ1AQ+cagXNb3hozKL5uQ=;
	b=k0GR6AALbH8Xlu79accZsuVz6Qk29xqspf6mKjXfOt6pxllMxJw+lEKo2vmtfmOpqAtz
	 6QM8c62GhNE39YXp4LYZ3mp+RArznBwvOlxwHnCE+jDH2EU0nyrQZxQ+IQLhqImMUd2Yq
	 t6AMOUNtE8PiZPmKxzug4Kbi2AK4N4zF3dXUIk0WD/VA8UcNuvxf5uGZFC+XAi/Ddlczf
	 +OR5ZJ0VZS1sxwH2ycjVExQslE36T1xef1JeM+uVqrl+xgEneOSFyj/GCSWzS6qI7po4h
	 LC8SDsjBHoiKmHBsJEcxIetvSNhSktyFmRP7mlkJK7xOstuE2I2FkouiEKU91UDWaOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzPAZyKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7EA2E606A32E;
	Fri, 13 Nov 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzPAZyKh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C0301F000C4;
	Fri, 13 Nov 2026 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563483;
	bh=qM35vwS1YLDmGN+uv5ChOSkJ1AQ+cagXNb3hozKL5uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzPAZyKhgPMlAiei7wa9AeaBgu/62M/YNxUEvd9plcL9qt/WqBdIM0YUpRBnSCouP
	 +h75WO6+MvcNemlz1oBDAox5E7JV8A/k750VTdIlM6ESJg0r+M+k1HEvUT2Y5jzkfE
	 M6He/fV5RoJri/dWqNYCPU2w/xpOrq7NAqd0RaguU56WqU1EcGtPk1Io2AXYyTLFaF
	 9w5pIHBF850UWvbeouekS97Fy8GJ0iHxoGM3he0GKCg9yiKXCjCGR6jlaeOAvsgYEI
	 /mm4p0eMwbAEpkMzRYtA3iwrLRfzKMfGHncqsNKPxizmcPijnOLE1hejHpOFIVdaNh
	 KGthWFnxSYDhw==
Date: Fri, 13 Nov 2026 10:51:19 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, 
	Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, Shuai Zhang <shuai.zhang@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake
 IRQ
Message-ID: <i6ihipvdbcxz2xnfercbk3payexgqddx7b5fgoejah6awitltm@xhjtl6cs57ot>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
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
In-Reply-To: <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>

On Thu, Nov 12, 2026 at 03:20:06PM +0800, Linghui Wu wrote:
> Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
> resources need to remain available while the application processor is
> suspended.
> 
> Teach the Qualcomm WCN power-sequencing driver to use the existing
> SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
> as a wakeup source. The PM core keeps the IRQ disabled during normal
> operation and arms it for system suspend.
> 
> The series documents wakeup-source for the WCN PMU binding and enables
> it for the Shikra CQM, CQS and IQS EVKs.
> 
> The series has been validated on linux-next on Shikra hardware.
>

When addressing sashiko's comments in v5 - please send it as a new
thread, not a reply to existing threads.

Thanks,
Bartosz
