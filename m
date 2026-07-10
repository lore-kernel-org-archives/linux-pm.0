Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E13D79F9;
	Fri, 10 Jul 2026 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672733; cv=none; b=Cro1wdNh1c5pUh4XlYhSLfr2jJUqT2j3QPR79EtuB0LnMblfU7+NoorvB+qlawX4s898uRpShxsQTJOXw+QfKlFq7IC4PBu2vg6TdVRZKQ5rVRnCLCuRW0QwSDBo/FXQHQTmrJjxnDuuwtoDFIg7HmhdcX/btGuYmppnWNY69Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672733; c=relaxed/simple;
	bh=dpRfMvlSINQNlSRIRhFvRt1RUWd3BndT1K1wyLx5Lvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4tZ4rdi/AEqZQCdWE03QPbTRo9VjNKCpYqBkMlepcy7xucwY4RF6QCq8BBQ3ibDX3pGWql1XGR78quxGWH/iSAp0YO0JFwTvJJnsXFmE1qnkdWcpDPZGx4ZBtu25YMU5MeVj+3j3x3hUK7HhOUSE1YyFmnSHD4GNeuXcM6ZgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGTXI5E0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGTXI5E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F4D1F000E9;
	Fri, 10 Jul 2026 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783672731;
	bh=cpvrx4tFOz3jWh0MkNiBbPUfVVjjeSGFY+Zp/pTTVUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UGTXI5E0OAwaaQJCF0aPJW3LSQciLWBMT1hlLz4UjY6vUJ3iWTK+g41f4nC6SrddV
	 gjr6K7JaOo7kYVk+JENRovfqVzPbVpSrnfDQki/0kAwOTjykHBVPshX+PYXd5XKFeI
	 E0aD+GWzVE1bwI3NYVtApDZq/RKARMYGU1eVOCAoH0fNbm8H8LPOdbDpUec7XYRiwV
	 9rJAcS1oc/Wmx6mcBCRWRdfiCtnI1N45rrWyL7CGfLOKoz/3x4WijBfiJ34I5Qra5X
	 67IvjkU9rZBwuaHQSqwM1WiaCt3bg9z7ph/Ni88xR1IAnhFyXorIwAooJBWdW9Y8zG
	 ycWxnwBPneVPQ==
Date: Fri, 10 Jul 2026 09:38:42 +0100
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
Message-ID: <20260710-macho-pristine-tanuki-b0d3ce@sudeepholla>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
 <ak_Eu_eQKalPMwo-@pluto>
 <77110e77-941d-4173-b2f5-6f3cf4858339@amd.com>
 <20260710-lemon-pogona-of-wind-b3a003@sudeepholla>
 <5f5e8341-dbcc-4467-976e-35d007ae148e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5e8341-dbcc-4467-976e-35d007ae148e@amd.com>

On Fri, Jul 10, 2026 at 09:42:09AM +0200, Michal Simek wrote:
> 
> 
> On 7/10/26 09:35, Sudeep Holla wrote:
> > On Fri, Jul 10, 2026 at 09:03:32AM +0200, Michal Simek wrote:
> > > 
> > > 
> > > On 7/9/26 17:56, Cristian Marussi wrote:
> > > > On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> > > > > On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> > > > > SCMI server from different architectures than ARM that's why remove
> > > > > ARM/ARM64 Kconfig dependency with also remove ARM from description and
> > > > > rename folder to reflect it.
> > > > 
> > > > While I understand dropping the dependency on ARM (I always wanted to do
> > > > that and test if it worked at all on some otehr archs with QEMU), I am
> > > > not sure about the whole renaming party ? why is needed just for
> > > > cosmetic reasons ? it is at the end an arm originated protocol so I dont
> > > > see it as a being wrong to be named as such even though used by other
> > > > archs...I have not really strong opinion on this...
> > > 
> > > I have been in CC on U-Boot RPMI patches which got to my attention because
> > > I don't want to have another interface for MB-V(riscv-) running in
> > > programmable logic and have another server in the system doing the same
> > > thing.
> > > 
> > 
> > Ah that's interesting. I wasn't aware of that. I still agree with the move
> > in principle, but how does that align with these:
> > 
> > drivers/clk/clk-rpmi.c
> > drivers/irqchip/irq-riscv-rpmi-sysmsi.c
> > include/linux/mailbox/riscv-rpmi-message.h
> > drivers/mailbox/riscv-sbi-mpxy-mbox.c(Should be fine as it is just transport)
> 
> I am having separate discussion on u-boot mailing list about RPMI and it's
> usage on non riscv architectures because one raised argument was that it is
> community driver spec compare to SCMI which is owned by ARM. But IMHO only
> for riscv.
> 

IIRC in LPC 2024, we did discuss opening up SCMI so that RISCV could use it as
is instead of copying quite a lot from SCMI for RPMI in some closed groups.

Here is the summary we got from couple of RISC-V vendors at the time:
"
RPMI is comparable to Arm SCMI, but it includes RISC-V-specific services such
as HART State Management, CPPC, Management Mode, and RAS Agent. The SBI MPXY
extension enables secure and non-secure system partitions to exchange RPMI
messages, allows an M-mode RPMI transport to be shared with S-mode, and lets
hypervisors virtualize RPMI for guests or VMs.

RPMI development is already well advanced, with much of the client-driver work
implemented in OpenSBI. Supervisor software can access selected RPMI services
through SBI MPXY. A permissively licensed reference implementation, librpmi,
is also available for platform vendors.

RPMI was created after evaluating Arm SCMI, mainly to support RISC-V-specific
requirements.
"

I didn't pursue it any further following some of these followup discussions
post LPC 2024.

> > 
> > Now I feel we need some alignment before making $subject move.
> > 
> > > Based on that we had discussed about it with Vincent and Souvik (we missed
> > > you there) about using SCMI on non ARM platform and both of them didn't see
> > > the concern to be marked as ARM only protocol.
> > > Truth is that some of protocols have ARM in description, file names, etc but
> > > some of them not. That's why I think it is good time to sync it up and
> > > enable
> > > running this protocol on other SOCs.
> > > 
> > > > ... my concern really is ... wont this full scale rename simply generate
> > > > a lot of un-needed churn for future fixes and/or backporting ?
> > > I don't think it is going to be a big problem because it is just git mv
> > > which git is able to gracefully handle.
> > > 
> > 
> > Otherwise it may end up being unnecessary churn though I completely agree
> > with the git/backporting aspects. Just don't want to churn things up until
> > we have some plan and further changes/users of this move.
> 
> As I wrote above AMD/Xilinx platform with SCMI server where ARM RPU/APUs
> (with multiple VMs) and Microblaze-V in programmable logic acting as
> separate agents is going to be the first user. And for being able to run
> SCMI on Linux running on Microblaze-V I need enable SCMI on non ARM
> architecture.
> 

Ah OK, if the plan is to just use SCMI as is and having "ARM/arm" name is
a blocker, then sure we can get that done. Hope you are aware of and already
considered some of the RISC-V specifics listed above and ruled out any of
those as concerns to use SCMI on RISC-V platforms.

-- 
Regards,
Sudeep
