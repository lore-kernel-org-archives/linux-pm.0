Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8340F727;
	Wed, 22 Jul 2026 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726461; cv=none; b=czARkq7uh8XrCB2R3r4H4Jm/4CwjUPXXCjUpUsY5ZZEd/nQm5zmAjY/CElls9VuT+Foqh27cWOqlbnbq4fo19VOSMTkTyyHEam7G8e3603roS43IayBMVBII/LChwCGa+r+siT4iNbDJVRIOIStD1MmnNvdki6eRkNWjP4+quDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726461; c=relaxed/simple;
	bh=UnZV/LUYvIHeFC3aPz9elCtqJhU/it9MWUpSvPInfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elNbqkaBBwr10EONRUU8eG70NmOihrTtwwbclMzntseqHLLy0WOQMzRcWSpryilWjuhaChOpaJ8BQtT5ONgfKN3T/w6PQvsndXzB3KW5pD+E4lB9nuxp7R8PdUofGfMdqjI792NrlqAMVvBxWmIIQxkmAN9IXzqYvFYPtr9RF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFPc49IE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFPc49IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A621F000E9;
	Wed, 22 Jul 2026 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726459;
	bh=qAlNbnHnnY+rCKoR4N4oHsWePJ7rqAQfDgKBIG1J7gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFPc49IED1QI/OTrVYaTIixCKmd3bAxMGU/eYA9hwHC6OpvXki7fnsOJpl6CoFOUc
	 rdez07P4RBQhntdr28FaKT+3c8wlL+82Pf/kC1G73Qcj7mQScFf+Uu7VzlkJ+5PVHl
	 /o8HZRLTsnXg+p8Q9+RMCqI6KGtmg2MiTYG18xjha9AZaN5fJJ5ot8bc1r8ThfzFSK
	 HuGjc3KLxOitil2CSejcHTHzHIkR8osm0UmvNCxFtK27optrzWMabwKXyiCaS2Bnty
	 qqPMu53uATsEaiWQ1ciGePxwnYXcpYBkWQaTIY9BzZ9V91TzL+PYWhk9XUcnemaflJ
	 K0qXNp1l9SJZQ==
Date: Wed, 22 Jul 2026 08:20:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zhipeng.wang_1@oss.nxp.com
Cc: festevam@gmail.com, jindong.yue@nxp.com, xuegang.liu@nxp.com,
	saravanak@kernel.org, linux-clk@vger.kernel.org, ulfh@kernel.org,
	imx@lists.linux.dev, peng.fan@nxp.com, aisheng.dong@nxp.com,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v4 1/3] of: export of_stdout symbol
Message-ID: <178472645842.281535.12263465103149751658.robh@kernel.org>
References: <20260722082522.3747962-1-Zhipeng.wang_1@oss.nxp.com>
 <20260722082522.3747962-2-Zhipeng.wang_1@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722082522.3747962-2-Zhipeng.wang_1@oss.nxp.com>


On Wed, 22 Jul 2026 17:25:20 +0900, Zhipeng.wang_1@oss.nxp.com wrote:
> From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> 
> of_stdout is declared extern in include/linux/of.h alongside of_root
> and of_chosen, but unlike those two it is not exported, preventing
> modules from referencing it.
> 
> Export it with EXPORT_SYMBOL_GPL() so drivers that need the stdout
> device node can be built as modules.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/of/base.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

