Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA782609CC;
	Tue, 10 Feb 2026 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692514; cv=none; b=PudfeQgC/h6j6EUZgfVwNS2EM1wvNCbG5NSER0XhiZ9CZATNmQci9oD91L7ZvR4j44FjGMXGdWmH4kZx41Fn9YMYiSrdylvEklnA57L5tOPKst68hrhMUpRjdvOTFGpVFiLROei76AqX30euU25NBsktF08R3lsaWj5LrGxna6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692514; c=relaxed/simple;
	bh=frPl4usYlQqGIsrrNy5o13EYIbyiXuu0fap5YU28BWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2uDvZrczE0DJk/E/JUZLnjldkOBRRqoeBtQwh5sdt4OO7EQrJExKDAHXTYnTelYf2Ex+yyVh2rYDe9q+izUNbz7CKUVJHEbLq+gCuZPYHKQ/hznm/6m+8IJUAJmxxFXLj6b0s6DgZNq5aUCE+6Q5S9xh6n7Ft6cvAgZeFBx+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUSkSNMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUSkSNMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BACC116C6;
	Tue, 10 Feb 2026 03:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770692514;
	bh=frPl4usYlQqGIsrrNy5o13EYIbyiXuu0fap5YU28BWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUSkSNMZqB/fb+TxFsNqaVWSLJk9VlA8td5u4PwzER1jbj3G24CRDvqztZOVo0en4
	 EqlTOLY8XVbuMotgqJDh4Oz5iZx1Dj28bYlGNC8OgnbRnCMCp4U+NYNngvsAesr+ne
	 VlweJdSMh2+nladrAUudHutDIhPXD9YAPSgIWxzmVHelBTmjqHBtZqme7W5ZMmVCkN
	 onPQycUwgz/chY3GZvNHgTpLT8+QTyfGh5X6O/4XTNhubKZmhXBRNoWpqVp9ARW08u
	 yh83zniKp7M5Y1QKMtN6DtzRqKiW6MiHEZeLy//9LCgwdWJsWq56GKzI5eIHdxT1Lf
	 JyTbiSvwGy4pg==
Date: Mon, 9 Feb 2026 21:01:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: document Samsung
 S2MU005 battery fuel gauge
Message-ID: <177069251253.2405130.4990998712270853754.robh@kernel.org>
References: <20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org>
 <20260208-s2mu005-fuelgauge-v2-1-be3af8969291@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208-s2mu005-fuelgauge-v2-1-be3af8969291@disroot.org>


On Sun, 08 Feb 2026 23:22:30 +0530, Kaustabh Chakraborty wrote:
> Samsung S2MU005 is a PMIC device which has LED controllers, an MUIC and
> a battery charger. The battery charger is paired with an independent
> device connected via I2C which can be used to access various metrics of
> the battery. Document the device as a schema.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../power/supply/samsung,s2mu005-fuel-gauge.yaml   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

