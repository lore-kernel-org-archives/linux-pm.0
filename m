From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to
 fall back to acpi-cpufreq and it is unavailable.
Date: Fri, 18 Jan 2013 20:58:06 +0100
Message-ID: <20130118195806.GA3252@pd.tnic>
References: <20130111144940.GB21882@liondog.tnic>
 <20130111165054.GD10751@liondog.tnic>
 <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
 <20130117115436.GA3853@pd.tnic>
 <20130118162347.GA31499@srcf.ucam.org>
 <20130118170755.GB4062@pd.tnic>
 <20130118190021.GD4062@pd.tnic>
 <20130118190659.GB16757@srcf.ucam.org>
 <20130118193656.GE4062@pd.tnic>
 <20130118193834.GA17734@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130118193834.GA17734@srcf.ucam.org>
Sender: cpufreq-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Gopalakrishnan, Aravind" <Aravind.Gopalakrishnan@amd.com>, "rjw@sisk.pl" <rjw@sisk.pl>, Andre Przywara <andre@andrep.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas <linuxuser330250@gmx.net>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 18, 2013 at 07:38:34PM +0000, Matthew Garrett wrote:
> On Fri, Jan 18, 2013 at 08:36:56PM +0100, Borislav Petkov wrote:
> 
> > Ok, how much can we rely on ACPI to have this ACPI_ADR_SPACE_SYSTEM_IO
> > properly set on K8? Because the thing is, we want to use acpi-cpufreq on
> > F10h onwards and leave powernow-k8 to K8s.
> 
> SYSTEM_IO only supports single processors and was superceded in ACPI 
> 2.0. Are there any single-core F10h?

Hmm, maybe some downcored creations, who knows? But actually, that
doesn't matter: we want to exit early from acpi-cpufreq loading on K8
only so the check should simply be:

	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
	    boot_cpu_data.x86 == 0xf) {
		pr_debug(...)
		...
	}

Yeah, I think that should work. I'll add your patch to the others and
make a patchset to give it a run. If it looks good, we'll queue it for
3.9 so that it can see more testing.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
