From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v10] PM / hibernate: Verify the consistent of e820
 memory map by md5 digest
Date: Sat, 15 Oct 2016 20:18:02 +0800
Message-ID: <20161015121801.GA18946@sharon>
References: <1473423687-4889-1-git-send-email-yu.c.chen@intel.com>
 <CAK1hOcONO0Bkin5obU1Qb=7qbmqTJMcfYLXNCPj6=4Tht-=z-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32916 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbcJOMJe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 15 Oct 2016 08:09:34 -0400
Content-Disposition: inline
In-Reply-To: <CAK1hOcONO0Bkin5obU1Qb=7qbmqTJMcfYLXNCPj6=4Tht-=z-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-pm@vger.kernel.org, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

Hi,
On Thu, Oct 13, 2016 at 03:10:18PM +0200, Denys Vlasenko wrote:
> On Fri, Sep 9, 2016 at 2:21 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> > On some platforms, there is occasional panic triggered when trying to
> > resume from hibernation, a typical panic looks like:
> >
> > "BUG: unable to handle kernel paging request at ffff880085894000
> > IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"
> >
> > Investigation carried out by Lee Chun-Yi show that this is because
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
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> 
> > +static int get_e820_md5(struct e820map *map, void *buf)
> > +{
> > +       struct scatterlist sg;
> > +       struct crypto_ahash *tfm;
> > +       struct ahash_request *req;
> > +       int ret = 0;
> > +
> > +       tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> > +       if (IS_ERR(tfm))
> > +               return -ENOMEM;
> > +
> > +       req = ahash_request_alloc(tfm, GFP_KERNEL);
> > +       if (!req) {
> > +               ret = -ENOMEM;
> > +               goto free_ahash;
> > +       }
> 
> I looked elsewhere in kernel, and there is this idiom for placing
> struct ahash_request on stack. Instead of the ahash_request_alloc()
> and never-actually-tirggering-error handling, you can do:
> 
>      {
>           AHASH_REQUEST_ON_STACK(req, tfm);
> 
> > +
> > +       sg_init_one(&sg, (u8 *)map, sizeof(struct e820map));
> > +       ahash_request_set_callback(req, 0, NULL, NULL);
> > +       ahash_request_set_crypt(req, &sg, buf, sizeof(struct e820map));
> > +
> > +       if (crypto_ahash_digest(req))
> > +               ret = -EINVAL;
> > +
> > +       ahash_request_free(req);
> > + free_ahash:
> 
> and, naturally, the free() and the label would not be needed too,
> just close the one extra brace:
> 
> > +       crypto_free_ahash(tfm);
> > +
> > +       return ret;
> 
>       }
> 
> > +}
OK, thanks for point it out, will do in next version.

Yu
