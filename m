From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 2/3 -mm] kexec jump -v8 : add write support
	to oldmem device
Date: Fri, 21 Dec 2007 20:50:19 +0800
Message-ID: <851fc09e0712210450i1c39a37fxe716ffcd5de59850__11005.9486622506$1198241506$gmane$org@mail.gmail.com>
References: <1198222420.1965.21.camel@caritas-dev.intel.com>
	<20071221101710.GB10573@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071221101710.GB10573@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Dec 21, 2007 6:17 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > This patch adds writing support for /dev/oldmem. This can be used to
> >
> > - Communicate between original kernel and kexeced kernel through write
> >   to some pages in original kernel.
> >
> > - Restore the memory contents of hibernated system in kexec based
> >   hibernation.
> >
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> >
> > --- a/arch/x86/kernel/crash_dump_32.c
> > +++ b/arch/x86/kernel/crash_dump_32.c
> > +ssize_t write_oldmem_page(unsigned long pfn, const char *buf,
> > +                       size_t csize, unsigned long offset, int
> > userbuf)
>
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -348,6 +348,37 @@ static ssize_t read_oldmem(struct file *
> >       }
> >       return read;
> >  }
> > +
> > +/*
> > + * Write memory corresponding to the old kernel.
> > + */
> > +static ssize_t write_oldmem(struct file *file, const char __user *buf,
> > +                         size_t count, loff_t *ppos)
> > +{
> ...
> > +             rc = write_oldmem_page(pfn, buf, csize, offset, 1);
>
> I believe this is going to break compilation on non-32bit
> machines.

Yes, I will fix this.

Best Regards,
Huang Ying
