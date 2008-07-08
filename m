From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Date: Tue, 08 Jul 2008 17:10:09 +0800
Message-ID: <1215508209.29894.8.camel__33736.297945916$1215508136$gmane$org@caritas-dev.intel.com>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080707125010.GA21254@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080707125010.GA21254@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi, Pavel,

On Mon, 2008-07-07 at 20:50 +0800, Pavel Machek wrote:
> Hi!
> 
> The patch looks mostly ok to me. (Perhaps there's time to split it
> into smaller chunks?)
> 
> You can add Acked-by: Pavel Machek <pavel@suse.cz> to it, I guess.

Thank you very much!

[...]
> > @@ -98,16 +101,24 @@ int machine_kexec_prepare(struct kimage
> >   */
> >  void machine_kexec_cleanup(struct kimage *image)
> >  {
> > +     if (nx_enabled)
> > +             set_pages_nx(image->control_code_page, 1);
> >  }
> 
> , 0 ? (setup and cleanup were same, which is strange).

Oh, Yes. That should be 0, I will change it.
> 
> > @@ -1411,3 +1421,50 @@ static int __init crash_save_vmcoreinfo_
> >  }
> > 
> >  module_init(crash_save_vmcoreinfo_init)
> > +
> > +/**
> > + *   kernel_kexec - reboot the system

> Really?

I will change the comments to reflect the changes to kernel_kexec.

> > + *   Move into place and start executing a preloaded standalone
> > + *   executable.  If nothing was preloaded return an error.
> > + */
> > +int kernel_kexec(void)
> > +{
> > +     int error = 0;
> > +
> > +     if (xchg(&kexec_lock, 1))
> > +             return -EBUSY;
> 
> That's quite a strange way to provide a lock. mutex_trylock?

I think this is because kexec_lock is used by crash_kexec() too, which
may be called in some extreme environment, such as during panic().

> > +     if (!kexec_image) {
> > +             error = -EINVAL;
> > +             goto Unlock;
> > +     }
> > +
> > +     if (kexec_image->preserve_context) {
> > +#ifdef CONFIG_KEXEC_JUMP
> > +             local_irq_disable();
> > +             save_processor_state();
> 
> #else
>         BUG()
> 
> ...because otherwise you silently do nothing?
> 
> > +#endif
> 
> Pavel

If CONFIG_KEXEC_JUMP is defined, kexec_image->preserve_context will
always be 0. So current code is safe. Here, #ifdef is used to resolve
the dependency issue. For example, save_processor_state() may be
undefined if CONFIG_KEXEC_JUMP is not defined.

Best Regards,
Huang Ying
