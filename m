Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0432E728;
	Thu, 12 Mar 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328716; cv=none; b=fbP/MpO+UYl2oXjp41usOB+UrbR4foC0aPluAm2LStCMrOb7JtOjOygiUQCiR7UMOQO+7cu+tm3UpxA73JnlUGenSRA6nhYGggO4yZv3PiDxy0956mQzzgONdddpnwaH+FlLt92p99/MKMaT8WOi3Ejx0NIAliwWFkdBC1T7KQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328716; c=relaxed/simple;
	bh=q/73t51aKedB3zBIJJWs3Io05YsoPRBSTQHT+zfl89M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2RMG2rKlV1EAvLMS4/pYnDYLp1Eme+h3uWcwoLGDJGQrgBj6Tfp7jcrbKBzoYKUCvmtP0Qsl1fvDFfMkJnvY+QymVyLpT7+8KI1IsFAsNPMx/ZQkWtWuueWizXpCPqHOVvREE76cItarNGrU8ZAa03QTPisYFYLSagWPkRVWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbvoqsfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbvoqsfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE30C4CEF7;
	Thu, 12 Mar 2026 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328716;
	bh=q/73t51aKedB3zBIJJWs3Io05YsoPRBSTQHT+zfl89M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbvoqsfujzT6C+wlMvkCiRkytZczS5xV2llw2VfI5bhkLkwrzFiyzDio1KCjFyVdG
	 km1Hiltca1KqnFxMJ9+NyOiSnjeaniMzdI0bDF4AEve5PrmvGRfbqe4kFt/dtLcqeU
	 vUqSFqbyNOwVUDTUY23wVk+OMHetLMnlng/A65sP3/kDF0cpV4XZKKD6nu3SMAlauK
	 RicpGU/xkmQotrlLs2xm1VRwAw2nHez7dcTfIU8lupOWm3kiKjNiGl6j3jGHUnSXrQ
	 Vb3+Cy5Ox6YI3mzY+Zl9+m9ScFp5k7wBkcwOWEAfZgKzsZHtpirYetaXiUStKTMwfk
	 G7RmctjMTTzig==
Date: Thu, 12 Mar 2026 10:18:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-rtc@vger.kernel.org,
	linux-gpio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH v4 1/5] regulator: dt-bindings: regulator-max77620:
 convert to DT schema
Message-ID: <177332871399.3156742.15361211430147283571.robh@kernel.org>
References: <20260312085258.11431-1-clamor95@gmail.com>
 <20260312085258.11431-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312085258.11431-2-clamor95@gmail.com>


On Thu, 12 Mar 2026 10:52:54 +0200, Svyatoslav Ryhel wrote:
> Convert regulator-max77620 devicetree bindings for the MAX77620 PMIC from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  .../regulator/maxim,max77620-regulator.yaml   |  99 ++++++++
>  .../bindings/regulator/regulator-max77620.txt | 222 ------------------
>  2 files changed, 99 insertions(+), 222 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77620-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

