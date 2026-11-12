Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524110;
	b=S3LjnWlyi2SAWB9JHnhCt9B0t7phw/WECXJxs/AAuvGGgSSFVB8hA/AVjc0+kWYgNoey
	 vgnQjTHLvBbabV1kxSaT7bSbo04s2gUTZ7ttcZXCNwrKsLzJv/USSnzHJOFQbfycOvqUh
	 YobAZxd8pCoYdX/425uzkvZtJyFKOa1l6kpcsypzh7Epyvjcq446wOU1utdG4kv7IuqS+
	 vp0wLE1Qcrm2HJFnQpsVU4DApJ4T+CfjCAegD8Gy1coFSp78X40xi6e6/ZCRySUhNRNAU
	 isD4wH8u3qaLIGQ/v7pjdF4DUpGr3yVkzWdUf1J9zCt233gU5yVOzEAeudrVaqJPbZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524110;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wdopgnCjQ29+rPA8LQY/bcOlbV2Ic6CbKWP6Bqv1yTw=;
	b=2J2UZp0yrxrmkNdfxZzmsesxaSNHBUgO7ChUvwtfo+c5FN9yWm3V/rF5HcwK9q2mWqZO
	 6NdyZQuQ3eMemSHf92SOYD0WBrimCzthqbr8b/OfOW0sbBL/Dx8WwxMRMtDNyCTB6LT+r
	 6lPYds9/RR7tQ7dyE7xBf0z/RGMQHRzG1jFVewtN/i7dXFWcI+NGTFYa1cZp5dQHGdHpY
	 svVGuaL0PxloIJcvtOUMCK5/xpF0jCciNhIdZhlD9GE1rguYGXCcM5Agdcr4mje6466qy
	 jX8G17WJq5wT6fZl9eH4FsNE8jhFQXvSMc8dddOy2rnt+Ormfcv33ipc+JmLW6tKCZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5T3VC67;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C99606A8B2;
	Thu, 12 Nov 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5T3VC67
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E811F000C5;
	Thu, 12 Nov 2026 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524110;
	bh=wdopgnCjQ29+rPA8LQY/bcOlbV2Ic6CbKWP6Bqv1yTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q5T3VC67UcuPWA8nIYHVjjOlU5wxufWE8gsXYjzyoKZ9tkiQOCeSnXZ/al8IjpkWR
	 bIMYoY7ycyh3QN0XXAs42wfz5p/FHK4XOaws6xkuK4B3v1uU5kVrZGQre2qZMOyh81
	 RX2Qh3QY51gdUg3kr5RiRzG25NiETQ6rFbhe/T6hsuKmRNsR3fPFK4ZOyfAO7YViys
	 z/bhAJgwaF1Q2b6qv9Ce4eUC+2lnBR5q4sZqq7n1wtSa2uDqzEdrzyNOgdFxX35lov
	 flU4eSmQACeV63eynlxW7ckKFU/amzL28Zl7f+dGcahE1ov43Hu+6u6xstfEGdwQrL
	 ZdjFlrEwrsAtw==
Date: Thu, 12 Nov 2026 16:55:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: regulator: qcom,wcn3990-pmu:
 document wakeup-source
Message-ID: <179452410743.1850681.8370168094636709407.robh@kernel.org>
References: <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-1-linghui.wu@oss.qualcomm.com>
 <20261112072009.3815276-2-linghui.wu@oss.qualcomm.com>
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
In-Reply-To: <20261112072009.3815276-2-linghui.wu@oss.qualcomm.com>


On Thu, 12 Nov 2026 15:20:07 +0800, Linghui Wu wrote:
> The SW_CTRL GPIO can be used as a wake signal on platforms where the WCN
> device needs to wake the application processor.
> 
> Document wakeup-source and require the existing swctrl-gpios property
> when wakeup-source is present.
> 
> Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

