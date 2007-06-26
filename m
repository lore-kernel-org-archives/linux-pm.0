From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 8/8] PM: Rename hibernation_ops
	to platform_hibernation_operations
Date: Tue, 26 Jun 2007 10:54:23 +0200
Message-ID: <20070626085423.GC4594@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
	<200706260052.28206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706260052.28206.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> Rename 'struct hibernation_ops' to 'struct platform_hibernation_operations' in
> analogy with 'struct platform_suspend_operations'.

Can I NAK it because it gets too long? platform_hibernation_ops /
platform_suspend_ops is long but maybe acceptable, 'struct
platform_hibernation_operations' is too long.
							Pavel

> @@ -185,14 +185,15 @@ extern void swsusp_set_page_free(struct 
>  extern void swsusp_unset_page_free(struct page *);
>  extern unsigned long get_safe_page(gfp_t gfp_mask);
>  
> -extern void hibernation_set_ops(struct hibernation_ops *ops);
> +extern void hibernation_set_ops(struct platform_hibernation_operations *ops);
>  extern int hibernate(void);
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
