From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
Date: Sun, 16 Mar 2014 04:09:17 -0300
Message-ID: <20140316070917.GA3094@arch.cereza>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <jonathan.austin@arm.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Victor Kamensky <victor.kamensky@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sricharan R <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Russ Dill <Russ.Dill@ti.com>, Nicolas Pitre <nico@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Laura Abbott <lauraa@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jiang Liu <liuj97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mar 05, Sebastian Capella wrote:
[..]
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 1f8fed9..83707702 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -611,6 +611,11 @@ config CPU_USE_DOMAINS
>  config IO_36
>  	bool
>  =

> +config ARCH_HIBERNATION_POSSIBLE
> +	bool
> +	depends on MMU
> +	default y if CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || CPU_XSCALE || =
CPU_XSC3 || CPU_V6 || CPU_V6K || CPU_V7
> +
>  comment "Processor Features"
>  =


Is there any reason why CPU_FEROCEON is not listed here? FWIW, I've just bu=
ilt
(but not really tested) a Kirkwood kernel with CONFIG_HIBERNATION=3Dy.

And is there any reason to put this config in arch/arm/mm/Kconfig, instead =
of
in arch/arm/Kconfig, below ARCH_SUSPEND_POSSIBLE? =


I'm also puzzled about having two separate options for suspend and hibernat=
e,
maybe someone can explain me why a given CPU would support the former but n=
ot
the latter?

Thanks!
-- =

Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
