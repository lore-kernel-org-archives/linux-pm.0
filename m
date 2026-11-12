Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478396;
	b=mEyXTLb59MBtdexa+HP0gr2X0rRFktGI1rhqUEoeupK2DEbSm0rau5pwuVq7M7QkJE6o
	 tjfq/gC0g/gTatALKnevwgBUhhb1yo8ZNq6e4vBzYYbJESzyNqfPu9ixHSO7rVCPIa6Hy
	 M6YiFVyUHb33J3HZWhPIDshBXubDTzF32ar1qWoLqqsPedsngkTgtLoQXgTgAWmjdmTPd
	 Z25a0E4LCLtEkawhYsvVRpn2o1/RKeStgiUlIyLZ1RjAgE9TPseVnvZjG1CimmMikDNyM
	 EzA+WiWwNFoyOBtGDcwKrQxGdA3gZvXOqQHQFvSaXa2CBlTFdSTsBQW4NnB89LJv3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478396;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wtvm4bUz4M3LTVqusNXCR/CjAB5YqrK+oM377d5ahbo=;
	b=fYY0UEFEpfVW6xMQ+Spfi8piJ4kz4dg1zjOmBXml3ywmSHr2itE4n7VBbWJxQ6z9gIPP
	 c2mCwSZ7ZTfx4DLhkXU5H/CWbokkNaIbiJT/SPuO0ysNaC5Z7P/kZf48dE323Xnja07nE
	 qYTvhuIGZUVeLfP+XdZiR38B8+SWTh7udYNumuwZXUT6JFo9qQINgbmyCcYCK6uPKrRBi
	 8/7MjwhzLUfeG6T9ZBXlnT337gmuI1x+z7OCK3715L9Kq1FNm5DXE92ooO2sFy8Dzkxc0
	 iiXGCOiAWC83QFW3C5qkeOKZAWGYiJdqOoqov+sRVxfx+cwbbdOPNOjdDqRmE+wI8MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et7P3CEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 78151606A33D;
	Thu, 12 Nov 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et7P3CEt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3BF161F00A06;
	Thu, 12 Nov 2026 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478396;
	bh=wtvm4bUz4M3LTVqusNXCR/CjAB5YqrK+oM377d5ahbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=et7P3CEtmIsa+Oex5SrpZMGXuy0LFl5uTSPe+GnmBwygD9vZLtxlcwNZQP/2NiL04
	 fdWQ8/XxZX3c4EtM/QhsWmTmCbliYZ29uO25MANGCdd6ofuRZNcbAzx+xvLLmu8B5I
	 +PTlMEQxwo9GOvUbwE/rH/joIQC/ClD5J9VuegfBJ4xx8dY7mB+45CvSpGj1Nt4ZFY
	 eDC6PgdBGfFQBalRYzydyskDi/wkYdRD/DBbgBLniYfjM8OMZ5wyHY3pZ77aaI0CSo
	 XwAicgA0lfLkcUAFXTB7YEh2tYsnecXWy8nt5vNRZBTOb9axnovgAJiRSTri0tL4uN
	 h8IPyJRZppnAA==
Date: Thu, 12 Nov 2026 11:13:12 +0100
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
Message-ID: <ixgltkv3v6soazi6h335tm3eiuomiyw6lcdlxl4sczngcoe7jl@2jlv7z6dyrrt>
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

When addressing sashiko comments in v5, please make sure to send this as
a new thread, not a reply to existing threads on the list.

Thanks,
Bart
