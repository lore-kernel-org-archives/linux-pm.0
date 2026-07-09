Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F124A06A;
	Thu,  9 Jul 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606482; cv=none; b=Rxj5hRLoG7dVLb1NEq3XP3CYNFHzPorQ64hArX7rTX2Jb0GB4ZHRVUS7n4aUM0hM75P5QhSVBpkV71nJ0XuE6609ETdPaOa7ZUb8esgXgtpNNwWEEuziQ1ZCa+gpIfDZMiGZoou/oCi47zjL7oxqc85ncLrWfuTvInyQSmWrnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606482; c=relaxed/simple;
	bh=5I/mpHQudS97OUP9lf2pVHWPkfbDxf+UsN1az0CvXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZW9jhsEcBpVbmxh4SWYoeC/MtDzPW7i9NYu/iI0cT5a9EAUqpjjGFcXTlO0xzff/pd9LgsBAlj69isDyok8jBYZ+kWYbLOWqzGua04fWUn06AMferKqk+CvyH3p7SmYOdfaKuuemTAiqDu871G07DhQRngJZCpEXA+GtIyFYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrkQxVcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrkQxVcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C521F000E9;
	Thu,  9 Jul 2026 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606481;
	bh=sred5ICwa7oh4IdeWBE/Ft824zVIPyZQqaedLWMzR8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CrkQxVcjI61muQapvFh6VMzFaBJaq7fyVUubTMQhJp3gAo5qzeqd+S1fsOsH7wtbn
	 SuD++jFi0JwrLJO2YYQagZ+isGqbJVIpwleSaSH7q9GWu0ZragTiPz1hQJE1Xrk5aU
	 V6tQi68t4nx9JQBQJ4sTbWAINkfdzQRJjAFAHKVNoby0+5vRxmzH8kV+oJJHKQPdKK
	 SmZH0+tSQWnMnc/5lXyMFEu8pnYgCo2YN/ee05k/5zwvpLSV3JW2N8jQUfwLvo2DUn
	 vgNlF0WLn8u2XSCkPsW5K19mUWMCQKIHqVf2yC1XMZnjSH0PI5KzzhX2V7fRndnAbN
	 K5mYw9F2dXILA==
Date: Thu, 9 Jul 2026 15:14:32 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
	Sudeep Holla <sudeep.holla@kernel.org>, Alex Shi <alexs@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <dlechner@baylibre.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
Message-ID: <20260709-tidy-oarfish-of-refinement-d98dac@sudeepholla>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>

On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> SCMI server from different architectures than ARM that's why remove
> ARM/ARM64 Kconfig dependency with also remove ARM from description and
> rename folder to reflect it.
> From specification perspective only ARM specific transport layers should be
> available on ARM/ARM64 architectures.
> 
> That's why get rid of ARM prefix and description from documentation, file
> names, folder names, MODULE description, module names, Kconfig and
> comments.
> But keep origin Kconfig symbols not to break existing users.
> 
> Hwmon, pinctrl, powercap, regulator, reset, clk and cpufreq scmi drivers
> already miss arm prefix that's why synchronize all of them to be without
> arm prefix.
> 

Technically it sounds good. We just need to workout logistics to apply
this treewide. Preferably a script that Arm SoC team can run may be the
ideal solution IMO.

-- 
Regards,
Sudeep
