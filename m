Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC854A5EB7;
	Fri,  4 Sep 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530593; cv=none; b=Op8bkAN6Qk1IuXhoJUBeVJhHG7R0b4a6q26j9YZw2349/LCdRcWC4ECK+oTbkVkKhE3DiybTW4ufbJD+MD8gFeT+T6Dfa2f6226wSyNFKe9DNXbr6O2c8FlyPIlunpvvR6gG9eKEabHnY1xcAhldLR2ug4HuKFabDADJnb/T8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530593; c=relaxed/simple;
	bh=6Kyi3VbYTBSqgP3NOm8++qUjk634PYSgsFaDAflKNCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7qjhUlwpaM8nnC98my9FMwACDcdaBc26tAQqWUquEcdPIuJVrqsy7g5l98Ahjp0Dr3E9TTsIG6zLvmP5oGUNJLyJT/v9DI9M98kpyXXn6uQc5OIOoHhsnKbO7dKyZz8ecmC6PVwG+SYsCAyJtD7ncFHwxRVGfFt0e2sqDY3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhBqUvTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhBqUvTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E454A1F00A3D;
	Fri,  4 Sep 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530592;
	bh=hgBXpaDcb4NRs9eQ/sGIF909WzqG0ZZiLKbm/sLhDrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JhBqUvTKrUX0YB65XZJglD4qAlprXVCT2lGsM4vm+2Vwj6+H1V6CeCT3AfdAuPdwf
	 R/xPV+l2CBFljA/jzPS5YRKf/Myf/ZqLw21IGhVqMo7CpFurChwCw3lj0+2Ow42FoW
	 lRtFGOWktFHcgcXb773ITYcHXULWpxDdyBv08JWp9nB5zb6slzQyoK7LnCbgLDq+b5
	 n973iaTa3okQU3IlC26xsG5vGv5hf222M+Hv1VTiLALgmYLVpxUsll+3CiL1sAsatL
	 MjtjpE3waWKsLax//JR2ab22qYzeYXPe7+03Z+1s/yxMPyAsDLVu/bJNCop45R7RCZ
	 Au6lcQ8cNZGKQ==
Date: Fri, 4 Sep 2026 15:03:05 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clegoffic@baylibre.com>,
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: clock: renesas,r8a78000-cpg: Add
 renesas,scmi-firmware property
Message-ID: <20260904-fabulous-lionfish-of-cookies-0d614c@sudeepholla>
References: <cover.1788338320.git.geert+renesas@glider.be>
 <2cf42d7ef9b452efbab3007ec2c2340cf87adbbf.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf42d7ef9b452efbab3007ec2c2340cf87adbbf.1788338320.git.geert+renesas@glider.be>

On Wed, Sep 02, 2026 at 01:29:17PM +0200, Geert Uytterhoeven wrote:
> On systems using the ARM System Control and Management Interface (SCMI),
> the Clock Pulse Generator hardware registers must not be accessed
> directly.  Instead, the SCMI message protocol must be used for inquiry,
> configuration, and control of clocks.
>

Why is this node needed in the devicetree at all or why is it not disabled
so that any driver in the OSPM is not probed at all.

> Add a "renesas,scmi-firmware" property to distinguish between systems
> with and without SCMI, and to indicate which SCMI firmware interface
> provider to communicate with.
> 

I still don't see the need for this if you disable the node, so still
NACK. Sorry if I have missed some discussions, please present the information
as part of this patch in the commit log if not the actual binding itself.

-- 
Regards,
Sudeep
