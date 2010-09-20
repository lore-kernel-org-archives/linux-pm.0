From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Fix signed/unsigned warning
Date: Mon, 20 Sep 2010 21:27:24 +0200
Message-ID: <201009202127.24691.rjw__29578.8220399574$1285013632$gmane$org@sisk.pl>
References: <8136c24e8aaf577b86dfdfc40b0d01e6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8136c24e8aaf577b86dfdfc40b0d01e6@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 20, 2010, Kevin Cernekee wrote:
> Seen on MIPS32, gcc 4.4.3, 2.6.36-rc4:
> 
> drivers/base/power/main.c: In function 'dpm_show_time':
> drivers/base/power/main.c:415: warning: comparison of distinct pointer types lacks a cast
> 
> do_div() takes unsigned parameters:
> 
> uint32_t do_div(uint64_t *n, uint32_t base);
> 
> Using an unsigned variable for usecs64 should not cause any problems,
> because calltime >= starttime .
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

OK, I'm going to apply it.

Thanks,
Rafael


> ---
>  drivers/base/power/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 276d5a7..db67719 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -407,7 +407,7 @@ static void pm_dev_err(struct device *dev, pm_message_t state, char *info,
>  static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
>  {
>  	ktime_t calltime;
> -	s64 usecs64;
> +	u64 usecs64;
>  	int usecs;
>  
>  	calltime = ktime_get();
> 
