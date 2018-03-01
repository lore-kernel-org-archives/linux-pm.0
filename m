From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 1/3] irqchip/gic-v3-its: add ability to save/restore
 ITS state
Date: Thu, 1 Mar 2018 11:41:45 +0000
Message-ID: <20180301114144.nmwu4qtslvj7ogj5@lakrids.cambridge.arm.com>
References: <20180301054820.42847-1-dbasehore@chromium.org>
 <20180301054820.42847-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180301054820.42847-2-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 28, 2018 at 09:48:18PM -0800, Derek Basehore wrote:
> Some platforms power off GIC logic in suspend, so we need to
> save/restore state. The distributor and redistributor registers need
> to be handled in platform code due to access permissions on those
> registers, but the ITS registers can be restored in the kernel.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>

How much state do we have to save/restore?

Given we can apparently read all this state, couldn't we *always* save
the state, then upon resume detect if the state has been lost, restoring
it if so?

That way, we don't need a property in FW tables for DT or ACPI.

[...]

> @@ -3261,6 +3363,9 @@ static int __init its_probe_one(struct resource *res,
>  		ctlr |= GITS_CTLR_ImDe;
>  	writel_relaxed(ctlr, its->base + GITS_CTLR);
>  
> +	if (fwnode_property_present(handle, "reset-on-suspend"))
> +		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;

Does this allow this property on an ACPI system?

If we need this on ACPI, we need a spec update to handle this properly,
and shouldn't use device properties like this.

Thanks,
Mark.
