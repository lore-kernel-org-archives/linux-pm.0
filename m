From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/7] PM / Domain: Add support to parse domain's OPP table
Date: Thu, 22 Mar 2018 11:09:53 +0100
Message-ID: <CAPDyKFokfr+RJzL5zNL-mvEwDBF5+ReJRmo98pQV+oGkaDSM8g@mail.gmail.com>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <596dd0d16dcb31fd35d6a38835d1a3d56254b6ce.1513926033.git.viresh.kumar@linaro.org>
 <CAPDyKFontDwvpS97xBskNE-FLMo3HPDLthCEkviZv8rKdA8t=g@mail.gmail.com> <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322100024.xy2ipqzgluj6fhs4@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 March 2018 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-03-18, 10:31, Ulf Hansson wrote:
>> Nitpick, perhaps change this to:
>>
>> if (gpd->set_performance_state)
>>        dev_pm_opp_of_remove_table(&gpd->dev);
>
> I probably did that to save the 80 column thing. So crossing 80 columns in this
> case is fine ?

If that is needed, then okay!

Kind regards
Uffe
