Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5790189520;
	Mon, 20 Jan 2025 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357088; cv=none; b=MepB3jgc7sMwp4x+/XYYHEEehNWblCzEcl/jEoC/IkHWlJYVUlVFZS0ua80M03C+lW3O3h74MnriirC4F6zmFNIwN7frDrwp+cRmN97SX2/hoEpaSt1Vq5LGpY/XFN5sBiIo1f8eRzoxG8i/MqtrRq7Qh0ijANce6wmd7MuxGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357088; c=relaxed/simple;
	bh=s0JdIP9vTBPTjueayczoG8sLEk1ZvCpf2Eqt1qnAMPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiCtKbAscholoPU0YW7C3Pu/0/jggnnbs+bWj0+iELEsVmR4wqolqziIDAOuFTsbYao59kO3qHrbSEwL/LgLbY+d/2yz+RApf1uih81FJbjHlaSfzcLRdwlzR/Y8dF6VHSGgcqdJ6gW4QZRL+fGs9fblq09eHxx4jRMflHzkqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giERC5za; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giERC5za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129CFC4CEDD;
	Mon, 20 Jan 2025 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357087;
	bh=s0JdIP9vTBPTjueayczoG8sLEk1ZvCpf2Eqt1qnAMPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giERC5za0y3GJclwdWnPaT0atKy4t962Z+JQ8PiK2SWjWALwqXeeZmbAuAg0WUuIe
	 5Pu4Wd52inTbp2TnCpk0Bs5k2lYdQFAOrFVPsvOp5KUm0rppNIwxe6nMYC8RoH9Rmc
	 WaefSjnfrObkkPXP18R6EYfrE0d3YZ/aHOKvWKMRWI6EJU+JKZD18irDuTfI65q5HT
	 lgXQLiBet+/yxR2yRbaqzTznUFjm4NvimmPWlF33HrAYTFe8TVKX1T1l3n+nwYfBhD
	 p5SzjxPqoYGk/EaBswJcaFCtFD1e94UX5nNUPVR8QeyS0739flMQQMn61OdLo35S5o
	 gz92Beu/mGHdw==
Date: Mon, 20 Jan 2025 07:11:20 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 04/12] reboot: describe do_kernel_restart's cmd
 argument in kernel-doc
Message-ID: <Z433GGEmEuuaDE7G@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-4-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-4-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:29PM +0100, Ahmad Fatoum wrote:
> A W=1 build rightfully complains about the function's kernel-doc
> being incomplete.
> 
> Describe its single parameter to fix this.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
