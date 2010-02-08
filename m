From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 15/16] PM: remove trailing space in message
Date: Mon, 8 Feb 2010 19:12:37 +0100
Message-ID: <20100208181237.GC1469__14639.0014364899$1265652828$gmane$org@ucw.cz>
References: <201002061844.45212.elendil@planet.nl>
	<1265478443-31072-15-git-send-email-elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1265478443-31072-15-git-send-email-elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat 2010-02-06 18:47:22, Frans Pop wrote:
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: linux-pm@lists.linux-foundation.org
> Cc: Rafael J. Wysocki <rjw@sisk.pl>

ack.

> +++ b/kernel/power/snapshot.c
> @@ -1500,7 +1500,7 @@ asmlinkage int swsusp_save(void)
>  {
>  	unsigned int nr_pages, nr_highmem;
>  
> -	printk(KERN_INFO "PM: Creating hibernation image: \n");
> +	printk(KERN_INFO "PM: Creating hibernation image:\n");
>  
>  	drain_local_pages(NULL);
>  	nr_pages = count_data_pages();

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
