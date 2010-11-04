From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH] pm_qos: Fix reversed min and max
Date: Thu, 4 Nov 2010 14:01:07 -0400
Message-ID: <20101104180107.GA20826__2141.39139648086$1288893839$gmane$org@gvim.org>
References: <1288852803-12356-1-git-send-email-ccross@android.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1288852803-12356-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: mark gross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@suse.de>, linux-pm@lists.linux-foundation.org, stable <stable@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 03, 2010 at 11:40:03PM -0700, Colin Cross wrote:
> pm_qos_get_value had min and max reversed, causing all pm_qos
> requests to have no effect.
sorry.

Acked-by : mark <markgross@thegnar.org>
 

--mgross
 
> Change-Id: I252c764821eac8d94de57eb482c05bf6afcea15b
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: mark gross <markgross@thegnar.org>
> Cc: James Bottomley <James.Bottomley@suse.de>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  kernel/pm_qos_params.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index 645e541..0da2837 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -120,10 +120,10 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
>  
>  	switch (o->type) {
>  	case PM_QOS_MIN:
> -		return plist_last(&o->requests)->prio;
> +		return plist_first(&o->requests)->prio;
>  
>  	case PM_QOS_MAX:
> -		return plist_first(&o->requests)->prio;
> +		return plist_last(&o->requests)->prio;
>  
>  	default:
>  		/* runtime check for not using enum */
> -- 
> 1.7.3.1
> 
