From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH] PM-wakeup: Delete unnecessary checks before two function
 calls
Date: Fri, 22 Jul 2016 22:35:27 +0200
Message-ID: <427a7f9d-d1c2-10be-9a23-30350ced6149@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <546C7E75.9080301@users.sourceforge.net>
 <558FCAC1.1090605@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <558FCAC1.1090605@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

Am 28.06.2015 um 12:21 schrieb SF Markus Elfring:
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
> 

How do you think about to integrate this update suggestion
into another source code repository?

Regards,
Markus
