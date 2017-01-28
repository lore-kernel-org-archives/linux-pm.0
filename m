From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI: processor_perflib: Simplify code and stop using CPUFREQ_START
Date: Sat, 28 Jan 2017 12:32:56 +0100
Message-ID: <1547465.PvRbYVlVrB@aspire.rjw.lan>
References: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 05, 2017 11:34:30 AM Viresh Kumar wrote:
> acpi_processor_ppc_notifier() can live without using CPUFREQ_START
> (which is gonna be removed soon).

That should be "acpi_processor_ppc_notifier() can live without using CPUFREQ_START ...,
because X".

X is obviously missing.

> Simplify it a bit.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rebased over: https://marc.info/?l=linux-kernel&m=148359167516831&w=2
> 
>  drivers/acpi/processor_perflib.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index f0b4a981b8d3..1ceea1143a1c 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -75,14 +75,12 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
>  	struct acpi_processor *pr;
>  	unsigned int ppc = 0;
>  
> -	if (event == CPUFREQ_START && ignore_ppc <= 0) {
> -		ignore_ppc = 0;
> -		return 0;
> -	}
> -
>  	if (ignore_ppc)
>  		return 0;
>  
> +	if (ignore_ppc < 0)
> +		ignore_ppc = 0;
> +

And the above looks like dead code to me (we have returned already if ignore_ppc
is negative), so in particular ignore_ppc is never going to become 0 when it was
negative initially.

>  	if (event != CPUFREQ_ADJUST)
>  		return 0;
>  
> 

Thanks,
Rafael

