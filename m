From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 01/38] pm: Move nvs routines into a seperate
	file.
Date: Mon, 8 Jun 2009 08:35:01 +0200
Message-ID: <20090608063501.GC1444__2949.51064647666$1244474489$gmane$org@ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161859.713228968@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090604161859.713228968@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-06-04 18:18:48, Martin Schwidefsky wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> The *_nvs_* routines in swsusp.c make use of the io*map()
> functions, which are only provided for HAS_IOMEM, thus
> breaking compilation if HAS_IOMEM is not set. Fix this
> by moving the *_nvs_* routines into nvs.c, which is only
> compiled if HAS_IOMEM is set.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  include/linux/suspend.h |   18 ++++--
>  kernel/power/Kconfig    |    4 +
>  kernel/power/Makefile   |    1 
>  kernel/power/nvs.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/swsusp.c   |  122 --------------------------------------------
>  5 files changed, 147 insertions(+), 129 deletions(-)
> 
> Index: linux-2.6/kernel/power/nvs.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/kernel/power/nvs.c

Ideally, filename would be a bit more descriptive. 

> @@ -0,0 +1,131 @@
> +/*
> + * Routines for NVS memory handling
> + */

If you copy&pasted code, you need to copy&paste copyright notices, too.

> --- linux-2.6.orig/kernel/power/Makefile
> +++ linux-2.6/kernel/power/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_PM)		+= main.o
>  obj-$(CONFIG_PM_SLEEP)		+= console.o
>  obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
> +obj-$(CONFIG_NVS)		+= nvs.o
>  
>  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o

CONFIG_NVS is definitely not descriptive enough. C_HIBERNATION_NVS?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
