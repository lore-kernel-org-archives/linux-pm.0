Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92273274B4A;
	Sat, 18 Apr 2026 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776511422; cv=none; b=g4f5Fzl2DC5RD8na5Ltzsschk9dkLslu5O2aG+4RjKOOawGILJwLcBg9MDNniQ4tddcaV1Pi0hImWhuvRzueDjsPDaIwBResgz4H6fSX/JnXjxSmy1oP3+4I6m9P236fQtHkKI2XO4nh+idDD86G7KiwTbFRr73BOKUVHIhiuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776511422; c=relaxed/simple;
	bh=1PZzSDw81hRZRRqH1lyU5lL5gUPg/d7AkG9p+pNajqc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=SIbNGkRoS3Dw/yGJ21saTPcxi3BkTv1/87G8GFVw6CAOXJo68/O2YmGaIxaPjwASjO7Jjzr+iIQpq8WtYa4tYv03FbR2OLmY8BkhmFRYQko5e+V5/gJtT0pDLWICopgjavq8aoktLx/E2lNK2ya0gL98e2V2o2ruLAAPKL9CIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nARu2TGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nARu2TGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ACDC19424;
	Sat, 18 Apr 2026 11:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776511422;
	bh=1PZzSDw81hRZRRqH1lyU5lL5gUPg/d7AkG9p+pNajqc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nARu2TGlb3OxKTBxY0v4ryOPwRsmK7mP3BzIJySrVyYOQYMShM6XMYT2bu5XJYt6O
	 Nmli31ccJV9A7sQSZwx4Ma7ZV44fQeB7HWWKzTuL/5ttuyEc1IMnIphNwWMtHfmuuh
	 9htSL1O9kHOs2UFljq3pHfd9wzm1qrPSEukfR7GWjte0QiWfJAIBaVxAbQd9K7ur+Q
	 cjIHwCQcVWFcD3TEs38ALyF7wuXfXDaazc6CNy0bxBB/HXLLbpBt1bK0+Ahcy+tCzB
	 uooaHX+dAWdBhfLtBI6wOlv9n3R80BNEK7y33dkDscRpGA4DERBwH7T1OFADVngVCk
	 fgQs5l/IEZ7sQ==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 13:23:36 +0200
Message-Id: <DHW8QM1XH6ID.3F65U7700AJSM@kernel.org>
Subject: Re: [PATCH v2 0/9] driver core / pmdomain: Add support for fined
 grained sync_state
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-pm@vger.kernel.org>, "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@oss.nxp.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <CAPDyKFrPz9gaBBp6xV1=KkoemEfapc0p3POZxuBTvDw7Vamxtg@mail.gmail.com>
In-Reply-To: <CAPDyKFrPz9gaBBp6xV1=KkoemEfapc0p3POZxuBTvDw7Vamxtg@mail.gmail.com>

On Fri Apr 17, 2026 at 1:27 PM CEST, Ulf Hansson wrote:
> + Danilo (for the driver core changes)

Thanks -- please also remember to Cc: driver-core@lists.linux.dev.
