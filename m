Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8D37A856;
	Fri, 14 Aug 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738929; cv=none; b=itLIZEegaqrwbqqsSQtRYta72sUhzJ+YO3YXVkT8Rq5HUSCoSHjlcbjhJ5pO6vzRiJegX/EPTUGTKA004MEYlpz4E5zfENVWqaO/CyIa9NQRcaFECjhG1rNPinxWkXuLe6Z0Laiav5m7STCJCcp3gT/HpHr5v6DSVJ8+hwxIGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738929; c=relaxed/simple;
	bh=zUNsNf2y9kuX6xMS67+U0+b7r+5yCw1XGKh0sQ5iYog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDwM7mu6Qu9vOyBdQqKPPKoRps0KJ5L8tHDg86bruQhO3eTR1qrBEgy8elgWMkDJLhn707esJfKj1UjxgDMJwwt8CgwJoSiNA3lWnRcxfBwuQLtnM6AHSVUnDEwgZAQ3PrM4Drt++vwU+iTt3ojz0Ier5Uw+Dw6ycA0dih7vShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyHDbUyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyHDbUyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E641F000E9;
	Fri, 14 Aug 2026 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738928;
	bh=U7WwPaYP878YA3bgpBrJwUeCvXqg5kTYEtLuaRPAV2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QyHDbUyYyG3jxjofXuRK4iAj1L7UUZ99H920RB3GKDMnufXqEJtpA5Q7l8ANzu/BY
	 Tan6FpsXaxmKMbu01abTmuVBFtVKFmQJDAmdVe4Laqt4IUOBdlI5g0zlHEnhPYusRz
	 DRbVqDap4woKSNlPZfJYmGM4gIymJ4GZK8qqs4wFnZ6pfatUzi3P1eo/aVI+U9Cx/I
	 7RoBIDX9teUPqktbxoLjeyEivYA8m7+MYFxx6JWvRQUHsoTNbKs/+KPmwmk7abXZ2o
	 ssF8oCy+VWFxY5w49GdF4Pud9r7aayKxCNo7wUo5VM9Ya2PAzyTxpzGUBAyYpTVRMz
	 ic5l9WwltqXrw==
Date: Fri, 14 Aug 2026 15:22:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: goledhruva@gmail.com, Conor Dooley <conor+dt@kernel.org>,
	simona.toaca@nxp.com, linux-pm@vger.kernel.org, m-chawdhry@ti.com,
	Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: ti,keystone-reset: Convert to
 DT schema
Message-ID: <178673892422.2848541.3863969536161275751.robh@kernel.org>
References: <20260813-ti-keystone-reset-v1-1-189389503324@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-ti-keystone-reset-v1-1-189389503324@gmail.com>


On Thu, 13 Aug 2026 05:53:55 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments Keystone SoC Reset Controller from text to DT
> schema. no new functional changes.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../bindings/power/reset/keystone-reset.txt        | 67 ------------------
>  .../bindings/power/reset/ti,keystone-reset.yaml    | 81 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 67 deletions(-)
> 

Applied, thanks!

