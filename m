From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Sun, 5 Aug 2007 20:55:58 +0200
Message-ID: <20070805185558.GE1758__10704.2522904978$1186340331$gmane$org@elf.ucw.cz>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731110458.GA1777@elf.ucw.cz>
	<1185932071.1363.13.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1185932071.1363.13.camel@caritas-dev.intel.com>
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
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > root@amd:~# kexec -p /data/l/linux/arch/i386/boot/bzImage --append="init=/bin/bash kexec_jump_buf_pfn=`cat /sys/kernel/kexec_jump_buf_pfn`"
> > Could not find a free area of memory of 9000 bytes...
> > locate_hole failed
> > root@amd:~#
> > 
> > What am I doing wrong?
> 
> The kexec-tools version 1.101 does not work perfectly with relocatable
> kernel. This would have been solved if I worked against kexec-tools
> testing tree. I will work against testing tree in the next version.
> 
> But, with some trick, it can work. When configure kernel, make sure the
> following option is set:
> 
> CONFIG_PHYSICAL_START=0x4000000 # if crashkernel=<XX>M@64M

Did the trick, I got the kernel to load, and it even attempted
exec... but I got doublefault (or what is it?)

Int 6: ... EIP: c4739906. Address is in reserve_bootmem_core.

Do I have to disable ACPI completely? I tried with acpi=off,
nosmp... but problem does not seem device related.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
