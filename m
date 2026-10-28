Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194029;
	b=vSLetMjLG1/pYx08WIoXearC9YsPplD0Pm7/s+0VWn1NGfFXcVsrOd42CcPtvtLWauCc
	 O3yv9PETCptp4rxoXLjkYkeujBNpZgYm9wo/5ec4VQ4F1T1h7tplgdsoYB2AiUFywOOPb
	 otx21vZcJXA70IppBVZ/5QiIzfaLXYJDJRsp03Up+MhKk1Bmc9FI6CHxjQHLXrLBAbFfL
	 lov+l2Q16Tc2bOes0jTVL1tlKGkFjPiwV/bBXHMvD8QRtId7MCRSTUUQ6mDhjfitTeqW3
	 AMwyTsj8ACLEP5KSSmQyazFHaYNPBHg/5aqm4hCTgNBc9f+Mytwl52kKlp2PWXJvwhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194029;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vMqr/WjxL59z6An2wy+k/P9BR2xahkEslL3Eehl7UL8=;
	b=Scx+rPvtCsbLw6r3mH5kMdgWyYWac2QjBp4+csHlbRTr3V+J8SWa7EowbepAWICCEQWS
	 m42JjsGVfdLSGDkxql9oMtqbKd7rUeZldSdqg6di4C5LqBvFQoRAx9zsKmf3OLqzRKfnV
	 AdShQ6sfLUyTGh3it1aDxPHSh4JlvfU1vZ+fvSesbClzfhvaWC1v02CmQ66RZL+fga4/4
	 oBwWI5tCDophVNPr7gNP4B5fhws1Vfdu6CA9uyo/Gn8Mfy0OzYSoBzKpbkspytVgWmpsF
	 MVXc3O33eZi0ACmNVDBQ+2G1XFzyaxH33PB9dcv4Vs3MIAvfyu6U1p+/+KKO8n4snIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfIqenX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DD60A2605;
	Wed, 28 Oct 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfIqenX2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BF01F01442;
	Wed, 28 Oct 2026 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194028;
	bh=vMqr/WjxL59z6An2wy+k/P9BR2xahkEslL3Eehl7UL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kfIqenX2jebi6Y6d0XS41GtrBbatL7qSLdFVtoC/FGiRJ05BvyTM6EDe6XbdulFRZ
	 Ghg4UjZF9eSFAX/6GBn4L16vH080cVeCyRi/IiNnXzUKKm+vr7iaDC9pG+uI/aY0Vt
	 WHZnd+zZ3V7tpmdJFFwWDstRuCS8r4LTbCQ3o3gKxUyxWgO7E+ZSg4N7X/mA0poib4
	 XlxzLkEZpdG3FOU39lHwTnfgYsU+7w8FC3aXrAdnmggp053X3iVOAgZri4cbEJ3xn4
	 2u9W9R1ft+SswQiSCEw9ZbK8oHXM1kQb8A2dtN+XPWv39YyBFtfoxnC79wqY3wIIej
	 GZr0TE428Y/Lg==
Date: Wed, 28 Oct 2026 14:27:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, Mariano Marciello <mmarciello@google.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 3/9] soc: google: Add CPM over MailBox Array driver
Message-ID: <20261028-literate-pony-of-valor-3209fb@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
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
In-Reply-To: <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>

On Mon, Oct 26, 2026 at 02:43:41PM -0700, Brian Norris wrote:
> The Central Power Manager (CPM) is a co-processor on the Google Tensor
> SoCs, as used on Pixel phones. CPM supports power-management and a
> number of other features.
> 
> The Application Processor communicates with CPM over a pair of mailbox
> channels (the "MailBox Array" (MBA)). CPM provides clock, power-domain,
> reset, interrupt services, and more.
> 
> It's difficult to support all of these services within a single driver,
> in part because it's a lot of code to manage, but also because there can
> be complex relationships between the individual services. For example,
> clocks may have dependencies on power-domains. Instead, the CPM driver
> only handles some basic initialization, and otherwise creates child
> auxiliary_bus devices to handle each service. It also provides an API
> wrapper around the mailbox protocol, so clients don't have to worry
> about some of the details. This API assumes all users are children of
> the CPM device.
> 
> Implementation note about the "session" handling: the mailbox API
> doesn't provide any timeouts or guarantees about a response message, but
> CPM clients would like an (optional) timeout. So there's a little bit of
> complexity around reference-counting a "session" (i.e., outstanding
> request still waiting on a response), as that session may outlive the
> client's timeout.
> 
> Quick note about hardware queueing: this is implemented in our mailbox
> driver by allowing clients to request the "same" channel multiple times.
> A client is expected to keep requesting the channel until it sees
> -EBUSY, meaning we've requested all of them. We then utilize those
> channels in a round-robin fashion.
> 
> Because it may be useful both for reviewers familiar with the downstream
> Linux support for these devices, or for future developers looking at
> adapting/improving/adding further features later on, it's worth noting
> some major deviations from the downstream drivers:
> 
>  * This driver doesn't contain much of the queueing complexity from the
>    downstream driver. The mailbox driver was significantly rewritten
>    beneath us, to support most of the queueing there, and thus exposes a
>    simpler API to us.
> 
>  * No session pool; we just allocate sessions on-demand, enough to
>    handle timeouts while a response is still pending.
> 
>  * Use auxiliary_bus, with CPM services represented as child devices on
>    this bus. Downstream services tended to be a bunch of artificial
>    platform devices, with fake-mailbox phandles to the CPM "interface"
>    node. This is an atypical device tree structure, and most of those
>    platform devices came from device nodes that were less for describing
>    the hardware, and more for describing how we wanted software to look.
>    So far, I haven't found services that don't work as child auxiliary
>    devices. If we later have examples that need some combination of both
>    iomem resources and CPM resources (and so may need to live on the
>    platform bus), I'm sure we can add support for non-child (e.g.,
>    phandle) interface methods.
> 
>  * Add devm_* client helpers, to make it easier for clients to clean up
>    properly. (Hint: most downstream clients did not clean up properly.)
> 
>  * Reduce the surface area of exposed (EXPORTed, or header definitions)
>    protocol details, such as goog_mba_q_*() methods. Many such details
>    aren't used outside the CPM driver, so it's probably best to keep
>    them local until proven otherwise.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Based on a WIP mailbox API from:
> 
>   https://lore.kernel.org/all/20261023165211.v2.4.I5cef580a62c86ba6c3465ad336fa509afbdf1476@changeid/
>   [PATCH v2 4/4] mailbox: goog-mba: Introduce the goog-mba mailbox driver
> 
> which is part of this series:
> 
>   https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
>   [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver
> 
> That API consists of:
> 
>  1) a header (<linux/mailbox/goog-mba-message.h>), which so far seems
>     typical and uncontroversial and
> 
>  2) a strategy for supporting hardware queueing -- where the current
>     proposal is described in the commit message. I suppose this strategy
>     could still change, although it was discussed at length in v1 of
>     that series.
> 
> Anyway, this patch should not be accepted until the above series is
> settled.
> 
>  drivers/soc/Kconfig                       |   1 +
>  drivers/soc/Makefile                      |   1 +
>  drivers/soc/google/Kconfig                |  13 +
>  drivers/soc/google/Makefile               |   3 +
>  drivers/soc/google/google-cpm-mba-trace.h | 214 +++++
>  drivers/soc/google/google-cpm-mba.c       | 964 ++++++++++++++++++++++
>  drivers/soc/google/google-cpm-mba.h       |  30 +
>  include/soc/google/goog_cpm_service_ids.h |  84 ++

Keep naming consistent. You use everywhere hyphens, so here as well.

>  include/soc/google/google-cpm-mba.h       | 147 ++++


>  9 files changed, 1457 insertions(+)
>  create mode 100644 drivers/soc/google/Kconfig
>  create mode 100644 drivers/soc/google/Makefile
>  create mode 100644 drivers/soc/google/google-cpm-mba-trace.h
>  create mode 100644 drivers/soc/google/google-cpm-mba.c
>  create mode 100644 drivers/soc/google/google-cpm-mba.h
>  create mode 100644 include/soc/google/goog_cpm_service_ids.h
>  create mode 100644 include/soc/google/google-cpm-mba.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 483cbdcae153..fbe6460424c7 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -10,6 +10,7 @@ source "drivers/soc/canaan/Kconfig"
>  source "drivers/soc/cirrus/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/fujitsu/Kconfig"
> +source "drivers/soc/google/Kconfig"
>  source "drivers/soc/hisilicon/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 5a3efd68355c..6241e543dad7 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
>  obj-y				+= fujitsu/
>  obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
> +obj-y				+= google/
>  obj-y				+= hisilicon/
>  obj-y				+= imx/
>  obj-y				+= ixp4xx/
> diff --git a/drivers/soc/google/Kconfig b/drivers/soc/google/Kconfig
> new file mode 100644
> index 000000000000..9cd04be63b23
> --- /dev/null
> +++ b/drivers/soc/google/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GOOGLE_CPM_MBA
> +	tristate "Google Tensor CPM MailBox Array Interface"
> +	depends on ARCH_GOOGLE || COMPILE_TEST
> +	depends on MAILBOX

Can it be compile tested without mailbox?

Best regards,
Krzysztof

