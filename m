Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E3336885;
	Fri, 10 Apr 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805767; cv=none; b=djR9mjzYyxRqohcSAv26c4UQcKl72NqI//9kGUfL0+plhCq4Kde2gwxMVRWVPWzA+lAY4nJWug4dyI7znGrWsivQ1SK2fMgE5xV+kH7uUqOdiwaKGDMcT2wkWw53M0eq6GZDOFx3oR40hx2gHV1hucNYn+sfecdYASZexgG7VZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805767; c=relaxed/simple;
	bh=D+3VE7auXUwKDyDmy36ChnTT8wqPeJaS84T9tpD3xtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJc+RTqiHYivCyBEA5FJ4/1sgCTcCktUSSYiBxzbhxQaDYgTVU2cmj6dDOV2Ym2j5jepUoaKn0h0/Eb0aooXq8boZ/xWRw5bOhYb5exfhlUmzLPTLZfT/i87/4cMQ/EILE75yHrsVsxyXpmQgoSCsB83Xeq18Ps9iD5AkBSf6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmw478A6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmw478A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2AC19421;
	Fri, 10 Apr 2026 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775805767;
	bh=D+3VE7auXUwKDyDmy36ChnTT8wqPeJaS84T9tpD3xtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fmw478A6sxCwLi7h4DK2b6E/Lm/QXcLWUs34/gowxloEBgb2ac9+KGxSebf2L9R+H
	 7AecROkDpmm7hdxsNSmAXpSNRztcl9LkWxdQOtMwfelluRbEiHqY8slDpQqkV0RgMZ
	 hU2b71NGSvdoaM4a8Ue7JkzSAytVBfkJ3IZDTjY8tklusfmnLTrQWPfyAyql1U0jLi
	 oBZkj5bom6iH2DUhrrheaD1bnQGoQcpY8evaMfJuYrOc77S/a/Q/agUOoMUTnEgwUv
	 gSnlGqij8smQMRD1/68ut3rO4D6kRHudxx7ycK2ikT2vh7aFZytHXc2kadciNjv1Do
	 yPIxoW4v3anyQ==
Date: Fri, 10 Apr 2026 09:22:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Vincent Legoll <legoll@online.fr>, 
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal
 sensor
Message-ID: <20260410-inescapable-glossy-cobra-da4bf4@quoll>
References: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
 <20260410-k1-thermal-v1-1-12c87dd063c3@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410-k1-thermal-v1-1-12c87dd063c3@mailbox.org>

On Fri, Apr 10, 2026 at 11:31:36AM +0800, Shuwei Wu wrote:
> Document the SpacemiT K1 Thermal Sensor, which supports
> monitoring temperatures for five zones: soc, package, gpu, cluster0,
> and cluster1.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
> Tested-by: Gong Shuai <gsh517025@gmail.com>

No, not possible. Otherwise explain me how your device tested a YAML
file.

Drop all of such tags.

Best regards,
Krzysztof

