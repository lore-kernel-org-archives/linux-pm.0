From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 2 Dec 2014 11:10:17 +0000
Message-ID: <20141202111017.GC26306@e104818-lin.cambridge.arm.com>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
 <20141127150137.GA7889@red-moon>
 <20141201185705.GC499@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141201185705.GC499@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 01, 2014 at 06:57:05PM +0000, Lina Iyer wrote:
> On Thu, Nov 27 2014 at 08:01 -0700, Lorenzo Pieralisi wrote:
> >On Thu, Nov 27, 2014 at 05:24:07AM +0000, Lina Iyer wrote:
> >
> >[...]
> >
> >> +static int spm_set_low_power_mode(enum pm_sleep_mode mode)
> >> +{
> >> +       struct spm_driver_data *drv = per_cpu(cpu_spm_drv,
> >> +                                               smp_processor_id());
> >> +       u32 start_index;
> >> +       u32 ctl_val;
> >> +
> >> +       if (!drv)
> >> +               return -ENXIO;
> >> +
> >> +       start_index = drv->reg_data->start_index[mode];
> >> +
> >> +       ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
> >> +       ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
> >> +       ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
> >> +       ctl_val |= SPM_CTL_EN;
> >> +       spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
> >> +
> >> +       /* Ensure we have written the start address */
> >> +       wmb();
> >
> >Can you explain please what this wmb is meant to achieve ? If it is there
> >to make sure the write made it to the SPM that's not a proper way
> >to achieve it, the barrier ensures ordering, not write completion.
>
> A write completion would be great, but assuming that the context switch
> using SCM or WFI could ensure the flush, then ordering is probably good
> enough for this.

I assume you want the write to the device to complete (side-effects are
observed) before the WFI (which would raise a StandbyWFI signal). The
safer way is to read back from the device (or check/poll for the device
state change) rather than a barrier.

-- 
Catalin
