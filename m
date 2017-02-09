From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 1/6] PM / QOS: Add default case to the switch
Date: Thu, 9 Feb 2017 15:24:25 +0100
Message-ID: <20170209142425.GC23373@xo-6d-61-c0.localdomain>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60828 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbdBIOY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 09:24:59 -0500
Content-Disposition: inline
In-Reply-To: <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

On Thu 2017-02-09 09:11:47, Viresh Kumar wrote:
> The switch block handles all the QOS request types present today, but
> starts giving compilation warnings as soon as a new type is added and
> not handled in this.
> 
> To prevent against that, add the default case as well and do a WARN from
> it.

I'd say compilation-time warning is better than hmm.... stacktrace and memory leak
at runtime?

> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -621,6 +621,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
>  		req = dev->power.qos->flags_req;
>  		dev->power.qos->flags_req = NULL;
>  		break;
> +	default:
> +		WARN_ON(1);
> +		return;
>  	}
>  	__dev_pm_qos_remove_request(req);
>  	kfree(req);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
