From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v3] ARM hibernation/suspend-to-disk
 support
Date: Fri, 3 Jun 2011 00:18:37 +0200
Message-ID: <20110602221837.GB14328__35054.3967717842$1308033754$gmane$org@ucw.cz>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Please let me know what you think,
> Thanks in advance,

> +void save_processor_state(void)
> +{
> +	flush_thread();
> +	local_fiq_disable();
> +#ifdef CONFIG_ARM_MACH_HIBERNATION_HOOK
> +	mach_save_state();
> +#endif
> +}

Could we always define mach_save_state, and get rid of ifdef?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
