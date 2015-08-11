From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/6] PM / OPP: reuse of_parse_phandle()
Date: Tue, 11 Aug 2015 11:40:44 +0530
Message-ID: <20150811061044.GA5147@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <8c4503fe1c1c545d5f7ac68351d81d0238532b54.1439187821.git.viresh.kumar@linaro.org>
 <20150811060229.GG9678@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811060229.GG9678@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 10-08-15, 23:02, Stephen Boyd wrote:
> > -	if (prop->length != sizeof(__be32)) {
> > -		dev_err(dev, "%s: Invalid opp desc phandle\n", __func__);
> > -		return ERR_PTR(-EINVAL);
> > -	}
> 
> But we lost this check? Perhaps we can use
> of_count_phandle_with_args() to make suer we only have one
> phandle?

I thought about it earlier and it looked like we don't need to care
about this. Even if the user passes multiple strings here, its his
problem. We will just pick the first entry and parse it.

And that's true until the point we support multiple table entries,
ofcourse :)

Now that you are still awake, let me update the other patches as well
where u commented :)

-- 
viresh
