From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sun, 15 Jul 2007 17:30:04 +0800
Message-ID: <1184491804.1898.121.camel__22386.2225343057$1184491944$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707141159.47289.rjw@sisk.pl>
	<1184410554.1898.84.camel@caritas-dev.intel.com>
	<200707142116.10237.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707142116.10237.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sat, 2007-07-14 at 21:16 +0200, Rafael J. Wysocki wrote:
> > The devices should be quiesced and the state of devices should be saved
> > in kexec_jump, before relocate_kernel is called. This needs the
> > implementation of device hibernating as you mentioned before.
> 
> Hmm, at which point devices are normally shut down when kexec is used?

I think putting devices in quiescent state (not in low power state) is
sufficient for booting a new kernel with kexec, is it? According to my
experiment, the new kernel can be booted with kexec if the .suspend
method the drivers is called before kexec (given CONFIG_ACPI is not
selected).

Do we need a device quiesce/save + device shutdown for kexeced kernel to
work? I don't think so.

> > > >   4. In relocate_kernel, 0~16M is backupped firstly, then the
> > > >      hibernating kernel and initramfs is copied to 0~16M, after that,
> > > >      the hibernating kernel is booted.
> > > >   5. In hibernating kernel, the memory of normal kernel (it is in
> > > >      16M~512M) is saved into a hibernation image through /dev/mem
> > > >      and ELF header.
> > > 
> > > I don't think it can be _that_ simple:
> > > (a) what about processes' memory
> > > (b) what about areas that shouldn't be saved?
> > 
> > The mem_map (struct page[]) of every zone of hibernated kernel is
> > checked.  Necessary pages are saved, like memory snapshot of software
> > suspend, but in user space.
> 
> Well, it's not enough to check that, sorry.  That's why we have
> register_nosave_region().

After some investigation, I found the usage of "nosave" is as follow on
i386:

1. __nosavedata
   used only for global variable in_suspend and swsusp_pg_dir
2. PG_nosave page flags
   used for snapshot itself

Both are not necessary for kexec based hibernation. Because the image
are written from a different kernel, the memory of hibernating kernel
will not be saved, they can be used freely during image writing/reading.

On x86_64, there is another usage of nosave during processing E820
memory map. But I don't know why the memory region other than E820_RAM
are marked as nosave. I think only the memory region of type E820_RAM
will be thought of normal memory, others will be thought as reserved. Is
it sufficient just to check whether the page is reserved?
 
Best Regards,
Huang Ying
