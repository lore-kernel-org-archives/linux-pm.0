From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Date: Tue, 31 Jul 2007 11:51:01 +0200
Message-ID: <20070731095101.GA1774__12485.0829052322$1185875795$gmane$org@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1184483639.1898.99.camel@caritas-dev.intel.com>
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

> This patch implement the functionality of jumping from kexeced kernel
> to original kernel.
> 
> A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> trigger the jumping to (executing) the new kernel or jumping back to
> the original kernel.

Could we get two reboot commands? Exec loaded kernel seems to be quite
different operation than "jump back".

How do I test these patches? kexec -p <bzImage>, then kexec -j?


> +static unsigned long kexec_backup_addr = ~0UL;
> +
> +/* kexec_backup= specifies the location of backuped 0~640k memory of
> + * crashed kernel.
> + */
> +static int __init parse_kexec_backup(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	kexec_backup_addr = memparse(arg, &arg);
> +	return 0;
> +}
> +early_param("kexec_backup", parse_kexec_backup);

New kernel parameters should be documented. (Plus I do not know how to
use this one, please help :-).


> +int kexec_flags;
> +
> +static unsigned long kexec_jump_buf_pfn;
> +
> +static int __init parse_kexec_jump_buf_pfn(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	kexec_jump_buf_pfn = memparse(arg, &arg);
> +	kexec_flags |= KEXEC_FLAGS_IS_KEXECED_KERNEL;
> +	return 0;
> +}
> +early_param("kexec_jump_buf_pfn", parse_kexec_jump_buf_pfn);

This one should be documented, too, I'd guess. (Is that internal,
kernel-to-kernel communication?)

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
