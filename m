From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to
 fall back to acpi-cpufreq and it is unavailable.
Date: Fri, 18 Jan 2013 19:06:59 +0000
Message-ID: <20130118190659.GB16757@srcf.ucam.org>
References: <1357780161-30581-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20130111144940.GB21882@liondog.tnic>
 <20130111165054.GD10751@liondog.tnic>
 <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
 <20130117115436.GA3853@pd.tnic>
 <20130118162347.GA31499@srcf.ucam.org>
 <20130118170755.GB4062@pd.tnic>
 <20130118190021.GD4062@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45164 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3ARTHH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jan 2013 14:07:07 -0500
Content-Disposition: inline
In-Reply-To: <20130118190021.GD4062@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Gopalakrishnan, Aravind" <Aravind.Gopalakrishnan@amd.com>, "rjw@sisk.pl" <rjw@sisk.pl>, Andre Przywara <andre@andrep.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas <linuxuser330250@gmx.net>

On Fri, Jan 18, 2013 at 08:00:21PM +0100, Borislav Petkov wrote:

> ##################################################################################
> # x86 drivers.
> # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> # K8 systems.
> ...
> 
> Great. :(

The only case I can see this hitting would be if the platform is using 
system IO rather than fixed hardware functionality. Easiest thing to do 
there would be something like this:

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0d048f6..8b466d5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -762,6 +762,11 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+			pr_debug("Old AMD systems must use native drivers\n");
+			result = -ENODEV;
+			goto err_unreg;
+		}
 		pr_debug("SYSTEM IO addr space\n");
 		data->cpu_feature = SYSTEM_IO_CAPABLE;
 		break;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
