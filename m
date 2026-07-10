Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE01371D07;
	Fri, 10 Jul 2026 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668915; cv=none; b=AHE2UMJ1PDDRAmEpffR2Bq9DPrfKMW4F8GQqBTAxkjzG4txE/xJDddGkZoPP9JPp+HJ+DMDEuKuY8hIyL3Qq8cAeOrZz/jEewt9Q5w72rdZkf6lBnCw7sLVSWWhcgBLwLzsE8PzsWmNbYhIY7DbghPUMxxju5MNHXOYJd4768TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668915; c=relaxed/simple;
	bh=A66JzFaRHhe/w+8bewl/fiwHWMXXLtE7PfKc6EDPdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUc8AcW/V7RKJu07be+dFDjfzZjGVhst4zsTN88N55XZMAPKI6WIY6cYrmdMZSEzZNVyxzsmwoKxtvFVL9+0CNvUUFlY1UplJ2gL9Vk6Z5iJYSo0E01nSTizze6u+qWqwCId8VIIuY8dxLYkJbKnjZAhushzwVHFg6cvVxzqEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jazFSLFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jazFSLFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366B81F000E9;
	Fri, 10 Jul 2026 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783668914;
	bh=ZDFlTDkmewCOyJwFuz7uMa+pChp8dl4Jfof3pfwSFns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jazFSLFhy3qbAb5zLVpefSY9VjtAOPPSuF0bFtPKWr2IN5T79pyQK5KGpaMOAfIc6
	 DdZPkAkCso3aDJrQCYwXPqJyDZtV3InMthVBw9PBNULcbI0h9nSrvgI3kQxa1gRevI
	 Cw18WuQFEWteXPPg/stW7Hi0RrAON/2PxhfqmFkDJKWcMHQr36ZQa5eeVP+gdFbE1I
	 ZlR1DfePeVI/CxrgxQk8AlEkSWLY03s3U2mBMiqp6JDEK6FiV/7fWmx+8Ywb+hod7V
	 quJoUaILjYqgzpBJv3xZFeP2spCjEp9la/utG+1xmIRgwTbL3qg1kx0TkS4XsTJjtY
	 VhVgC6fJbbIrw==
Date: Fri, 10 Jul 2026 08:35:05 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
	Alex Shi <alexs@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
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
Message-ID: <20260710-lemon-pogona-of-wind-b3a003@sudeepholla>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
 <ak_Eu_eQKalPMwo-@pluto>
 <77110e77-941d-4173-b2f5-6f3cf4858339@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77110e77-941d-4173-b2f5-6f3cf4858339@amd.com>

On Fri, Jul 10, 2026 at 09:03:32AM +0200, Michal Simek wrote:
> 
> 
> On 7/9/26 17:56, Cristian Marussi wrote:
> > On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> > > On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> > > SCMI server from different architectures than ARM that's why remove
> > > ARM/ARM64 Kconfig dependency with also remove ARM from description and
> > > rename folder to reflect it.
> > 
> > While I understand dropping the dependency on ARM (I always wanted to do
> > that and test if it worked at all on some otehr archs with QEMU), I am
> > not sure about the whole renaming party ? why is needed just for
> > cosmetic reasons ? it is at the end an arm originated protocol so I dont
> > see it as a being wrong to be named as such even though used by other
> > archs...I have not really strong opinion on this...
> 
> I have been in CC on U-Boot RPMI patches which got to my attention because
> I don't want to have another interface for MB-V(riscv-) running in
> programmable logic and have another server in the system doing the same
> thing.
> 

Ah that's interesting. I wasn't aware of that. I still agree with the move
in principle, but how does that align with these:

drivers/clk/clk-rpmi.c
drivers/irqchip/irq-riscv-rpmi-sysmsi.c
include/linux/mailbox/riscv-rpmi-message.h
drivers/mailbox/riscv-sbi-mpxy-mbox.c(Should be fine as it is just transport)

Now I feel we need some alignment before making $subject move.

> Based on that we had discussed about it with Vincent and Souvik (we missed
> you there) about using SCMI on non ARM platform and both of them didn't see
> the concern to be marked as ARM only protocol.
> Truth is that some of protocols have ARM in description, file names, etc but
> some of them not. That's why I think it is good time to sync it up and
> enable
> running this protocol on other SOCs.
> 
> > ... my concern really is ... wont this full scale rename simply generate
> > a lot of un-needed churn for future fixes and/or backporting ?
> I don't think it is going to be a big problem because it is just git mv
> which git is able to gracefully handle.
> 

Otherwise it may end up being unnecessary churn though I completely agree
with the git/backporting aspects. Just don't want to churn things up until
we have some plan and further changes/users of this move.

-- 
Regards,
Sudeep
