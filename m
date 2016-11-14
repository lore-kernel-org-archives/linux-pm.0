From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v12] PM / hibernate: Verify the consistent of e820 memory map by md5 digest
Date: Mon, 14 Nov 2016 01:26:28 +0100
Message-ID: <9363379.0isTar43qg@vostro.rjw.lan>
References: <1476951292-19619-1-git-send-email-yu.c.chen@intel.com> <20161022030302.GB26548@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161022030302.GB26548@linux-rxt1.site>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, October 22, 2016 11:03:02 AM joeyli wrote:
> Hi Chen Yu,
> 
> On Thu, Oct 20, 2016 at 04:14:52PM +0800, Chen Yu wrote:
> > On some platforms, there is occasional panic triggered when
> > trying to resume from hibernation, a typical panic looks like:
> > 
> > "BUG: unable to handle kernel paging request at ffff880085894000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> > 
> > Investigation carried out by Lee Chun-Yi shows that this is because
> > e820 map has been changed by BIOS across hibernation, and one
> > of the page frames from suspend kernel is right located in restore
> > kernel's unmapped region, so panic comes out when accessing unmapped
> > kernel address.
> > 
> > In order to expose this issue earlier, the md5 hash of e820 map
> > is passed from suspend kernel to restore kernel, and the restore
> > kernel will terminate the resume process once it finds the md5
> > hash are not the same.
> > 
> > As the format of image header has been modified, the magic number
> > should also be adjusted as kernels with the same RESTORE_MAGIC have
> > to use the same header format and interpret all of the fields in
> > it in the same way.
> > 
> > If the suspend kernel is built without md5 support, and the restore
> > kernel has md5 support, then the latter will bypass the check process.
> > Vice versa the restore kernel will bypass the check if it does not
> > support md5 operation.
> > 
> > Note:
> > 1. Without this patch applied, it is possible that BIOS has
> >    provided an inconsistent memory map, but the resume kernel is still
> >    able to restore the image anyway(e.g, E820_RAM region is the superset
> >    of the previous one), although the system might be unstable. So this
> >    patch tries to treat any inconsistent e820 as illegal.
> > 
> > 2. Another case is, this patch replies on comparing the e820_saved, but
> >    currently the e820_save might not be strictly the same across
> >    hibernation, even if BIOS has provided consistent e820 map - In
> >    theory mptable might modify the BIOS-provided e820_saved dynamically
> >    in early_reserve_e820_mpc_new, which would allocate a buffer from
> >    E820_RAM, and marks it from E820_RAM to E820_RESERVED).
> >    This is a potential and rare case we need to deal with in OS in
> >    the future.
> > 
> > Suggested-by: Pavel Machek <pavel@ucw.cz>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Lee Chun-Yi <jlee@suse.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Please feel free to add:
> 	Reviewed-by: Lee, Chun-Yi <jlee@suse.com>

Applied (with the tag above).

Thanks,
Rafael
