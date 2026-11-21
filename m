Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795251177;
	b=orLkComu71oPAPlp64gKB8Ww9riS1T5BTUYIdTCbYUM9X0YNlFWB9iWOKCIlPEKiNzYY
	 gTGaewZq26EcLcVSLTqgZY8w6T7sXAk/tziQ1SUJMFRIZoG8VElCLBwJ22lyU3I5/L1kz
	 1uiaamLIcvPOFWZ0cMWi5HJGs1lU7FTiDwF0oMQGjPt8IbvxU0mZLXtF7yTThaVb0U8++
	 wQ2LecAklO1rR1D12lbLGrM5LXFhagzbnkwzgaH/yPQAgBXs6MisGS+HUgmcuYOhuZiP4
	 Gx3lEu4X0Gd7bs9mKqU6qxi1tez6dkg9HpJh4cuqCRP7p+d3wS+A/vCO2g5+Z4kzfng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795251177;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qFuObFh6gdVzuaDUs7dmE1TkHEa1cVklXsowoihWQAo=;
	b=seGoqrVdmHxeuNkN5Hdkm4rxdIXDYU1ulGwE0X/8BWT6HhGnkuLhyq8zBNaARUFdWKYE
	 Xikggu9v4HGEOdyFAhpDMs6F9TV6YUK9NuhJdUIBYspqc3UTV1ZGakKrUwL2akL1vRaVQ
	 6N/Oi6P9YygI7jZaYapJ6BdXZtphC7qcHayrtE2QJOvQ8Vk9kcIPcH8sv4z3RjNfqGf6J
	 7Omho/gJXxqCAwFgxjMXBKGMWoJkizVOX5jZ3gajaOs3lPf1cK1tS5AB4/DSJLWrGk+ft
	 rMOs9pghv0xR/fQz8WCtuYCt6znLcID5W7HF+qtut0HneX7tfLkvPi8FuVc0FtsKtxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a28mZSN8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A615606A320;
	Sat, 21 Nov 2026 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a28mZSN8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71021F000C6;
	Sat, 21 Nov 2026 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795251176;
	bh=qFuObFh6gdVzuaDUs7dmE1TkHEa1cVklXsowoihWQAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a28mZSN8DlRICUIFkZ4vpHW/3qZiBho2ZWkM1TD3qFDfLB61t4hApdcyKF4Hcnr0U
	 EeWt76AnxvuzjC/F4+dZQUUtK+Ebd/lqyBc0pK0BxTLVqaQ8+BBHYitBB6PmQP9KZd
	 NjDzStUWSQIvuRRMBVnSH7Kg5VkE5S7WsVW+hQfwTwnhQ6PQopslAFxE8uMU6+mhX8
	 Eqrh+pBhkppeTa+ik+j2AAHhDTKfZcVSm6wxFG8ybvBiVcCm6CXvOQ9CGwrM6SUN+T
	 V86OHfQWsoHt5y4gnXpg5zRxBQUxx0ci8n5e1+1UvBRGPDxGqc2gTA/UEuHAOWPlmj
	 ZLsfAEE37yBaw==
Date: Sat, 21 Nov 2026 09:52:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <20261121-naughty-dynamic-jaybird-cdfecc@quoll>
References: <20261118-icc-sm7250-v6-0-a06ec15c6e29@brar.si>
 <20261118-icc-sm7250-v6-1-a06ec15c6e29@brar.si>
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
In-Reply-To: <20261118-icc-sm7250-v6-1-a06ec15c6e29@brar.si>

On Wed, Nov 18, 2026 at 02:50:16PM +0530, Ishu Brar wrote:
> Document the Network-On-Chip interconnect providers of the Qualcomm
> SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
> Bus Clock Managers, and add the header with the node and slave IDs.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  .../bindings/interconnect/qcom,sm7250-rpmh.yaml    | 176 +++++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++
>  2 files changed, 324 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

