From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [RFC PATCH v1] ACPI S3 to work under Xen.
Date: Fri, 2 Sep 2011 12:52:58 +0100
Message-ID: <alpine.DEB.2.00.1109021249540.12963__13738.289816729$1314963985$gmane$org@kaball-desktop>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "len.brown@intel.com" <len.brown@intel.com>, "joseph.cihula@intel.com" <joseph.cihula@intel.com>, "keir@xen.org" <keir@xen.org>, "shane.wang@intel.com" <shane.wang@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Aug 2011, Konrad Rzeszutek Wilk wrote:
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
> Thoughts?
 

I think there are no doubts about the fact that this approach produces
cleaner code than using the pvop interface for dealing with cr3, cr8,
etc.
Also, having seen the original xen acpi implementation in 2.6.18, I want
to add that you did a _very_ good job with this series.
