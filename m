Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938F497B70;
	Thu, 17 Sep 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639646; cv=none; b=r1ztHABYnYnFs4N4F40q1HCjL8gfaxvrPzauYUZV/1LrJqWW5RWd9RSwbK2cFLNSQVwn0fPfcRc4ps/s6Af4xVVXJgyUGluORsz5+bQJBUpFvudLqGQll0+uOHYx26KEpi/eYIBpvsr05oc1CQ9NBk9liPqPX6EBSmcuFxR1w0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639646; c=relaxed/simple;
	bh=vr78XkyUyNz4FhQ+rZDpiq0+MHJb0qYrj6xJoq7cUAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbJeKwIOyjoIlSgw3VVAuqG1N4hsSOiWsdUIGr48FfWXEAvrlX+xoSXy5ssNEGmEJJTSpgf6Q7TNZp0jSTQGDUWdp29ARdfsdnOQ1+HjZZKiA9In4qu+Ig2vGBd7aj1HhelPrkvzJ8DIE3yZbKoI2JZ4yIR1ytiHVrhOW0ca9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwcnUwFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwcnUwFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14681F00898;
	Thu, 17 Sep 2026 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639636;
	bh=vr78XkyUyNz4FhQ+rZDpiq0+MHJb0qYrj6xJoq7cUAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EwcnUwFmhyTCZmadv/3w9YiGD2s9RKbonJTGdei4qoe2ZD7N82N5eTyo7rkXyjurF
	 D32B16rXse/DZnzV8E2B71vysZx6D/rUKvmqVHb3NjVjmBz8ClWAZY9+s7Tj4mMejz
	 ip8lF70SNbXfmWnaDk1ZndvD0VsH/JI6bcDCbFo/1ztp7djwFxW2zLzYMD9WqQQ0/z
	 cjr63EfBa0/91KVSb7Dvm8hoNyWUN0EUCDf22JaZKXPsFBKICAzv+zi/VJjftqIJVD
	 VhhFH6iYuW/hhx1uXXHYTletk1DmQXR8+CHLGwm7pn1UAECHgOKd7L3ByDJMGN+m3s
	 PfUc5CUP8zStQ==
Date: Thu, 17 Sep 2026 12:07:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Zaikin <zstaseg@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: qcom: add
 xiaomi,taoyao-pmic-glink compatible
Message-ID: <20260917-sticky-sheep-from-pluto-adf65b@quoll>
References: <20260915084901.56622-1-zstaseg@gmail.com>
 <20260915084901.56622-2-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915084901.56622-2-zstaseg@gmail.com>

On Tue, Sep 15, 2026 at 10:48:59AM +0200, Stanislav Zaikin wrote:
> Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
> battery manager can be matched to a device-specific variant in
> qcom_battmgr.

Previously you were asked if the device is compatible with qcm6490. You
responded about something completely else - that you need qcm6490. That
was not the question if you need it or not. The question was are they
compatible and you have entire commit msg to explain that.

Instead, describing standard Linux device driver matching in commit msg
is redundant.

Best regards,
Krzysztof

