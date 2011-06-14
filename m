From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: [RFC PATCH v3] ARM hibernation/suspend-to-disk
 support
Date: Tue, 14 Jun 2011 09:00:12 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1106140854460.19778__39863.0848191262$1308038476$gmane$org@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
	<20110602221837.GB14328@ucw.cz>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110602221837.GB14328@ucw.cz>
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
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Fri, 3 Jun 2011, Pavel Machek wrote:

> Hi!
>
>> Please let me know what you think,
>> Thanks in advance,
>
>> +void save_processor_state(void)
>> +{
>> +	flush_thread();
>> +	local_fiq_disable();
>> +#ifdef CONFIG_ARM_MACH_HIBERNATION_HOOK
>> +	mach_save_state();
>> +#endif
>> +}
>
> Could we always define mach_save_state, and get rid of ifdef?

Yes ... but it addresses only part of the issue(s). There's some state 
which cannot be saved / restored separately from the core state that's 
dealt with inside swsusp_arch_suspend/resume. This hook couldn't deal with 
that.

Also, if having mach-specific hooks everywhere, wouldn't it be better to 
simply use a platform ops based approach ?

FrankH.



>
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
