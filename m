From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] Current status,
	suspend-to-disk support on ARM
Date: Tue, 12 Apr 2011 07:59:58 +0200
Message-ID: <20110412055958.GA3507__17282.5455353179$1302588072$gmane$org@ucw.cz>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
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

> There's one ugly thing in this set - I've changed a generic kernel
> header, <linux/suspend.h> to #define save/restore_processor_state()
> on ARM so that it only does preempt_disable/enable(). It's
> surprising that this isn't the default behaviour; all platforms need
> swsusp_arch_suspend/resume anyway so why force the existance of
> _two_ arch-specific hooks ?

Can you submit separate patch cleaning it up?

> @@ -195,6 +195,14 @@ config VECTORS_BASE
>  	help
>  	  The base address of exception vectors.
>  
> +config ARCH_HIBERNATION_POSSIBLE
> +	bool
> +	help
> +	  If the machine architecture supports suspend-to-disk
> +	  it should select this automatically for you.
> +	  Otherwise, say 'Y' at your own peril.
> +

Good for debugging, but not good for mainline.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
