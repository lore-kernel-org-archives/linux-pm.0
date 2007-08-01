From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Wed, 01 Aug 2007 09:34:31 +0800
Message-ID: <1185932071.1363.13.camel__17850.8028890521$1185932152$gmane$org@caritas-dev.intel.com>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731110458.GA1777@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731110458.GA1777@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-31 at 13:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > 3. Boot kernel compiled for normal usage, the reserved crash kernel
> >    memory region must be added to kernel command line as following:
> > 
> >    crashkernel=<XX>M@<XX>M
> > 
> >    Where, <XX> should be replaced by the real memory size and
> > position.
> 
> I used crashkernel=64M@64M .
> 
> 
> > 4. Load kernel compiled for hibernating usage as a crashdump kernel
> >    with kexec, the same kernel as that of 3 can be used if
> >    CONFIG_RELOCATABLE=y is selected. The kernel command line option as
> >    following must be appended to kernel command line.
> > 
> >    kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`
> > 
> >    For example, the shell command line can be as follow:
> > 
> >    kexec -p /boot/vmlinux --args-linux --append="root=/dev/hdb signal
> >        kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`"
> 
> I think I followed the instructions closely. Now I'm trying to do 
> 
> kexec -p /data/l/linux/vmlinux --args-linux --append="init=/bin/bash
> kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`"
> 
> but it tells me:
> 
> Invalid memory segment 0x100000 - 0x7a0fff
> 
> (and nothing in dmesg) 
> 
> If I try to load bzImage (corresponding to vmlinux I tried to use),  I
> get:
> 
> root@amd:~# kexec -p /data/l/linux/arch/i386/boot/bzImage --append="init=/bin/bash kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`"
> Could not find a free area of memory of 9000 bytes...
> locate_hole failed
> root@amd:~#
> 
> What am I doing wrong?

The kexec-tools version 1.101 does not work perfectly with relocatable
kernel. This would have been solved if I worked against kexec-tools
testing tree. I will work against testing tree in the next version.

But, with some trick, it can work. When configure kernel, make sure the
following option is set:

CONFIG_PHYSICAL_START=0x4000000 # if crashkernel=<XX>M@64M

Best Regards,
Huang Ying
