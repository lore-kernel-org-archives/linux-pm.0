From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] cpuidle: add cpuidle_unregister_driver()
 error check
Date: Wed, 26 May 2010 20:14:37 -0700
Message-ID: <20100526201437.51f5c7f7.akpm__2505.47052496604$1274930119$gmane$org@linux-foundation.org>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<56b9c89c17c1a85886f6d1928349e35bbb48c856.1274926772.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <56b9c89c17c1a85886f6d1928349e35bbb48c856.1274926772.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010 22:42:25 -0400 Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> When cpuidle_unregister_driver() is called with a driver
> other than the one that was successfully registered, do nothing.
> 
> Previously we'd NULL-out the one that was registered.
> But that required the callers to remember what this
> routine already remembers.  With this check, the callers
> can be simplified.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/cpuidle/driver.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 2257004..30bcd44 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -49,7 +49,8 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  		return;
>  
>  	spin_lock(&cpuidle_driver_lock);
> -	cpuidle_curr_driver = NULL;
> +	if (drv == cpuidle_curr_driver)
> +		cpuidle_curr_driver = NULL;
>  	spin_unlock(&cpuidle_driver_lock);
>  }

This can only happen as a result of a coding bug, yes?  If so, the
kernel should go BUG() rather than secretly concealing the problem.

Also (alternatively), the `drv' arg to this function is superfluous?
