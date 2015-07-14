From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Tue, 14 Jul 2015 16:26:26 +0800
Message-ID: <55A4C7B2.7040707@linux.intel.com>
References: <55A3D7A3.90609@linaro.org> <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com> <1436861209-4047-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436861209-4047-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015/7/14 16:06, Lukasz Anaczkowski wrote:
> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563.
> 
> In case when BIOS is populating MADT wiht both x2apic and local apic
> entries (as per ACPI spec), e.g. for Xeon Phi Knights Landing,
> kernel builds it's processor table in the following order:
> BSP, X2APIC, local APIC, resulting in processors on the same core
> are not separated by core count, i.e.
> 
> Core LCpu   ApicId    LCpu    ApicId     LCpu    ApicId    LCpu    ApicId
> 0    0 (  0 [0000]),   97 (  1 [0001]),  145 (  2 [0002]),  193 (  3 [0003])
> 1   50 (  4 [0004]),   98 (  5 [0005]),  146 (  6 [0006]),  194 (  7 [0007])
> 2   51 ( 16 [0010]),   99 ( 17 [0011]),  147 ( 18 [0012]),  195 ( 19 [0013])
> 3   52 ( 20 [0014]),  100 ( 21 [0015]),  148 ( 22 [0016]),  196 ( 23 [0017])
> 4   53 ( 24 [0018]),  101 ( 25 [0019]),  149 ( 26 [001a]),  197 ( 27 [001b])
> 5   54 ( 28 [001c]),  102 ( 29 [001d]),  150 ( 30 [001e]),  198 ( 31 [001f])
> ...
> 
> Please note, how LCpu are mixed for physical cores (Core).
> 
> This patch fixes this behavior and resulting assignment is
> consistent with other Xeon processors, i.e.
> 
> Core LCpu   ApicId    LCpu    ApicId     LCpu    ApicId    LCpu    ApicId
> 0    0 (  0 [0000]),   72 (  1 [0001]),  144 (  2 [0002]),  216 (  3 [0003])
> 1    1 (  4 [0004]),   73 (  5 [0005]),  145 (  6 [0006]),  217 (  7 [0007])
> 2    2 (  8 [0008]),   74 (  9 [0009]),  146 ( 10 [000a]),  218 ( 11 [000b])
> 3    3 ( 12 [000c]),   75 ( 13 [000d]),  147 ( 14 [000e]),  219 ( 15 [000f])
> 4    4 ( 16 [0010]),   76 ( 17 [0011]),  148 ( 18 [0012]),  220 ( 19 [0013])
> 5    5 ( 20 [0014]),   77 ( 21 [0015]),  149 ( 22 [0016]),  221 ( 23 [0017])
> ...
> 
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Hi Lukasz,
	I have some concerns here about "maxcpus" and "nox2apic" kernel
parameters. Say "maxcpus=72 nox2apic" is specified, user may get
less than 72 CPUs with you patch applied. Original code will try to
only all xapic CPUs before trying x2apic CPUs, so "maxcpus" doesn't
conflict with "nox2apic".
Thanks!
Gerry
