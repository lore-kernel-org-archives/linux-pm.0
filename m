From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Sun, 15 Jul 2007 12:09:05 +0200
Message-ID: <200707151209.06529.rjw__46360.3322198198$1184493764$gmane$org@sisk.pl>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184483593.1898.98.camel@caritas-dev.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 15 July 2007 09:13, Huang, Ying wrote:
> The changelog between v1 and v2
> 
> 1. The kexec jump implementation is put into the kexec/kdump
>    framework instead of software suspend framework. The device
>    and CPU state save/restore code of software suspend is called
>    when needed.
> 
> 2. The same code path is used for both kexec a new kernel and jump
>    back to original kernel.
> 
> The complete changelog of the patch is as follow:
> 
> ---
> 
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:
> 
> 1. The hibernation image size can exceed half of memory size easily.

In TuxOnIce (suspend2) there's no such limitation.

> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.

You can do this, too, with uswsusp.

> This patch implements the functionality of "jumping from kexeced
> kernel to original kernel". That is, the following sequence is
> possible:
> 
> 1. Boot a kernel A
> 2. Work under kernel A
> 3. Kexec another kernel B in kernel A
> 4. Work under kernel B
> 5. Jump from kernel B to kernel A
> 6. Continue work under kernel A
> 
> This is the first step to implement kexec based hibernation. If the
> memory image of kernel A is written to or read from a permanent media
> in step 4, a preliminary version of kexec based hibernation can be
> implemented.
> 
> The kernel B run as a crashdump kernel in reserved memory region. This
> is the biggest constrains of the patch. It is planed to be eliminated
> in the future version. That is, instead of reserving memory region
> previously, the needed memory region is backupped before kexec and
> restored after jumping back.
> 
> Another constrains of the patch is that the CONFIG_ACPI must be turned
> off to make kexec jump work. Because ACPI will put devices into low
> power state, the kexeced kernel can not be booted properly under
> it. This constrains can be eliminated by separating the suspend method
> and hibernate method of the devices as proposed earlier in the LKML.
> 
> The kexec jump is implemented in the framework of kexec/kdump. In
> sys_reboot, a new command named LINUX_REBOOT_CMD_KJUMP is defined to
> trigger the jumping to (executing) the new kernel or jump back to the
> original kernel.
> 
> Now, only the i386 architecture is supported. The patch is based on
> Linux kernel 2.6.22, and has been tested on my IBM T42.
> 
> Usage:
> 
> 1. Compile kernel with following options selected:
> 
> CONFIG_X86_32=y
> CONFIG_RELOCATABLE=y # not needed strictly, but it is more convenient with it
> CONFIG_KEXEC=y
> CONFIG_PM=y
> CONFIG_KEXEC_JUMP=y
> 
> 2. Compile the kexec-tools with kdump and kjump patches, the
>    kdump patch can be found at:
> 
> http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-kdump10.patch
> 
>    While, the kexec-tools kjump patch is appended with the mail.
> 
> 3. Boot kernel compiled for normal usage, the reserved crash kernel
>    memory region must be added to kernel command line as following:
> 
>    crashkernel=<XX>M@<XX>M
> 
>    Where, <XX> should be replaced by the real memory size and position.
> 
> 4. Load kernel compiled for hibernating usage as a crashdump kernel
>    with kexec, the same kernel as that of 3 can be used if
>    CONFIG_RELOCATABLE=y is selected. The kernel command line option as
>    following must be appended to kernel command line.
> 
>    kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`
> 
>    For example, the shell command line can be as follow:
> 
>    kexec -p /boot/vmlinux --args-linux --append="root=/dev/hdb signal
>        kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`"
> 
> 5. Boot the hibernating kernel with following shell command line:
> 
>    kexec -j
> 
> 6. In the kexec booted kernel, trigger the jumping back with following
>    shell command.
> 
>    kexec -j

Well, I think that's _way_ too much complicated to be useful for hibernation
on systems that are set up and administered by average users.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
