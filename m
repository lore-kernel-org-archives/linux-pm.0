Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDF3D810D;
	Tue, 21 Apr 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779393; cv=none; b=gR8g8LvQU35GExwyTQDkv8t35xk00XOeUXP9v5vHaZlt28Oi0vbQjoK3UokscxpM12G3kAtocJqnzeRay6MegS18MiT7QWbQFeSyUPocuVA7nQc9vUxyTJ2B2Nj6+aInRVbLVb3cIBDzGqRPJya2LPpiMwjaJBLKfsY78eGJVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779393; c=relaxed/simple;
	bh=yFGp4q9dd69vORspj/F4Kgjs/Fxf0CHEPtkH/U80wYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxEZ+rVA5f9Eqzz7/jQV4NPGCCxPAXDaqCit5uaHJf6yv65J8+AtYEio8lnjDTvDSdUaUC/Vy0TATiqke51k5vQs/aaSNotOUF3gvALKzY3iXWc4Rv+74qZV2pWEHcW+AfhrzlxE5yoQ/wSUDytzlF+XEsdg57VOeUj1T5rwoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL5hElqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL5hElqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D90C2BCB0;
	Tue, 21 Apr 2026 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776779392;
	bh=yFGp4q9dd69vORspj/F4Kgjs/Fxf0CHEPtkH/U80wYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL5hElquKB/bBDpkBst9KuxNe/vUGmfdKnY1xzsF+gF3YR/LajhF61fFEo+0eM1sA
	 /ynJ0kntn/yKhTPxKyli4lZ+dfY82uM8r0ADwsXoPbP4ZljFqR6sHUgxo6CC+MoGIQ
	 ucIK5DU2TqokF5jAF4AD+wbEsM4TD1+gUuFyV/1ICl3Yp7C1xLidR+5iGnbkIPQ1+h
	 Aj82dL8R1tiDtfwNkgd+3CcZLpWvmP9A8YYR5Vmay+S1PR0fYNKHLssFa5EGAlvuZx
	 noVkGWnOEdEnD2mS+RdxPnLEJru8a8OtSncEcddiojDjFYakXhOpyIjkyCqxUwdCfZ
	 erqqxXkxYkBJA==
Date: Tue, 21 Apr 2026 08:49:49 -0500
From: Rob Herring <robh@kernel.org>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: Add power-domains-child-ids
 property
Message-ID: <20260421134949.GA1045294-robh@kernel.org>
References: <20260420-topic-lpm-pmdomain-child-ids-v3-0-c2c40bef238c@baylibre.com>
 <20260420-topic-lpm-pmdomain-child-ids-v3-1-c2c40bef238c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-topic-lpm-pmdomain-child-ids-v3-1-c2c40bef238c@baylibre.com>

On Mon, Apr 20, 2026 at 04:51:17PM -0700, Kevin Hilman (TI) wrote:
> Add binding documentation for the new power-domains-child-ids property,
> which works in conjunction with the existing power-domains property to
> establish parent-child relationships between a multi-domain power domain
> provider and external parent domains.
> 
> Each element in the uint32 array identifies the child domain
> ID (index) within the provider that should be made a child domain of
> the corresponding phandle entry in power-domains. The two arrays must
> have the same number of elements.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Missing my Reviewed-by.
