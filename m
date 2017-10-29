From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RESEND PATCH v2 1/2] soc: amlogic: add Meson GX VPU Domains
 driver
Date: Sun, 29 Oct 2017 15:59:03 +0100
Message-ID: <7h60ayvw3s.fsf@baylibre.com>
References: <1509208817-30632-1-git-send-email-narmstrong@baylibre.com>
 <1509208817-30632-2-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1509208817-30632-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Sat, 28 Oct 2017 18:40:16 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: carlo@caione.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Video Processing Unit needs a specific Power Domain powering scheme
> this driver handles this as a PM Power Domain driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> +static inline
> +struct meson_gx_pwrc_vpu *genpd_to_pd(struct generic_pm_domain *d)
> +{
> +	return container_of(d, struct meson_gx_pwrc_vpu, genpd);
> +}
> +
> +static int meson_gx_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
> +{
> +	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
> +	int i;
> +
> +	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
> +			   GEN_PWR_VPU_HDMI_ISO, GEN_PWR_VPU_HDMI_ISO);
> +	udelay(20);

Some minor nits/questions.  I know the vendor code does it this way,
but...

> +	/* Power Down Memories */
> +	for (i = 0; i < 32; i += 2) {
> +		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
> +				   0x2 << i, 0x3 << i);
> +		udelay(5);
> +	}

several of these bits are marked "reserved" in the datasheet.  Have you tried
without writing to the reserved bits?

> +	for (i = 0; i < 32; i += 2) {
> +		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
> +				   0x2 << i, 0x3 << i);
> +		udelay(5);
> +	}

ditto

> +	for (i = 8; i < 16; i++) {
> +		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
> +				   BIT(i), BIT(i));
> +		udelay(5);
> +	}

Do these really have to be written one bit at a time?

I'm actually OK to merge things like this, since it also captures the
sequences used by the vendor kernel, but I'm just curious if you did any
of the other experiments.

If you can try those experiments, we can take them as follow-on patches.

Kevin
