From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to
 fall back to acpi-cpufreq and it is unavailable.
Date: Fri, 18 Jan 2013 20:36:56 +0100
Message-ID: <20130118193656.GE4062@pd.tnic>
References: <1357780161-30581-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20130111144940.GB21882@liondog.tnic>
 <20130111165054.GD10751@liondog.tnic>
 <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
 <20130117115436.GA3853@pd.tnic>
 <20130118162347.GA31499@srcf.ucam.org>
 <20130118170755.GB4062@pd.tnic>
 <20130118190021.GD4062@pd.tnic>
 <20130118190659.GB16757@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130118190659.GB16757@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Gopalakrishnan, Aravind" <Aravind.Gopalakrishnan@amd.com>, "rjw@sisk.pl" <rjw@sisk.pl>, Andre Przywara <andre@andrep.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas <linuxuser330250@gmx.net>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 18, 2013 at 07:06:59PM +0000, Matthew Garrett wrote:
> On Fri, Jan 18, 2013 at 08:00:21PM +0100, Borislav Petkov wrote:
> 
> > ##################################################################################
> > # x86 drivers.
> > # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> > # K8 systems.
> > ...
> > 
> > Great. :(
> 
> The only case I can see this hitting would be if the platform is using 
> system IO rather than fixed hardware functionality. Easiest thing to do 
> there would be something like this:
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 0d048f6..8b466d5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -762,6 +762,11 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	switch (perf->control_register.space_id) {
>  	case ACPI_ADR_SPACE_SYSTEM_IO:
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> +			pr_debug("Old AMD systems must use native drivers\n");
> +			result = -ENODEV;
> +			goto err_unreg;
> +		}
>  		pr_debug("SYSTEM IO addr space\n");
>  		data->cpu_feature = SYSTEM_IO_CAPABLE;
>  		break;

Ok, how much can we rely on ACPI to have this ACPI_ADR_SPACE_SYSTEM_IO
properly set on K8? Because the thing is, we want to use acpi-cpufreq on
F10h onwards and leave powernow-k8 to K8s.

So we're purely relying on ->control_register.space_id being
ACPI_ADR_SPACE_SYSTEM_IO on *all* K8s. And with the history BIOS has, I
don't trust it a single bit. Other than that, this could work...

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
