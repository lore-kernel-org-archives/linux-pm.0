Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600453;
	b=AD7nBlTXn35o7PoOU1Rnu14lOd0zEq2DtFHY5g+uRw6ekyfiQpLAIFFH3fM7k+BINELr
	 /c/zC3v4ZA58vUhgx6XO7TWaDyiV60jg1Mm878uyHUFOd154xtf6JS3zG9x20ty6F/Rvm
	 gSxyY7sjiukvz/1o+vP2nYdT2ODEJcQjKGJQfTwFWDhRP6V2xFL6EalCJfhwVu8mH1Clh
	 WHXQ2siZaxA/EcxdJ+Jvr6JMZ+5keREKbUIyv7Xg0m0YiYfL15yw18KBPCynHeF9wq1pp
	 E8cxg+f8ctSx0hPB2RGcdCU/gF5PlAqIUG3c43riSX60uQlj8cWCr5fNAlUVVJtQ6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600453;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=Gh3A2D2fziCxcdrgAcPnJ0Xw3F0aoXWG8pAC8gS5IRk=;
	b=pKqd9oWntrp7fpZR0vFLYDpqkeFegvga1ZISO0lY8Q5d8ZE7YvyhRxUdbsERwlkLAPgZ
	 4p1RUoX+0imJPMgqNikZElZG6vdpYhHIjNJUFdlff4sDRqupokMin51Lxq9tCWrlygMVn
	 rBDO1uv7itGezoye77e7Yo2YLh2Z25ToIParUUsw8JTe53cBrX5Vx95EK7HIP5HF8rIr8
	 lm6H2cXCOImiXt9bxjtwNMIQpvL5rP/pyqd1HSXWxlVu9+nsUfzIWHeMZQfUkVXxM8ejz
	 viroqi1NVEE+ELFiE4uhJrYnSSZOiadObASxRhHmOexnbo26kngIQbi2q+ogfgi3SjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID9m8NGS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A3606A31E;
	Wed, 25 Nov 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ID9m8NGS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC4E1F000CA;
	Wed, 25 Nov 2026 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600452;
	bh=Gh3A2D2fziCxcdrgAcPnJ0Xw3F0aoXWG8pAC8gS5IRk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ID9m8NGStN4osIjiLy3dobGyRG2nTjhao86rr15nVUs58DJL1EPQ5c5H0K5WwJN0t
	 3quk+4gK7QhdSsDPKHGnLk4DSPaNHKzeD3rlPzC0q9UEQqlRB23fu5XZytO40dp+BQ
	 UeYbE7EOC5/V9Rh5zXC6b60Zox/wWHGDFO5TOeMHYtMJGlMJ0bzlJPvkQTVKPwPAZl
	 kMbiaQZgegi5IoV+kjaxGKuF4uVTZycTzVm9ILmmoy1SF9Abm4eBPil2Aw0BJkdlNg
	 Pw9jLSewLQOjubFy0EpCopSZMXxi6FphfEYVEkriogEvFfDlqJflC33uyMWyfhyJx8
	 6h06SHhg9q+6Q==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm Netrani
From: Krzysztof Kozlowski <krzk@kernel.org>
To: SignKirigami <prcups@krgm.moe>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261124-netrani-interconnect-v1-v1-1-bb5efdb229cd@krgm.moe>
References: <20261124-netrani-interconnect-v1-v1-0-bb5efdb229cd@krgm.moe>
 <20261124-netrani-interconnect-v1-v1-1-bb5efdb229cd@krgm.moe>
Date: Wed, 25 Nov 2026 10:54:07 +0100
Message-Id: <179560044703.14607.17874191389579322974.b4-review@b4>
X-Mailer: b4 0.17-dev

> Describe the Netrani RPMh interconnect providers and their register
> access clocks.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---
>  .../bindings/interconnect/qcom,netrani-rpmh.yaml   | 131 ++++++++++++++++
>  .../dt-bindings/interconnect/qcom,netrani-rpmh.h   | 169 +++++++++++++++++++++
>  2 files changed, 300 insertions(+)

Fails tests, no?

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
