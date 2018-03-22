From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/7] PM / Domain: Add support to parse domain's OPP table
Date: Thu, 22 Mar 2018 18:00:24 +0800
Message-ID: <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
 <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22-03-18, 10:31, Ulf Hansson wrote:
> Nitpick, perhaps change this to:
> 
> if (gpd->set_performance_state)
>        dev_pm_opp_of_remove_table(&gpd->dev);

I probably did that to save the 80 column thing. So crossing 80 columns in this
case is fine ?

-- 
viresh
