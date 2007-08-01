From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Date: Wed, 01 Aug 2007 15:56:18 +0800
Message-ID: <1185954978.1363.23.camel__35151.3704554693$1185955098$gmane$org@caritas-dev.intel.com>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731095101.GA1774@elf.ucw.cz>
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

On Tue, 2007-07-31 at 11:51 +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch implement the functionality of jumping from kexeced kernel
> > to original kernel.
> > 
> > A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> > trigger the jumping to (executing) the new kernel or jumping back to
> > the original kernel.
> 
> Could we get two reboot commands? Exec loaded kernel seems to be quite
> different operation than "jump back".

Exec loaded kernel for jumping back is also different from exec loaded
kernel normally.

Maybe the two reboot operations in kexec jump can be seen as "jump to"
and "jump back"?

> How do I test these patches? kexec -p <bzImage>, then kexec -j?

Yes.

> > +static unsigned long kexec_backup_addr = ~0UL;
> > +
> > +/* kexec_backup= specifies the location of backuped 0~640k memory of
> > + * crashed kernel.
> > + */
> > +static int __init parse_kexec_backup(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	kexec_backup_addr = memparse(arg, &arg);
> > +	return 0;
> > +}
> > +early_param("kexec_backup", parse_kexec_backup);
> 
> New kernel parameters should be documented. (Plus I do not know how to
> use this one, please help :-).

This kernel parameter will be added to kernel command line by
kexec-tools automatically.

I will add corresponding document in next version.

> 
> > +int kexec_flags;
> > +
> > +static unsigned long kexec_jump_buf_pfn;
> > +
> > +static int __init parse_kexec_jump_buf_pfn(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	kexec_jump_buf_pfn = memparse(arg, &arg);
> > +	kexec_flags |= KEXEC_FLAGS_IS_KEXECED_KERNEL;
> > +	return 0;
> > +}
> > +early_param("kexec_jump_buf_pfn", parse_kexec_jump_buf_pfn);
> 
> This one should be documented, too, I'd guess. (Is that internal,
> kernel-to-kernel communication?)

Document will be added in next version too.

This parameter is used for kernel-to-kernel communication. But now, it
must be setup by user, as in usage guide.

Best Regards,
Huang Ying
