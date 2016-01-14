From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Thu, 14 Jan 2016 12:11:39 +0100
Message-ID: <4244898.5om31fQ1mz@wuerfel>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com> <11122786.kKumQ3Dhls@wuerfel> <20160114102924.GA22340@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114102924.GA22340@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 14 January 2016 11:29:24 Thierry Reding wrote:
> 
> It just occurred to me that none of these options really make much of a
> difference. As Jon mentioned once we merge this series a lot of features
> on Tegra will start to rely on PM_GENERIC_DOMAINS and hence PM. So if we
> do want to build a kernel with a maximum of Tegra features enabled (and
> I think a multi_v7_defconfig should include that) we'll end up with a PM
> dependency anyway, whether forced via select or implied via depends on.
> 
> I'm beginning to wonder if PM really should be an option these days. The
> disadvantages of making it optional do outweigh the advantages in my
> opinion. I'm not saying that, in general, it's totally useless to build
> a kernel that has no PM support, but for the more specific case where
> you would want to enable multi-platform support I don't think there's
> much practical advantage in allowing !PM. One of the most common build
> warnings are triggered because of this option. Also multi-platform
> kernels are really big already, so much so that I doubt it would make a
> significant difference if we unconditionally built PM support. Also the
> chances are that we'll be seeing more and more SoCs support PM and rely
> on it, much like Tegra would with the addition of this series.
> 
> I imagine that we could save ourselves a lot of headaches by simply
> enabling PM by default, whether that be via the PM Kconfig option or by
> selecting it from ARCH_TEGRA and any other architectures that may come
> to rely on it. Doing so would also reduce the amount of test coverage
> that we need to do, both at compile- and runtime.

I think this needs some investigation. As a general policy, we should
not grow the kernel image size when moving from a traditional ARM
platform to an ARCH_MULTIPLATFORM one.

This is somewhat contradicted by how we already require CONFIG_OF
to be set for multiplatform kernels, and that adds around 80kb
to the image size.

Looking at just the defconfig files, these are the ones that currently
do not set CONFIG_PM:

build/acs5k_defconfig/.config:# CONFIG_PM is not set
build/acs5k_tiny_defconfig/.config:# CONFIG_PM is not set
build/axm55xx_defconfig/.config:# CONFIG_PM is not set
build/bcm2835_defconfig/.config:# CONFIG_PM is not set
build/clps711x_defconfig/.config:# CONFIG_PM is not set
build/ebsa110_defconfig/.config:# CONFIG_PM is not set
build/footbridge_defconfig/.config:# CONFIG_PM is not set
build/ks8695_defconfig/.config:# CONFIG_PM is not set
build/netwinder_defconfig/.config:# CONFIG_PM is not set
build/rpc_defconfig/.config:# CONFIG_PM is not set
build/u300_defconfig/.config:# CONFIG_PM is not set
build/vf610m4_defconfig/.config:# CONFIG_PM is not set

The only ones among these are are actually multiplatform are axm55xx,
bcm2835, and u300. I see no downsides of force-enabling PM for
any of those, so we could decide to 'select PM' from
CONFIG_ARCH_MULTIPLATFORM.

The one usecase where we may want to have a modern machine without
CONFIG_PM is a minimal MACH_VIRT kernel for running in a virtual
machine or QEMU with minimal memory requirements, e.g. trying to
squeeze a large number of guests on a single host system.

	Arnd
