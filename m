Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565901;
	b=OyuHOmXFXbbT13qGT4kvnrQnS7BFyMsHBQ84Yx3fnPH0K2lM2PjOTwFBfXXJlK+UAsip
	 ynJv2DpNUVPGGXPtjk40Tsj1S9lSmLU0IpvU7UuZ3ChcnqF8mVd0jOmcZuF86gadnXRx3
	 ylhvI5wUUhIQfyZEMh9/nzvjBggzB/oLv9xHmkoqfFVtdJBbvTboF+4mf+P468lvQkFIP
	 35mpjs0GZy7Kbyt08o/r7rqmR0rcgOKZ4D6SdzSBPucnEKbaSbYATsNsoDT4QlYQrya+o
	 ZYm+YdyXxfJiSvkxaslPJ0TCplQRzI2qd1/t9g2LEcO1+1vOnsKWqwz0/tkzmYjJwKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565901;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kX0wU6teH/2LvA7XAbxl7IP6oPOXddtD7pAfMcW1MYc=;
	b=DQsi6x8okp9D8PP9dflY3oucRrM0tfsaAxfybk2M7levim2fHFmSrEHiqCrq20mU32oA
	 aKE0AYl2Hx+hzvXFNOoMKGiXP4Mf67RPiGh4UGiCrnIN3SmwfMfCmgPvorFhyCU5FhSDd
	 6Gr+gzz6kH0kfDfr/ckpLgdiHt7+3kdBbfeD9VomPHsaueXuIBjeAixUS1WM2CGQq+LPD
	 1LW8NQetttmxwagHFqYUpLDv5Kxiwn0tQHjrc2LTb61558D/T451zxF8c2SlJ9GWFzMOf
	 95u+esd5237T/b2pBEzqk3rdgfZJPHNzIP9Uodh8sim4JsI3uPYU3Tz2QJe2Quw6+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4AO298p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C232606A321;
	Fri, 13 Nov 2026 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4AO298p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B491F000C5;
	Fri, 13 Nov 2026 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565901;
	bh=kX0wU6teH/2LvA7XAbxl7IP6oPOXddtD7pAfMcW1MYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O4AO298pynpww1+j7hRz8ZF2TQxwknO4JU5hHHpAa6XMPyTI7WM7OdQVR1P+Xm6wy
	 OdYclt+vXeDQFmQZ/2osWxDL34cG2VFJSMAb2DTOQCeREnFhOw7O6WxOmZquHf+bqR
	 gtB6nhf3ue0peBBtq6R2AQhh0xGSikfNbquoA5IOm5z7agnlmS/+j7LutIL8OiDk4c
	 JFKdRMctIPpAaw0yCuxIhk7ceBjcGvWNv+W8TgShDjwYN9CO5YaajsTAHj4mE4OrYp
	 tpyS2N7vM9AWuOEWG2wzIHOy54F7Ng8a9noMBVpgMGciKk6EOy0aL+LZWGrgZ9v5el
	 dZKCV9W/K3qTw==
Date: Fri, 13 Nov 2026 11:31:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Halliday SoC
Message-ID: <20261113-doberman-of-unusual-beauty-ce6a57@quoll>
References: <20261109-halliday-icc-v1-0-def7cf786f75@gmail.com>
 <20261109-halliday-icc-v1-1-def7cf786f75@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109-halliday-icc-v1-1-def7cf786f75@gmail.com>

On Mon, Nov 09, 2026 at 12:29:53AM +0000, Stanislav Aleksandrov wrote:
> Document the RPMh Network-On-Chip interconnect on the Qualcomm Halliday
> SoC (SXR2250P).
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---
>  .../bindings/interconnect/qcom,halliday-rpmh.yaml  | 131 +++++++++++++++++
>  .../dt-bindings/interconnect/qcom,halliday-rpmh.h  | 158 +++++++++++++++++++++
>  2 files changed, 289 insertions(+)

Why isn't the rest of interconnect patches (bindings) in this patchset?
You sent it the same time just split. Please organize your work
properly, so subsystems receive all patches, not pieces.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

