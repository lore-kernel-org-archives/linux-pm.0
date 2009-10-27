From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Fixes warning on suspend errors
Date: Tue, 27 Oct 2009 09:38:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0910270936450.2882-100000__5883.00830354473$1256650781$gmane$org@iolanthe.rowland.org>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DC96A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DC96A@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 27 Oct 2009, Dasgupta, Romit wrote:

> Hi,
>      I get the following errors when I choose devices in /sys/power/pm_test. It also shows that if 'dpm_suspend_start' fails somewhere down the line then the kernel does not reset the 'transition_started' variable and we can get warning similar to below. IMHO 'dpm_resume_noirq' is not the right place for setting this variable. Please see the patch below which fixes the issue.

> Fixes the location where we decide that our power transition is complete.
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e0dc407..6b9e991 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -365,7 +365,6 @@ void dpm_resume_noirq(pm_message_t state)
>  	struct device *dev;
>  
>  	mutex_lock(&dpm_list_mtx);
> -	transition_started = false;
>  	list_for_each_entry(dev, &dpm_list, power.entry)
>  		if (dev->power.status > DPM_OFF) {
>  			int error;
> @@ -529,6 +528,7 @@ static void dpm_complete(pm_message_t state)
>  		put_device(dev);
>  	}
>  	list_splice(&list, &dpm_list);
> +	transition_started = false;
>  	mutex_unlock(&dpm_list_mtx);
>  }

The second hunk is okay, but the first hunk isn't.  We want to set 
transition_started to false as soon as devices start resuming, because 
once a resume has begun it's okay to add new devices.

Alan Stern
