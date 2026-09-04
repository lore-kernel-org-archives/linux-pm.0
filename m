Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFA2F8EA3;
	Fri,  4 Sep 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530638; cv=none; b=QdXMruvIZnohSUPyMbgOrdW2UvhoW8sXZxIH2smSHzn1pJ1UIHhJWx9dnKJD4BJBEwfoY4Py1xQu+oDJcvES3pL5CQi+vIH5KjNSdDdl8IP6Zjb5awgc0QYDivIDUMtvs6/eV1qr4GcLTOwbvV46c7Ity5l0I6xxl5Y9WnHe9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530638; c=relaxed/simple;
	bh=3D6qmYGQsezDyz+JwryK1dLuhpk82sVefdhUWAESihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhCOul802n9cNnXCl3RL/UNRyglxC6r6S30tHTTJvqGex+sMtOE29D5qx87tnfjRm6sSrL9K0UfvWRLXGisEj9hxF3FYX6PiTCG5MqfSLk9VozJzQCydTbVpBbSXcXwEsG9x8px9cVsNS0GbCgS0bR7wFoFdZbAivYbbXM88RXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXKnfzVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXKnfzVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99171F00A3D;
	Fri,  4 Sep 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530637;
	bh=9xRAoQ3VOKVlK28blytp6VhXdyGPJ3aJEstmecZCKm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kXKnfzVXW4rNnRI+vPMis1N3J4Z0DJbAzLB2Xk0YQIFhh9SbKUiWfLZb1n9N2JXy4
	 dHkIMcObIUxZRUwbNdzkAZ59AugMx/fb1CEVDwqZJRnX09QLpn1/BpOVlrsgIi3wZN
	 oH5cRcGMHI+iA40/PnyE6qChmDnffEfpMgxeFPQniTt/Xnu0YW/Lwa6hzH0c452ASe
	 mtauknshUE89obVWddAWre3+3iPzcqJ1TxE4stY2QUp2EJD8MHcLeCixjx/ZiB2nE3
	 DxsSe7CiV2CupcAhOiUkCJl2UfKKMGmdmzHoMKfqPe20686M/rUi6+gDs6kdioeo4W
	 HRiLdLX+fSQmw==
Date: Fri, 4 Sep 2026 15:03:51 +0100
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
Subject: Re: [PATCH v3 02/12] dt-bindings: power: renesas,r8a78000-mdlc: Add
 firmware property
Message-ID: <20260904-real-owl-of-business-f4acdf@sudeepholla>
References: <cover.1788338320.git.geert+renesas@glider.be>
 <f1bb6566f00a06df7c01f43e5329b754a32620e9.1788338320.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bb6566f00a06df7c01f43e5329b754a32620e9.1788338320.git.geert+renesas@glider.be>

On Wed, Sep 02, 2026 at 01:29:18PM +0200, Geert Uytterhoeven wrote:
> On systems using the ARM System Control and Management Interface (SCMI),
> Module Controller hardware registers must not be accessed directly.
> Instead, the SCMI message protocol must be used for inquiry,
> configuration, and control of power domains, clocks, and resets.
> 
> Add a "renesas,scmi-firmware" property to distinguish between systems
> with and without SCMI, and to indicate which SCMI firmware interface
> provider to communicate with.
> 

Same comment as 01/12 and the NACK.

-- 
Regards,
Sudeep
