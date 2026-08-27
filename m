Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D94483B9;
	Thu, 27 Aug 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833344; cv=none; b=ovm8alBOenl9Kqb9r2KSn8017lmicMUbB9+X7YDDKQlNPmSf82rM79hMdYhLuwxTBHgJ866OC0/mRN0ZAM6z4QCzZZNA3TcScUSoMDoMYyd4RVYugR8lc3bkRLi6HwMFAR7zH2G2MiAjXL0mEyOD+Pys5MkJxfybGyopaywlj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833344; c=relaxed/simple;
	bh=GMUVwGOzMqoxRP1wJ8cvGZNsmZ2mlUnZ2XK2Rv/ACFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icyOt7bkagVbl3069e4tIT7qimMbfIxkpXgIf+yHe3NySV49Vz25sosmzuC869wbHGNVHiRYRxddBpmhGyWxD2hLuki3sW/8g6ocXZuviae6NYB37kmHwIjxkfXBjohORw2wYo+U6WsyOIPrk1H5tulvCRHKJBYL0YVi18ghb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHiOqh7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHiOqh7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46901F000E9;
	Thu, 27 Aug 2026 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787833342;
	bh=mI7Ir8cW1HZGzrJ3IgYTBV4C/vSt21EnGOEbcNn3KgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHiOqh7Hc6UidV5DQSHUCuyQPRlT/1LcmtoaXOCgWNw3pwfOebHtmVjEWg03TFJl9
	 /ibWFHUAwgyIbj1XBYsfyQUfMGF/o7hLcWVRrgrotr2JbHmhyTt5qh+J8LrIZSJnUB
	 ShBey9nkwPM/fBCare/ty51WaL3wGiNJxg32piZilWMf6f+4e7t2PVm+LqVevgxsgR
	 D65rGuNiiYDYTBjD+Th2JBoDt7Wudemp5/dFJcUu5sS3xBWCQqKahy4UuKmhgaHKeR
	 M/FO/3gLgHBTWuHbUFUH7RBKvitxshy4w0z67OYYazfIHX1LlnTjXP2ze6lkOa5Js0
	 moT1GDautIEZw==
Date: Thu, 27 Aug 2026 14:22:18 +0200
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
Subject: Re: [PATCH v3 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Message-ID: <20260827-tiger-of-sublime-flowers-eb8f90@quoll>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-10-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-kuno-soc-support-v3-10-196e2b306368@oss.qualcomm.com>

On Fri, Aug 21, 2026 at 09:39:03PM +0530, Hardeep Sharma wrote:
> Document the Global Clock Controller (GCC) binding and associated
> clock/reset IDs for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Sashiko comment was not answered and looks reasonable, dropping from Patchwork.

Best regards,
Krzysztof

