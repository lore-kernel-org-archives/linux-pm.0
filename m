From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC PATCH v1] ACPI S3 to work under Xen.
Date: Thu, 1 Sep 2011 14:58:38 +0800
Message-ID: <625BA99ED14B2D499DC4E29D8138F15063048B8696__37963.6131496683$1314929319$gmane$org@shsmsx502.ccr.corp.intel.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, tboot-devel@lists.sourceforge.net
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Thursday, September 01, 2011 2:31 AM
> 
> Attached is an RFC set of patches to enable S3 to work with the Xen hypervisor.
> 
> The relationship that Xen has with Linux kernel is symbiotic. The Linux
> kernel does the ACPI "stuff" and tells the hypervisor to do the low-level
> stuff (such as program the IOAPIC, setup vectors, etc). The realm of
> ACPI S3 is more complex as we need to save the CPU state (and Intel TXT
> values - which the hypervisor has to do) and then restore them.
> 
> The major difficulties we hit was with 'acpi_suspend_lowlevel' - which tweaks
> a lot of lowlevel values and some of them are not properly handled by Xen.
> Liang Tang has figured which ones of them we trip over (read below) - and he
> suggested that perhaps we can provide a registration mechanism to abstract
> this away.

that's not a problem for Xen. On bare metal the processor state handled off
from BIOS after resume (e.g. real mode in many cases) doesn't match the
execution environment expected by Linux. So Linux has to save original context
and then restore it after resume.

However for Xen, Linux doesn't talk to BIOS directly. Instead it simply walks
through necessary ACPI methods, and then issues a hypercall to Xen which
then further completes the remaining suspend steps. So here ACPI S3 is
exactly same as any other hypercall path, where processor context will be
saved/restored by Xen automatically.

> 
> So the attached patches do exactly that - there are two entry points
> in the ACPI.
> 
>  1). For S3: acpi_suspend_lowlevel -> .. lots of code -> acpi_enter_sleep_state
>  2). For S1/S4/S5: acpi_enter_sleep_state
> 
> The first naive idea was of abstracting away in the 'acpi_enter_sleep_state'
> function the tboot_sleep code so that we can use it too. And low-behold - it
> worked splendidly for powering off (S5 I believe)
> 
> For S3 that did not work - during suspend the hypervisor tripped over when
> saving cr8. During resume it tripped over at restoring the cr3, cr8, idt,
> and gdt values.
> 
> What do you guys think? One thought is to use the paravirt interface to
> deal with cr3, cr8, idt, gdt for suspend/resume case.. But that is a lot
> of extra 'if' in the paravirt code  - which the callback registration would
> effectively do the same thing as the paravirt - except at a higher level.
> 

So tweaking at a higher level is a right thing to do.

Thanks
Kevin
