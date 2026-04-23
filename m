Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740E3BFE2D;
	Thu, 23 Apr 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933199; cv=none; b=Lwvc5ss1h4lBvKblY2On/tLUhfC5TOlDHL/P2U07/HGjimsq9mPQaYdXRfuWCS6vGvd4lDANUpKpApkbwncxc3SN5s/aDaogc6d1hJLDZn0X2hAQVFqv/GbdZF8PV+iwaEUin2b5yhP9Gf8i6OFdTyWJ4Of9Uf0wEAapTjIcEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933199; c=relaxed/simple;
	bh=5+zMriaHMsBBqN//VTtl1hWoE1/+kUuxp7yWOapsSwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFZ+GQhXoy1RZ1p4RAIgyEyT44kk7BcBQcEn+avdtLcENLUGTF7eF8qUw/yTqvmyARJltJuElsRfUtMFCNRJkZuGtcU1EVl6heEFuzecHO1s0kY9ENdpbAtFQX/7iF2seeYviwyWvsMQtVCxxqYSJV8fOKLgo3Q8m/+kBrnvRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVax2POe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVax2POe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B031C2BCAF;
	Thu, 23 Apr 2026 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776933199;
	bh=5+zMriaHMsBBqN//VTtl1hWoE1/+kUuxp7yWOapsSwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVax2POeqCh2r625MA5To+c1tsjF6726wOyrKgtXkMXFqDpmpFMG1fGvbaacoVXXg
	 tCLhhUHnWYGsU9Mrjs4oMsyJn+1siKxGu7Ql/Xgsiwm21b7c+RjouSyROJXwQVFDb5
	 TjF1Aqmx5E5jhHRtgo7Q63bDlxZaauJsw/k/zJYvdBHRcitKBUGE3G1h73nL4lmSNp
	 9tJGIWufu4pB6hLelUDQVqTVgf8N6R9BpkvlKCNN+KJXxT4SnPFbMTEizItsmg4Yr6
	 5JjmXoYeIfd4Ovqv999WXBQwVq1fg+/6YmLvm7l1vY0cBaiUckDmmA+LLk9C1tcO4Q
	 1Kxw2KSYflzRQ==
Date: Thu, 23 Apr 2026 10:33:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, 
	gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Benson Leung <bleung@chromium.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 12/12] dt-bindings: thermal: cooling-devices: Update
 support for 3 cells cooling device
Message-ID: <20260423-acoustic-arcane-gecko-8c66cf@quoll>
References: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
 <20260422174305.2899095-13-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422174305.2899095-13-daniel.lezcano@oss.qualcomm.com>

On Wed, Apr 22, 2026 at 07:43:01PM +0200, Daniel Lezcano wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Extend the thermal cooling device binding to support a 3 cells specifier
> along with the 2 cells format.
> 
> Update #cooling-cells property to enum to support both 2 and 3 arguments.
> 
> Fix pwm-fan.yaml to restrict the number of cells to 'const: 2'
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

