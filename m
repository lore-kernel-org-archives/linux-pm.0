From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: mark serio and i8042 as suspended
	when hibernating too.
Date: Tue, 7 Jul 2009 00:40:42 +0200
Message-ID: <200907070040.43299.rjw__2889.48371676288$1246920085$gmane$org@sisk.pl>
References: <1246760019-4120-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1246760019-4120-1-git-send-email-cascardo@holoscopio.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, linux-input@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, maciej.rutecki@gmail.com
List-Id: linux-pm@vger.kernel.org

On Sunday 05 July 2009, Thadeu Lima de Souza Cascardo wrote:
> serio ports are not being restarted any longer because resume operations
> after hibernate do nothing, since the device has not been marked as
> suspended. This happens because suspend is only considering the SUSPEND
> event but not the FREEZE event.
> 
> Note that this driver has still to migrate to dev_pm_ops, but this fixes
> this particular bug now.

Hmm, this looks like a fix for:
http://bugzilla.kernel.org/show_bug.cgi?id=13643

Any objections to merging it through the suspend tree?

Best,
Rafael


> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  drivers/input/serio/i8042.c |    7 ++++---
>  drivers/input/serio/serio.c |    7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index f919bf5..582245c 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -934,10 +934,11 @@ static bool i8042_suspended;
>  
>  static int i8042_suspend(struct platform_device *dev, pm_message_t state)
>  {
> -	if (!i8042_suspended && state.event == PM_EVENT_SUSPEND) {
> +	if (!i8042_suspended && state.event == PM_EVENT_SUSPEND)
>  		i8042_controller_reset();
> -		i8042_suspended = true;
> -	}
> +
> +	i8042_suspended = state.event == PM_EVENT_SUSPEND ||
> +			  state.event == PM_EVENT_FREEZE;
>  
>  	return 0;
>  }
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index fb17573..d66f494 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -935,10 +935,11 @@ static int serio_suspend(struct device *dev, pm_message_t state)
>  {
>  	struct serio *serio = to_serio_port(dev);
>  
> -	if (!serio->suspended && state.event == PM_EVENT_SUSPEND) {
> +	if (!serio->suspended && state.event == PM_EVENT_SUSPEND)
>  		serio_cleanup(serio);
> -		serio->suspended = true;
> -	}
> +
> +	serio->suspended = state.event == PM_EVENT_SUSPEND ||
> +			   state.event == PM_EVENT_FREEZE;
>  
>  	return 0;
>  }
