From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] PM-wakeup: Deletion of an unnecessary check before
 the function call "wakeup_source_unregister"
Date: Wed, 19 Nov 2014 15:09:15 +0300
Message-ID: <20141119120915.GM4905@mwanda>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <546C7E75.9080301@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546C7E75.9080301@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 19, 2014 at 12:26:45PM +0100, SF Markus Elfring wrote:
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -267,8 +267,7 @@ int device_wakeup_disable(struct device *dev)
>  		return -EINVAL;
>  
>  	ws = device_wakeup_detach(dev);
> -	if (ws)
> -		wakeup_source_unregister(ws);
> +	wakeup_source_unregister(ws);

In the original code, it's clear that the programmer thought about what
happens when the device_wakeup_detach() returns NULL but in the new code
that's not clear.

I guess the information is still there in the git archive, but why hide
the good code by covering it with confusing code?

regards,
dan carpenter

