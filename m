From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sysfs: return -EINVAL for bogus strings
Date: Wed, 12 Jul 2017 23:35:59 +0200
Message-ID: <2623737.CVamlDn37b@aspire.rjw.lan>
References: <20170710072140.chms22ep35myvvbd@mwanda> <20170710072935.GA12630@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50509 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753410AbdGLVnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 17:43:42 -0400
In-Reply-To: <20170710072935.GA12630@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

On Monday, July 10, 2017 09:29:35 AM Pavel Machek wrote:
> On Mon 2017-07-10 10:21:40, Dan Carpenter wrote:
> > In the current code, if the user accidentally writes a bogus command to
> > this sysfs file, then we set the latency tolerance to an uninitialized
> > variable.
> > 
> > Fixes: 2d984ad132a8 ("PM / QoS: Introcuce latency tolerance device PM QoS type")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> I'd suggest this is a stable candidate. It only leaks 32 bits to
> userspace, but still...
> 
> > @@ -272,6 +272,8 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
> >  			value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
> >  		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
> >  			value = PM_QOS_LATENCY_ANY;
> > +		else
> > +			return -EINVAL;
> >  	}
> >  	ret = dev_pm_qos_update_user_latency_tolerance(dev, value);
> >  	return ret < 0 ? ret : n;
> 
> 

Applied, thanks!
