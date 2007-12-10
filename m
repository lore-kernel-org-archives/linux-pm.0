From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec
	jump
Date: Mon, 10 Dec 2007 17:31:17 -0500
Message-ID: <20071210223117.GC27124__12660.9987150461$1197326052$gmane$org@redhat.com>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1197042810.24045.61.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 07, 2007 at 03:53:30PM +0000, Huang, Ying wrote:
> This patch implements the functionality of jumping between the kexeced
> kernel and the original kernel.
> 
> To support jumping between two kernels, before jumping to (executing)
> the new kernel and jumping back to the original kernel, the devices
> are put into quiescent state, and the state of devices and CPU is
> saved. After jumping back from kexeced kernel and jumping to the new
> kernel, the state of devices and CPU are restored accordingly. The
> devices/CPU state save/restore code of software suspend is called to
> implement corresponding function.
> 
> To support jumping without reserving memory. One shadow backup page
> (source page) is allocated for each page used by new (kexeced) kernel
> (destination page). When do kexec_load, the image of new kernel is
> loaded into source pages, and before executing, the destination pages
> and the source pages are swapped, so the contents of destination pages
> are backupped. Before jumping to the new (kexeced) kernel and after
> jumping back to the original kernel, the destination pages and the
> source pages are swapped too.
> 
> A jump back protocol for kexec is defined and documented. It is an
> extension to ordinary function calling protocol. So, the facility
> provided by this patch can be used to call ordinary C function in real
> mode.
> 
> A set of flags for sys_kexec_load are added to control which state are
> saved/restored before/after real mode code executing. For example, you
> can specify the device state and FPU state are saved/restored
> before/after real mode code executing.
> 
> The states (exclude CPU state) save/restore code can be overridden
> based on the "command" parameter of kexec jump. Because more states
> need to be saved/restored by hibernating/resuming.
> 


[..]
>  
> -#define KEXEC_ON_CRASH  0x00000001
> -#define KEXEC_ARCH_MASK 0xffff0000
> +#define KEXEC_ON_CRASH		0x00000001
> +#define KEXEC_PRESERVE_CPU	0x00000002
> +#define KEXEC_PRESERVE_CPU_EXT	0x00000004
> +#define KEXEC_SINGLE_CPU	0x00000008
> +#define KEXEC_PRESERVE_DEVICE	0x00000010
> +#define KEXEC_PRESERVE_CONSOLE	0x00000020

Hi,

Why do we need so many different flags for preserving different types
of state (CPU, CPU_EXT, Device, console) ? To keep things simple,
can't we can create just one flag KEXEC_PRESERVE_CONTEXT, which will
indicate any special action required for preserving the previous kernel's
context so that one can swith back to old kernel?

Thanks
Vivek
