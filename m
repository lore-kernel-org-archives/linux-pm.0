Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AF34FF46;
	Sat, 28 Mar 2026 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719088; cv=none; b=ZzDVSXr9Gtcg5sE7uiJHaNSgIGzVpNLmYA8fKa3qfSmoZrDJ0z9PAh+U4FLHvYQtNlHfXGD22aw0JY+y720doQGqgoL9HXrxeRa8osbJRRrdjVjXDhplYW2NGGIejTDpo7PXypaxPW9cmLz7TA83+YB89ADA484kGSdkcK46wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719088; c=relaxed/simple;
	bh=K+vUmQhAIGsSqhrS0LhDBhv/V/cadK9T+dtB9wI9b1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJu9TY4N7M774NArYPw8+FxOAOqk+MOsGRLr1zDyuA4spVFynIOo0t2FFfuwwSv+pXHHzmrfMhu1GHWNim+1J97g4Mk6JNPEIuWDBcwVvlqA760seVd6PdLx2RHBGmQgW7ogiInr3pejJ35dhy9KaF5xURmU1VmBCHA3avgxesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMiQAVXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMiQAVXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FEAC4CEF7;
	Sat, 28 Mar 2026 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774719088;
	bh=K+vUmQhAIGsSqhrS0LhDBhv/V/cadK9T+dtB9wI9b1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fMiQAVXQm2QGxAsqRnQBGAkl2Qw60qWc8xUg9HdW7vCAP7vZEyEAHcMEyiIyYKvSq
	 btGucaYrzkL5T9areXXKkyBzWCcYMi5cCuomqg/ZUvLLkKJfoM0XCIz1pi8xhP8qNv
	 gfh9o7lhqB+RSPDGNQdJpvr4Qi19rgJH3UAdG2rdjSkiGuuPLqKQckjvnqEZDakQh0
	 fENLESFZjFV1jf4UOtADyM4T1/hjRZi6au8Q1OcgJFqxmPRCNowMstXOLwdFNUOGfn
	 cQRdMqyLzeIWcEsmllqO10dqJbgK/mXOvirXo7ZTcmKWHwp1O1ru9x7JmMWhu3NC2L
	 vYs8gri9C4b2Q==
Message-ID: <3fa4fad0-d918-4de0-ad80-dad2141d2617@kernel.org>
Date: Sat, 28 Mar 2026 18:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema
To: Linus Walleij <linusw@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Khushal Chitturi <khushalchitturi@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
 <177470797266.1536342.6967120656934552033.robh@kernel.org>
 <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAD++jL=_rCmW=eSV0kvck50sC2xaQnGQoEOy=DNcwkFvvWYUUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2026 17:12, Linus Walleij wrote:
> On Sat, Mar 28, 2026 at 3:26 PM Rob Herring (Arm) <robh@kernel.org> wrote:
> 
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.example.dtb: power-controller@4b000000 (cortina,gemini-power-controller): '#power-domain-cells' is a required property
>>         from schema $id: http://devicetree.org/schemas/power/power-domain.yaml
> 
> Weird, this power controller does not handle power domains whatsoever,
> it handles the mains power. So it should not have any power domain
> cells.
> 
> Is this the result of some regexp gone stray?

The name "power controller" is used for power domain controller, so
that's why this name must not be used for other use cases. Usual
replacement is power-management, reboot, restart or poweroff, depending
on what is the purpose of this device.

Best regards,
Krzysztof
