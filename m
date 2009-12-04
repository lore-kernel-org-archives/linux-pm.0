From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] intel_txt: add s3 userspace memory
	integrity	verification
Date: Fri, 4 Dec 2009 09:29:27 +0100
Message-ID: <20091204082927.GF1540__45181.942129466$1259939600$gmane$org@ucw.cz>
References: <4B18D26B.4040500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B18D26B.4040500@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shane Wang <shane.wang@intel.com>
Cc: len.brown@intel.com, "Cihula, Joseph" <joseph.cihula@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbeulich@novell.com" <jbeulich@novell.com>, "jmorris@namei.org" <jmorris@namei.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "peterm@redhat.com" <peterm@redhat.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "arjan@linux.intel.com" <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



> This patch added verification for userspace memory integrity after
>  S3 resume.

It does not work.

> Integrity verification for other memory (say kernel itself) has been done by tboot.
>

Not true. Kernel  uses memory above 4G on x86-64. Including... say
console writing functions.

You can patch holes, but without description 'what does this protect
against' it is almost impossible to evaluate.


> +void tboot_do_suspend_lowlevel(void)
> +{
> +	int ret = -1;
> +
> +	if (!tboot_enabled()) {
> +		do_suspend_lowlevel();
> +		return;
> +	}
> +
> +	ret = tboot_pre_stack_switch();
> +	if (!ret) {
> +		tboot_switch_stack_call(tboot_do_suspend_lowlevel_call,
> +					(u64)new_stack_ptr);

...and here you add requirements to suspend_lowlevel that were not
there before. ("May not act on unchecksummed memory"), without
documenting them.

NAK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
