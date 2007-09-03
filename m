From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 3/5] Hibernation: Correct definitions of
	some ioctls
Date: Mon, 3 Sep 2007 03:25:23 +0000
Message-ID: <20070903032523.GH21721@ucw.cz>
References: <200709022315.59652.rjw@sisk.pl> <200709022321.04183.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709022321.04183.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Three ioctl numbers belonging to the hibernation userland interface,
> SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_AVAIL_SWAP, SNAPSHOT_GET_SWAP_PAGE,
> are defined in a wrong way (eg. not portable).  Provide new ioctl numbers for
> these ioctls and mark the existing ones as deprecated.

It looks to me like

> @@ -149,12 +149,9 @@ struct resume_swap_area {
>  #define SNAPSHOT_IOC_MAGIC	'3'
>  #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
>  #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
> -#define SNAPSHOT_ATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
>  #define SNAPSHOT_ATOMIC_RESTORE		_IO(SNAPSHOT_IOC_MAGIC, 4)
>  #define SNAPSHOT_FREE			_IO(SNAPSHOT_IOC_MAGIC, 5)
>  #define SNAPSHOT_SET_IMAGE_SIZE  _IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)

at least set_image_size is wrong - too: we do not use argument as
unsigned long *, and we certainly don't write to it.

> -#define SNAPSHOT_AVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
> -#define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
>  #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
>  #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
>  #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
> @@ -163,7 +160,10 @@ struct resume_swap_area {
>  #define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
>  #define SNAPSHOT_PLATFORM_SUPPORT	_IOR(SNAPSHOT_IOC_MAGIC, 15, int)
>  #define SNAPSHOT_POWER_OFF		_IO(SNAPSHOT_IOC_MAGIC, 16)
> -#define SNAPSHOT_IOC_MAXNR	16
> +#define SNAPSHOT_CREATE_IMAGE		_IOW(SNAPSHOT_IOC_MAGIC, 17, int)
> +#define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 18, -#loff_t)

Should this be _IOW, because we return that value to userspace?

> +#define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 19, loff_t)

Hmm, this looks like _IOW to me, too, plus it does put_user with u64
(at least in my copy, may have been hacked too much).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
