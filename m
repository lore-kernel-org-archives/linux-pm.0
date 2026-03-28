Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84C38F9C;
	Sat, 28 Mar 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774700446; cv=none; b=hXyWZv9hCHLZXloeasEx/qKnVzEJA+2cnbhKq1wgpkTTYWoLTZ4yHkt31C5cS21mfnyQSiErFdk9ZviHw+ksUcw6p8+yJA/7FYM+BmrY5nkMG7x4GhgCRwmYZwUw4vAFy5p4+w5u8olI1GzmIE32LARztFQ+yoISq+2fpDjZbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774700446; c=relaxed/simple;
	bh=DHdUee5EQQApDzdHZV7Xcdjs7AAZnpLSmGYqbs6KVZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0tvuxsLojE/TNJ+oBtU9xNuamjbcEIVnnVq3yJdD8A5ZCgfkDFagtAJh00Xsgf1kc5+c4W6bk6TLBPA9JqjJdBktg20pCa6L/RVCNgoqxaHH3EMWjvxhuAtfVdAg5lnZgxJaVYXa9b9ZJPxcxtvsLESehQjVbzynvncXSBihos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGTojrbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGTojrbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC7FC4CEF7;
	Sat, 28 Mar 2026 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774700446;
	bh=DHdUee5EQQApDzdHZV7Xcdjs7AAZnpLSmGYqbs6KVZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGTojrbjKnKObv22HJgr51qAhyOU5EUsI0OnJEae0hXRp/5daFXVvLRu49cSaUucN
	 g0sL8grhuTkWuH+e3xejVKlFpwk9N7zE2nDrFPNLeA/UwBlYKCP4ijTKfsT/ttKiZY
	 WRKdSn6v9+hHi4EdgFB2y2+gkdzhRCI0REBeTH4Q2tXfC0Y2BcN7OtVOidW48XpM/g
	 47kwD5KQO60ma5pVnkA8hRdkEZHo9bLHWmYKg9W5CX1QII23CXaxGHWyLRO/ZhnZDp
	 6L1RAe/wpZY86dBzs1W4tXat9YfGngeYPigTcTgvLT89nR6SWgau52Gx5ban4qxASC
	 knFH9N/S/Yx4Q==
Date: Sat, 28 Mar 2026 13:20:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: thermal: lmh: Add SDM670 compatible
Message-ID: <20260328-resilient-smilodon-of-improvement-a8619f@quoll>
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-3-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328014041.83777-3-mailingradian@gmail.com>

On Fri, Mar 27, 2026 at 09:40:39PM -0400, Richard Acayan wrote:
> Document the SDM670 LMh.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Why are you sending patches already applied 18 days ago?

Best regards,
Krzysztof

