From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm / core bugfix: report error return from
	suspend_enter
Date: Sat, 23 Apr 2011 00:13:27 +0200
Message-ID: <201104230013.27359.rjw__4944.80722486532$1303510691$gmane$org@sisk.pl>
References: <1303456931-11657-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1303456931-11657-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, April 22, 2011, MyungJoo Ham wrote:
> The current implementation of suspend-to-RAM returns 0 if there is an
> error from suspend_enter() because suspend_devices_and_enter() ignores
> the return value from suspend_enter(). This patch addresses this issue
> and properly keep the error return from suspend_enter() and let
> suspend_devices_and_enter relay the error return.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
>  kernel/power/suspend.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 2814c32..08515b4 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -224,7 +224,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  	if (suspend_test(TEST_DEVICES))
>  		goto Recover_platform;
>  
> -	suspend_enter(state);
> +	error = suspend_enter(state);
>  
>   Resume_devices:
>  	suspend_test_start();
> 
