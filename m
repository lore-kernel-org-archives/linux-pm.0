Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EF3B47EF;
	Mon, 17 Aug 2026 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951483; cv=none; b=Y8F7nPVUj3l4bmeFmIKi3O/ZMnGq5aAKT7gcJJ+c/C8ShisTTwrrcWc1woqZJQc/MWIzB9Lpf/Y4hlqeXyjf58iMR6dJcaUGpVXhuiji/aJbSN12Y3mNS3P65TNCpnXc0TwfqMAOv3xCHL4pZ0vl2ahdonBt/1fNO+YJg50kMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951483; c=relaxed/simple;
	bh=LjOWqvMGUii1SXM7XIUOBDpu7O26MscvpM0eHv1J0kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IESBCaVBxunmqlOGfKP/QIsAWkw5GxHrWmZ5QF8HBdpW0xYOe8w3kfOK9N8jgQ97tSky3Ql04ln8f1mJGzuuWRnJkDZVUwQDzg5EfCyNOc9VCMg9IoPkXbr5S9V6OGTFv832Gjl8+clO0lEOL8clwZwr3Pm/Z6jx1cyq3d8sWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6sOaw1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6sOaw1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA01F000E9;
	Mon, 17 Aug 2026 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951480;
	bh=rMO8LuIV0y8D12iyq/Re/0Tt4oXaHh33q/C/GgUGEnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C6sOaw1aEDhQLzZOeimZ9ipiOQtdtT1SgXSTlohZzB+vXYYz0r6UxcX+3sJaMu2Pc
	 9rGz6n4ICR21RHHnjAssMLIDZ9AQy+ZnAJbZE5A7W30wt/dJNtnIKa2PyaoRhwuRjD
	 6QK+CxW4eDKadydfM+XL6TcUL+lXJO95PpSX243TYo2trYQhkHBU9RlV4wYbaRTWDE
	 hJW8GX+jwa8EY6S2yc1X6VC2HmLfa/YZvZdS3RYY16WA0iADzoR4b56m7DJQ9dyw4q
	 ZVAVp0jgREus2O18S8/K+wb8I/WpeYxtf+KaB7z++ZKFsmeQW/DImheJWuza6NlGa1
	 do5D+o1x0YXbA==
Date: Mon, 17 Aug 2026 09:24:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: power: rpmpd: Document Kuno RPMh
 power domains
Message-ID: <20260817-dashing-capybara-of-warranty-ddd469@quoll>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-2-3079794f0f73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-kuno-soc-support-v2-2-3079794f0f73@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 01:01:33PM +0530, Hardeep Sharma wrote:
> Document the RPMh power domains for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

