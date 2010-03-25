From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 08/15] PM / Hibernate: add user module_ops
Date: Thu, 25 Mar 2010 23:07:15 +0100
Message-ID: <201003252307.15232.rjw__12206.7455239177$1269554985$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-8-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-8-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Jiri Slaby wrote:
> Add sws_module_ops into /dev/snapshot user interface, so far only with
> .storage_available. The structure will be shortly filled while converting
> it to ops.
> 
> Also, when using this interface, switch to the ops on open/release.

Quite frankly, I don't really understand the purpose of this change in this
particular form.  It looks like it may be folded into one of the subsequent
changes just fine.

Rafael


> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/user.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 68a99c1..20bf34c 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -61,10 +61,20 @@ static struct snapshot_data {
>  	char frozen;
>  	char ready;
>  	char platform_support;
> +	struct sws_module_ops *prev_ops;
>  } snapshot_state;
>  
>  atomic_t snapshot_device_available = ATOMIC_INIT(1);
>  
> +static unsigned long user_storage_available(void)
> +{
> +	return ~0UL; /* we have no idea, maybe we will fail later */
> +}
> +
> +struct sws_module_ops user_ops = {
> +	.storage_available = user_storage_available,
> +};
> +
>  static int snapshot_open(struct inode *inode, struct file *filp)
>  {
>  	struct snapshot_data *data;
> @@ -115,6 +125,10 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>  	}
>  	if (error)
>  		atomic_inc(&snapshot_device_available);
> +	else {
> +		data->prev_ops = sws_io_ops;
> +		sws_io_ops = &user_ops;
> +	}
>  	data->frozen = 0;
>  	data->ready = 0;
>  	data->platform_support = 0;
> @@ -139,6 +153,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
>  		thaw_processes();
>  	pm_notifier_call_chain(data->mode == O_WRONLY ?
>  			PM_POST_HIBERNATION : PM_POST_RESTORE);
> +	sws_io_ops = data->prev_ops;
>  	atomic_inc(&snapshot_device_available);
>  
>  	mutex_unlock(&pm_mutex);
> 
