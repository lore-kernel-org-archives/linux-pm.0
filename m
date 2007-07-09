From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/6] Freezer: Be more verbose
Date: Tue, 10 Jul 2007 01:46:25 +0200
Message-ID: <20070709234625.GK1967@elf.ucw.cz>
References: <200707092229.08898.rjw@sisk.pl> <200707092233.52475.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707092233.52475.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Increase the freezer's verbosity a bit, so that it's easier to read problem
> reports related to it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/process.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
> ===================================================================
> --- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
> +++ linux-2.6.22-rc6-mm1/kernel/power/process.c
> @@ -237,20 +237,23 @@ static int try_to_freeze_tasks(int freez
>   */
>  int freeze_processes(void)
>  {
> -	int error;
> +	int error = 0;

You set error unconditionally few lines below.

> -	printk("Stopping tasks ... ");
> +	printk("Freezing user space processes ... ");
>  	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
>  	if (error)
> -		return error;
> +		goto Exit;
> +	printk("done.\n");
>  
> +	printk("Freezing remaining freezable tasks ... ");

can we ust do printk(" rest ... "); ? Saves one line... and suspend
process is too verbose anyway.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
