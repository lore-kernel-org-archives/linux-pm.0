From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH-v2 2/8] cpuidle: add
 cpuidle_unregister_driver() error check
Date: Wed, 26 May 2010 22:13:01 -0700
Message-ID: <20100526221301.5a85e3c5.akpm__44575.7578396753$1274937792$gmane$org@linux-foundation.org>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<56b9c89c17c1a85886f6d1928349e35bbb48c856.1274926772.git.len.brown@intel.com>
	<20100526201437.51f5c7f7.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1005270107360.4039@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005270107360.4039@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Mailing List <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 01:11:03 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> BUG_ON() cpuidle_unregister_driver() being called with
> a driver not matching the onee that successfully registered.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/cpuidle/driver.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 2257004..5b6fd0f 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -45,8 +45,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> -	if (!drv)
> -		return;
> +	BUG_ON(drv != cpuidle_curr_driver)
>  
>  	spin_lock(&cpuidle_driver_lock);
>  	cpuidle_curr_driver = NULL;

Actually, WARN_ON is nicer ;)   There's no point in killing the user's
machine over this recoverable error.
