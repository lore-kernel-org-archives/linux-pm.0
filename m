From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] Suspend: Use common prefix in messages
Date: Tue, 27 Nov 2007 01:21:45 +0100
Message-ID: <20071127002145.GD9759__12813.6046849706$1196123006$gmane$org@elf.ucw.cz>
References: <200711270025.08128.rjw@sisk.pl> <200711270030.10561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711270030.10561.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make suspend messages start with one common prefix "PM: ".
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I do not think I like the PREFIX idea (see other message).


> @@ -344,11 +344,12 @@ static int enter_state(suspend_state_t s
>  	if (!mutex_trylock(&pm_mutex))
>  		return -EBUSY;
>  
> -	printk("Syncing filesystems ... ");
> +	printk(KERN_INFO PREFIX "Syncing filesystems ... ");
>  	sys_sync();
> -	printk("done.\n");
> +	printk(KERN_INFO "done.\n");


Plus this is wrong.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
