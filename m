Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D23394478;
	Mon, 30 Mar 2026 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855292; cv=none; b=Z/fa8kH6swxaCN0R+O9Ovg1JaYOrz5ZLn9t4t53R82+SfMHsAyvxj8sKTYUAFxxMRB/L0FAGFLvYhjCg2lcmoyhHBIjmtzZNkhrURrd/t6GbAfyqCFfPHCCrRfUh2U1oOKIZGkB8U146YMdk+Br3tk+9eIlZXHS3mYvUoRur+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855292; c=relaxed/simple;
	bh=o3Et1NtRWZGCHJSScVwUEUiAkoBRhbPjg9+RqO4e9+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMEQoFrWLENjTUcJNqIcL8BmUeDJV/uDy5w22kB4d5CV3DzixxP65goTavYE+MkPUjSm/FA9UP7Wzw+7Y/SkaMWaa/XQXYxYe6dx1YcMkAf4l3Dfun6GHlUi1bG6x33KDoYCfU2xX1dNST6gxcIiGu8dCtzQulOWc1How4C43dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkVLn3lF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkVLn3lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A8C4CEF7;
	Mon, 30 Mar 2026 07:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855292;
	bh=o3Et1NtRWZGCHJSScVwUEUiAkoBRhbPjg9+RqO4e9+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkVLn3lF1YQszaC8FfEJhY0ghQja6SEHTjE/W2px2PnKaRX0LJv7TUW2n82nUA9E+
	 BGpKs+0qf/IeFHb2arM+7tEBLL2QRpvd+HfPXiRHUXD3nDEVU+rjyLrsagNzixYY9L
	 lqBJUP7I3gmIcBjNO8cjHXQbBVP658zFeufe/uWUWweYASqj0q4aLUcSlHGHaGIM2C
	 D9FX80lmBQjLBcJ+7TXlimEteOuPF9+jTmsQU0Hze0sqiDeR+dWdVa8cIzV6VAft4V
	 0nF7aE2xQR8UNhDj8QvyWIKMl5aWpK6TtW34gMguWm9CjGk45wBXdC7c3sxula1ksC
	 29LElVNPan7tQ==
Date: Mon, 30 Mar 2026 09:21:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khushal Chitturi <khushalchitturi@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulli.kroll@googlemail.com, linusw@kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: reset:
 cortina,gemini-power-controller: convert to DT schema
Message-ID: <20260330-premium-pastoral-labrador-58f0a2@quoll>
References: <20260329205151.15161-1-khushalchitturi@gmail.com>
 <20260329205151.15161-2-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329205151.15161-2-khushalchitturi@gmail.com>

On Mon, Mar 30, 2026 at 02:21:50AM +0530, Khushal Chitturi wrote:
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gemini-poweroff@4b000000 {

I gave a list of possible names, yet you chosen different one. No, it
does not work like that.

Please read the feedback and choose one of the names mentioned there.

And next time please read DT maintainer review feedback more carefully.

Best regards,
Krzysztof

