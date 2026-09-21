Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C00472552;
	Mon, 21 Sep 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012898; cv=none; b=nP/FGKFrH/V2mmHzfn+cPW43ko4Kj8nZRwBb4YBdfJTGyK4veMmQvJ11qLFs5QjE52tSPvXw6MbKAcAJ+ZmLZ4MONfxplGUXuJmeYb+UvtE7tqhA7cU6Y0QRO5bWlwRFImv3Slx5Z8OxSl1SVeIRyXdIiinjGWzujFcH9kZ3JWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012898; c=relaxed/simple;
	bh=KZPtvRK3hQsJ+mIpMgbjaaXQ/4H4xq8qHp7QIcX8R44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edU52DYCHurHO9mYip3sfgmu42ZtP7gn9qAt3A4lCDhVW0wqUiTWut5zAP3YhM80qMHnjrSAJo5KfKONan2ZWZwlwDL6TPiluFx0R9EQEFJLpiXJvjhIhnsLC1hjs83S+AqQugy8vmP2txqOSBEy8xBM7RvzFC/tp0kSufhixYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwW//Ry2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwW//Ry2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD541F000FF;
	Mon, 21 Sep 2026 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012897;
	bh=jW6T+93IHenkNs/EDIYFHn3MV+AJ3TpaF36QwgB4240=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OwW//Ry2sZsOwmXrEwZ7eMErgkX6urs7KMDdzU6DekZfK6rL/fn7dkpWIe0oEnqze
	 IDVu62RGHLdc8KQsuh8Fl0FPgx8UYDA1BMv2r5ADBr47VR1650QBgTjtmFx+rIjRw3
	 9Gkoh52bWZ/t4IKy2cfM+DUGidLZmDOBIbU7Roxy6VsX51LSvCBjgzEWt1bql7+LBU
	 to93eHgDBJUq03WWTYIY680cQBTHIRl2u+aJ8oozWFehS5PYMW9p55Zw6lTmdKgD9O
	 78itSdAd3V3tzPcmxUEYYmGoTfBjJtztA/1PKvx/DTukj/m/xrmzLack8ro3RpXd2Y
	 kp+0xyN/etDEA==
Date: Mon, 21 Sep 2026 12:48:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L
 TSU
Message-ID: <179001289480.1069053.4231756852125236935.robh@kernel.org>
References: <20260911131629.111564-1-biju.das.jz@bp.renesas.com>
 <20260911131629.111564-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911131629.111564-2-biju.das.jz@bp.renesas.com>


On Fri, 11 Sep 2026 14:16:22 +0100, Biju Das wrote:
> Add the renesas,r9a08g046-tsu compatible string for the RZ/G3L TSU,
> which is similar to the RZ/G3S TSU but uses different calibration
> constants. TSU is connected to a dedicated ADC IP (a.k.a ADC1) on
> RZ/G3L.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

