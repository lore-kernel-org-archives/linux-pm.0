From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 2/3] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Thu, 8 Feb 2018 13:46:50 +0000
Message-ID: <20180208134650.maf72ikwexdsxz2v@lakrids.cambridge.arm.com>
References: <20180208023648.89124-1-dbasehore@chromium.org>
 <20180208023648.89124-3-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208023648.89124-3-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 07, 2018 at 06:36:47PM -0800, Derek Basehore wrote:
> This adds documentation for the new reset-on-suspend property. This
> property enables saving and restoring the ITS for when it loses state
> in system suspend.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> index 0a57f2f4167d..a470147d4f14 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> @@ -78,6 +78,9 @@ These nodes must have the following properties:
>  Optional:
>  - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
>    address and size of the pre-ITS window.
> +- reset-on-suspend: Boolean property. Indicates that the ITS state is
> +  reset on suspend. The state is then saved on suspend and restored on
> +  resume.

The latter sentence reads like a description of SW policy, rather than a
description of what the HW does. I don't think that should be here
(though it might be worth noting the FW will not restore state).

Which state is lost? Is "ITS state" a well-defined term?

By suspend do you mean a PSCI_SYSTEM_SUSPEND, or potentially other
cases?

Thanks,
Mark.
