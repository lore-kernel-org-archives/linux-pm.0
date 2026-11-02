Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612437;
	b=w40WxqZwb79zzPGOF0GbWDvZMB5neTzEBcmhNvBOg6nQ3hS8gIGS98REl94SC++4WFdq
	 FKvu12Xiwfibm3nhbMTy2RMK+3E5aE4dGhWB285L2NRaQJR5iGh42Wsn4/vmV5kDScIsy
	 1TrASTBhGIGJjuQcuu1mjD0wAtDTIueP+hosJH/bY+x5Havuxl5JJzEVADxbcvpgU7RLh
	 apPMZ1FOanILQzBxAEPAo0QjBFSsMgB9VRZFoP8ut9kqFVZz065k9U9KuADZIXu8VsBzC
	 2+xjBmhznePY2RPhj7xK05VwPQ9vJN8j9ZqM7PM7zlcXKVz0bqFTFB6/kfeMfm3xVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EzjmXrkDzsq1ea6V54eY/ckSO21R5zXaobZj8IyNVuU=;
	b=TtP2uL/WMiX5hP9oi2Fm5e128BYVjXKfNukzh38BzbFrPKAjY399H0sJC/xLkO4PeoR0
	 lZv+5ckwNV1UGIuLNx3Q95Ap4W6ozFtS7NChq1u53D94U0zpnBy4fWLT3jqN+37Qtfiy4
	 fT0TOZK/03ltZvY2ENn85cG/S1zf5Hud0DgYBQFbh51XBsGuOfN2RM2GB38Wp5ISvFNd9
	 BMAcPMtsCnJVGNs48l7zbq0KV5Kwq+/iK5n0cn+Auks1StTsSkDto/6rpMrKr3ScFRqgm
	 Vk1n7uNWaFQo2k2b/2FV5yDXv2SjfssvWZBgljOlMPsLu6XCp7c5AMR0VOA/C5UI5Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAk6wFia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6538606A324;
	Mon,  2 Nov 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NAk6wFia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F591F000C1;
	Mon,  2 Nov 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612436;
	bh=EzjmXrkDzsq1ea6V54eY/ckSO21R5zXaobZj8IyNVuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NAk6wFiaQgBVuToA+AZR5hxbuFmP7Yqd4fmisg6yPTwpVv4E0gYqzHB40XSwU2+Vw
	 PBbZGi19uXHQ28XWxNU32kYBdcQYi54zKDvc2d8pAyOed6tZnbVNb7MGry8RGSrmyX
	 MPJ3lW6tH62zVSFv86ZGKiHRrWrkcCEz24YKIANpJRHOHAI7juMKcLLW56dFPQ3sgw
	 ktb54aU6BUy6YxDO6F02RcyqTRvgXzzYniYC9Mn7mFWRKvf2GIKGdYUcdEB9b8HOi4
	 XNeYUZlxLxWIzpyLg2ZevqB8pPA6/PXbvv2/2pruHYoZr1vizO9FUUKIp6xhOlSSEV
	 wNEsZF+qtUnAg==
Date: Mon, 2 Nov 2026 10:40:22 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Andre Draszik <andre.draszik@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v27 05/10] dt-bindings: arm: Document reboot mode magic
Message-ID: <fmik4cb4dltd7uivkdiyxrjsvi6xrsy3ivecx4nnwr5cvyadnd@xzofyqlmjwqf>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-5-fa4b3ff1359b@oss.qualcomm.com>
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
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-5-fa4b3ff1359b@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 02:30:59PM +0530, Shivendra Pratap wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
