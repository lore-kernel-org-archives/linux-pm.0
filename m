From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/9] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Mon, 20 Nov 2017 17:06:35 +0000
Message-ID: <20171120170634.GB31395@e107155-lin>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
 <20171109210311.25655-4-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109210311.25655-4-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 09, 2017 at 03:03:05PM -0600, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id
> associated with a logical cpu. Provide an arm64
> helper to do this.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 59cca1d6ec54..408e7989d3a2 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
>  }
>  
>  struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
> +static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> +{
> +	return	acpi_cpu_get_madt_gicc(cpu)->uid;
> +}

If I followed the series correctly, this function is used in 2/9 already.
So this needs to be moved down in the series to avoid build failure during
bisection.

--
Regards,
Sudeep
