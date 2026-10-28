Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192830;
	b=c4OTLu3O0caN7IvKOmxXSttReNcTcwxXK0g7YqyRqC4Nh2USBXrTV3bfphZt8YS1uPqk
	 K3gTPqFgOpN8mcnEdBMvSFytX4+JGAhsWkhFttXzAEXkIoqiE5TDCJrVbRcZqpQ04zVPj
	 3dsuhVYxLg9ssw3JvOqQtT551/ezjEO1j/uhxqQ07u21XKNQ83Sl4S65Sgq3KF9lwEy2X
	 hUkz/76zA9u16Im9rjSqK5Eui08Y7eczdtRQJggyLtQWdP9p8yoeoCPQtfQe4tzE7Lk72
	 rJwJvIRcYougQpdULF2KaaMSPBj9IQIH7JoPACeNuAdWGZ1fVlAQhMwhG3bhy1hBBkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GHlCkJUwCOHNDfNGV+Pk0+JrrHxYMGL+qd1XE/qEa4o=;
	b=c20MEvG5Ue8sJ4H4tUbPpAZKinc8Tjt/C64wThsQ3xUU/PBLCt/ICS7lT++NWxarhpRL
	 +F3F2tWyBruutYFN+xFhEiR1bjpTZFECBUMLsjJy5zwecRdyt9y/p44Vo7cSwnRpQRq4J
	 Wi8hk4Vsg8aKxNEldKHTTaljHN7hqCks7u67s8lzcOR+Dl0Q13+0OyHB3pwPRRMBxlnaE
	 urAeX+hOBv/rGqaUHbSSmUGl7nUS+xeQ/ZmKdQ9bnRZdONqtHaEDwu7zJ0Gh8UofDwBcA
	 wkyau9DiqgQyYYvE0y4sq004mcnSmYhNKIco9i1v/Ys6+2YqdXiTa6PdYYBwvuDPvwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l161vgEo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A1606A31A;
	Wed, 28 Oct 2026 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l161vgEo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665211F01825;
	Wed, 28 Oct 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192829;
	bh=GHlCkJUwCOHNDfNGV+Pk0+JrrHxYMGL+qd1XE/qEa4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l161vgEo62t7JuyBQhX5FlU50DZRNFFOo45oMz7hoo96Eu/I71d72qkHFoOvOH3+n
	 DkjskkfFszV8HuOG08UT1lcV2U0FnHcG7G7ZRjiMCrJjZlNwbkecbC7ubA/no937n9
	 3h5TdF22S+rterzEJGM2Pte1NDVnV7rBzGNyFeLtY4DcnHK9qZhwks7aR940K1xdK1
	 i0dah1QgQCuMqKy5m29zlY/UfZ/LAMwwGo+ajZE46fnGivknLBVh54UdarPV3s2QDc
	 qciaobqdpJGR//rfc8V2w0VNh8QAw0ZyuVmQeq4ASllzoK9ZFH8crRtcp9/5tOz3FX
	 6LrxtZjJ7XiHA==
Date: Wed, 28 Oct 2026 14:07:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM
 clocks
Message-ID: <20261028-holistic-ultraviolet-kelpie-ead6bc@quoll>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>

On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> Add definitions for the clocks used by the PWM modules on R-Car X5H:
>  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
>  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH 2/7] dt-bindings: clock: renesas,r8a78000-cpg:
> Add GPIO clocks"
> https://lore.kernel.org/624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be
> ---
>  include/dt-bindings/clock/renesas,r8a78000-cpg.h | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

