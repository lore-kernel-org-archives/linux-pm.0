Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388607;
	b=k51QhcvgfC/ae9fqYdJBlhckVHLU1dQr/EEU7O3HFllkcz6BVAkS9WKxCY1nHN+fRUux
	 ltHiOiFN9p04N4ySqoC5oixo77xF8u/uhMBTG3PMIjH0s3WWs2hKi4vVQszljJXq3gpcV
	 QGnZXTumjLm+Sz4zlvkSdlBdQsawvW2h+lFItNDoOtNJ6c3yPfOngGNubKH2H76yRvqau
	 KvJZI3eqnGd+PnvMOP+on8YQz3RmN+iqP6l01Kv7HeryJ5afooco4lRXEvQaZr0RraGxA
	 Qk8DeynDCeQz5rh5XMMaokDvIOJJTd+K/XKDRiKv7D/IgwBoYIComXKoFlKF5SocX7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388607;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SjCTJIdrUaZqb+/BC8WM1DYxfIdbJM1w55fNRx5CsMY=;
	b=d0n5u5WuB3ZHN3qWhebIfrRKAWdH5mvA4zrA8zABdryUQ83l/DY+ewSLOwsWSoNzirFj
	 e5XpJJnKMbj/44Uvc/vHY4QkX6RYiIeqxAH0joEGPHjyWuBuEMB3oP0TPa2fAxgTQgehv
	 zbKZeGnrTZoV+xSvXx3kK0XNIqulxA1a8owX4tYlDnXZ9KoDCRemItoKgh9UhJu3ZHtoa
	 4Q9+HCI811Mw2vsui0I1R6Veu6obl4d18IL6BVXtiaanNIDtowlhda9+qVtFfmwBmK3DV
	 ftvX6+X/2uuyXdLF6o4FpM6hRQJAksatmrAerVcBjB+xelnDowLUYAz0jUaIeMaNUXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jMqMQ/F+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD2606A31C;
	Wed, 11 Nov 2026 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMqMQ/F+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93FC1F00A05;
	Wed, 11 Nov 2026 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388607;
	bh=SjCTJIdrUaZqb+/BC8WM1DYxfIdbJM1w55fNRx5CsMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jMqMQ/F+i7XvEnoLCVxBn4KkTxNZl1zsCZ2ttQh+9adYSA8l3TtjPbMetLKQc/TXw
	 d6aKHRMry4fM0Myuy8hJL/eFwJlGzwBGa2Z0lwMfz1rPXXI5UJq/oxCcrRiUOyxR7X
	 4ahEqcQ9UlcZgYJ3tjc0+1cGRgyLPiVb16itAS8flJBx6q9TsoMl6axC6RFyCdodDS
	 QUAkHTQnBJ7v3H9SYPUQFFPCCD4H+nKLF2hLAAnDmCXXClHiKlzItzq2DKVD0IAsFM
	 q5nWWSPhET8dfCq3QMD9C0OH4/6RXuzeR054FG1lK3TBiEz46S7HqyNtIwilLN+ndu
	 BdP6z4lk3iCYA==
Message-ID: <e179b228-3f18-4b99-9c54-93699d13e63b@kernel.org>
Date: Wed, 11 Nov 2026 10:16:38 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGDn_VIO_DP_{TX,OTHER}
To: Paul Elder <paul.elder@ideasonboard.com>,
 Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com>
 <20261110-steady-kangaroo-of-mastery-5fcd7f@quoll>
 <179438844820.272237.18262716067322018404@neptunite.rasen.tech>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <179438844820.272237.18262716067322018404@neptunite.rasen.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/2026 10:14, Paul Elder wrote:
> Quoting Krzysztof Kozlowski (2026-11-10 18:30:50)
>> On Mon, Nov 09, 2026 at 10:34:22PM +0900, Paul Elder wrote:
>>> Add the CPG_SGDn_VIO_DP_TX and CPG_SGDn_VIO_DP_OTHER clocks that are
>>> used by FCPV, VSP, VCON, and DPTX cores.
>>>
>>> It should be noted that there is likely a discrepancy regarding the
>>> clocks. In practice it ought not to be an issue as all the clocks derive
>>> from the same SGD1_VIO_MAIN clock and none of them are programmable or
>>> gateable.
>>>
>>> According to the datasheet, the FCPV[BID] and VSPD cores use
>>> SGD*_VIO_DP_TXφ while the VSP[BI] cores use SGD*_VIO_DP_OTHERφ.
>>> However, educated guessing suggests that IP cores in the same pipeline
>>> should be using the same clocks:
>>> - FCPV[BI] -> VSP[BI]:                  SGD*_VIO_DP_OTHERφ
>>> - FCPVD -> VSPD -> VCON -> DPTX:        SGD*_VIO_DP_TXφ
>>>
>>> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
>>>
>>> ---
>>> Changes in v4:
>>> - Add all the clocks
>>> - remove DNI
>>
>> What is DNI?
> 
> Do not integrate. Most of the patches here were DNI in previous versions
> because they depended on a lot of downstream things, but now those dependencies
> are in the process of upstreaming so these can graduate from DNI status.

Upstream clock indices ABI does not depend on downstream at all, so
seeing this unmergeable is just confusing.

Best regards,
Krzysztof
