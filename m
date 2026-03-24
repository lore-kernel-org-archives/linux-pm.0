Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E253D6465;
	Tue, 24 Mar 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344381; cv=none; b=hhEi8CwkNTV2NMYq82i0fp9Vqb2H5/MDvQAQsqwGN5t4bVbOVg7vSmtXoDwZYOhQUpXVG+nDJmxpdSsi+QonN2IBcRodGDsgRTF8ZK9ns8b2fU/kndiWHHLJYT9lhAk4lyYUcoFjfgA8r7Nr0Ip3LA/TPeey2FOgqplIJnuMxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344381; c=relaxed/simple;
	bh=4kWn0YZJb4i01Ir/4InQFgfX4Z1CwGSc0CpGCKJSBVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtY575a6tip9xjPVD3L7saoV7fcIVRLYelR1Es3WDmo9zgjDyNvNl1idlSNl2GEO6l/pxGy+6PHjrXVZpgiMz6F4m1B/tHEMyaxPLeAlvpAK6rdnajtCcwg8LsQjXNg5+R3JDdK6YVBaEiGbRg3tAHSN3QgThG0wJz7Qb378vwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgbZ5flO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgbZ5flO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC89C19424;
	Tue, 24 Mar 2026 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774344380;
	bh=4kWn0YZJb4i01Ir/4InQFgfX4Z1CwGSc0CpGCKJSBVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgbZ5flOMOM0DOOaoa9asHdHwqPMbkAPF/BFyPi6SGFqxqv6LvKJRLnYf/1/cmxSM
	 GJq9ASMBuGA+274txopcYntJZ9cJ8uB0/dHPNqdl7xYFdE3LAsQlRtHyv7SsYddSgq
	 dRzSrxTc2MtnWiBtRov8cm8sNtXM8si3Q1vQkXtbUnsrrN9AYkarwHkK7Dpr4kdsEb
	 IBrewTBbkwRo9K1yLHOKHBjuun0ksO5BgNli5lh+UadJpc9NH06Gpvz5tHmc7Apxmi
	 uvvasKFHyuLzRTJnuLj+bqr14apLQwXmTd9afb6P1acgaSQrfYtWWoQ+UsEererpTx
	 vzNxi2GnGa5TQ==
Date: Tue, 24 Mar 2026 10:26:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 2/2] ARM: dts: st: spear: fix dtbs warning on spear
 thermal sensor
Message-ID: <20260324-smoky-radical-hyrax-1274a9@quoll>
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
 <20260323133814.14152-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323133814.14152-3-krishnagopi487@gmail.com>

On Mon, Mar 23, 2026 at 07:08:09PM +0530, Gopi Krishna Menon wrote:
> Running DTBS checks on st/spear1340-evb.dtb results in the following
> warning:
> 
> thermal@e07008c4 (st,thermal-spear1340): Unevaluated properties are not allowed ('thermal_flags' was unexpected)
>   from schema $id: http://devicetree.org/schemas/thermal/st,thermal-spear1340.yaml

How is it possible if there is no such file?

Did you just add new warning in patch #1 and then claim in patch #2 that
you fix it?

You completely miss the point why this change is needed: how could the
DTS work before? It could not. And that should be your justification for
the patch, with explanation why it could not work.

Best regards,
Krzysztof

