From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Bug#763320: linux-image-3.16-2-amd64: intel_idle enabled for
 Intel Atom S1260, causes high CPU temperature when idle
Date: Wed, 01 Oct 2014 15:01:37 +0200
Message-ID: <542BFB31.8000402@siemens.com>
References: <20140929095709.3255.93208.reportbug@izoard.lan> <1412035987.9388.72.camel@decadent.org.uk> <542A461D.9060900@siemens.com> <269B8283-9171-4EBD-9852-0796A4AA2008@thil.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:50097 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbaJANBt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Oct 2014 09:01:49 -0400
In-Reply-To: <269B8283-9171-4EBD-9852-0796A4AA2008@thil.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christophe Thil <christophe@thil.de>, Len Brown <len.brown@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, 763320@bugs.debian.org, linux-pm@vger.kernel.org

On 2014-10-01 14:42, Christophe Thil wrote:
> I have attached the output of /proc/cpuinfo (kernel 3.16-2-amd64) and cpuid (20140123).

This is from my N2800:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 54
model name	: Intel(R) Atom(TM) CPU N2800   @ 1.86GHz
stepping	: 1
microcode	: 0x10d
cpu MHz		: 798.000
cache size	: 512 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm arat dtherm
bogomips	: 3733.68
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

Comparing it to your cpuinfo, the stepping may make the difference -
hope it's not just the name... Suggestions?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
