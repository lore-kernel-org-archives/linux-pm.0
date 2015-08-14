From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM-wakeup: Delete unnecessary checks before two
 function calls
Date: Fri, 14 Aug 2015 08:56:52 +0200
Message-ID: <20150814065652.GA31211@Nokia-N900>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <546C7E75.9080301@users.sourceforge.net>
 <558FCAC1.1090605@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558FCAC1.1090605@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Sun 2015-06-28 12:21:53, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 28 Jun 2015 12:14:43 +0200
> 
> The functions dev_pm_disarm_wake_irq() and wakeup_source_unregister() test
> whether their argument is NULL and then return immediately.
> Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

ACK.


> ---
>  drivers/base/power/wakeup.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 40f7160..3741bc2 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -341,8 +341,7 @@ void device_wakeup_arm_wake_irqs(void)
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> -		if (ws->wakeirq)
> -			dev_pm_arm_wake_irq(ws->wakeirq);
> +		dev_pm_arm_wake_irq(ws->wakeirq);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -358,8 +357,7 @@ void device_wakeup_disarm_wake_irqs(void)
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> -		if (ws->wakeirq)
> -			dev_pm_disarm_wake_irq(ws->wakeirq);
> +		dev_pm_disarm_wake_irq(ws->wakeirq);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -396,9 +394,7 @@ int device_wakeup_disable(struct device *dev)
>  		return -EINVAL;
>  
>  	ws = device_wakeup_detach(dev);
> -	if (ws)
> -		wakeup_source_unregister(ws);
> -
> +	wakeup_source_unregister(ws);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_wakeup_disable);
> -- 
> 2.4.4

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
