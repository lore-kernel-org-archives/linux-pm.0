From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] add helper for translation of runtime PM errors
Date: Thu, 11 Sep 2014 10:04:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1409111003160.1357-100000@iolanthe.rowland.org>
References: <1410442129-21130-1-git-send-email-oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41356 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752915AbaIKOEN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 10:04:13 -0400
In-Reply-To: <1410442129-21130-1-git-send-email-oneukum@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Thu, 11 Sep 2014, Oliver Neukum wrote:

> pm_runtime_get() returns specialised error codes. They are not
> fit to be returned to user space. This patch adds a helper
> for translation.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  include/linux/pm_runtime.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 367f49b..67d078f 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -128,6 +128,27 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
>  	ACCESS_ONCE(dev->power.last_busy) = jiffies;
>  }
>  
> +static inline int pm_runtime_translate_errors(int error)
> +{
> +	int rv;
> +
> +	switch (error) {
> +	case 0:
> +	case -ENOMEM:
> +	case -EBUSY:
> +		rv = error;
> +		break;
> +	case -EINPROGRESS:
> +		rv = -EAGAIN;
> +		break;
> +	default:
> +		rv = error > 0 ? error : -EIO;
> +		break;
> +	}
> +
> +	return rv;
> +}

Is this function small enough to be worth inlining?

Alan Stern

