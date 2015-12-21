From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: blackfin-cpufreq: How to mark cpu_set_cclk() as static?
Date: Mon, 21 Dec 2015 15:23:08 +0530
Message-ID: <20151221095308.GE5532@ubuntu>
References: <5674598B.6020000@users.sourceforge.net>
 <20151219015926.GJ3946@ubuntu>
 <5675141F.2090803@users.sourceforge.net>
 <20151221031757.GA5532@ubuntu>
 <5677C452.8040307@users.sourceforge.net>
 <20151221092805.GD5532@ubuntu>
 <5677CB72.8090504@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5677CB72.8090504@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On 21-12-15, 10:50, SF Markus Elfring wrote:
> In which order would you prefer that the properties of the
> function "cpu_set_cclk" will be improved?
> * Should the linkage specifier be added on a separate source code line?

No, it can be there in the same line.

> * Can this fix be combined with my previous update suggestion for
>   the return type?

I think the first patch is already Acked now and can be applied as it
is. Just send the next patch based on the previous one.

-- 
viresh
