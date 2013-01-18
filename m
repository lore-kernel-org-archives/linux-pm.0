From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to
 fall back to acpi-cpufreq and it is unavailable.
Date: Fri, 18 Jan 2013 19:38:34 +0000
Message-ID: <20130118193834.GA17734@srcf.ucam.org>
References: <1357780161-30581-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20130111144940.GB21882@liondog.tnic>
 <20130111165054.GD10751@liondog.tnic>
 <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
 <20130117115436.GA3853@pd.tnic>
 <20130118162347.GA31499@srcf.ucam.org>
 <20130118170755.GB4062@pd.tnic>
 <20130118190021.GD4062@pd.tnic>
 <20130118190659.GB16757@srcf.ucam.org>
 <20130118193656.GE4062@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47143 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3ARTil (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jan 2013 14:38:41 -0500
Content-Disposition: inline
In-Reply-To: <20130118193656.GE4062@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Gopalakrishnan, Aravind" <Aravind.Gopalakrishnan@amd.com>, "rjw@sisk.pl" <rjw@sisk.pl>, Andre Przywara <andre@andrep.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas <linuxuser330250@gmx.net>

On Fri, Jan 18, 2013 at 08:36:56PM +0100, Borislav Petkov wrote:

> Ok, how much can we rely on ACPI to have this ACPI_ADR_SPACE_SYSTEM_IO
> properly set on K8? Because the thing is, we want to use acpi-cpufreq on
> F10h onwards and leave powernow-k8 to K8s.

SYSTEM_IO only supports single processors and was superceded in ACPI 
2.0. Are there any single-core F10h?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
