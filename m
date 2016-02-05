From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data pointer
Date: Fri, 5 Feb 2016 04:10:10 +0100
Message-ID: <CAJZ5v0i2O7xLpGrRc5+z=v10En43i7jgz3krm49XaOrtuD0MCQ@mail.gmail.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
	<1876466.AY9fn15fDn@vostro.rjw.lan>
	<20160204053614.GV3469@vireshk>
	<CAJZ5v0hfNE9HPkHN4up_gL6HNa-sqW5VzJpO1swPwoNPoycuCQ@mail.gmail.com>
	<20160205030254.GA21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160205030254.GA21792@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 5, 2016 at 4:02 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-02-16, 17:52, Rafael J. Wysocki wrote:
>> On Thu, Feb 4, 2016 at 6:36 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> > Consider a two policy system, who is stopping us from setting ondemand
>> > for one of them and conservative for the other one ? And so, we will
>> > have two gdbs_data ..
>>
>> I don't really regard that as an entirely sane thing to do, but you
>> have a point here.
>
> Why? Its quite useful IMO. For example on TC2, we have two clusters of
> A7 and A15. And we actually can configure A7 for interactive and A15
> for ondemand. And this is very useful for performance/power metrics.

Well, doing insane things may give you better results sometimes.
Depending on what you want to achieve and other factors.

Thanks,
Rafael
