From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: BUG in bleeding edge c560f3d
Date: Tue, 5 Feb 2013 11:15:19 +0530
Message-ID: <CAKohpo=-A+VTxsrMQk5SthHZLywrO-E3EHQnSs3_jG593cJzUw@mail.gmail.com>
References: <511033EA.7090604@gmail.com>
	<3463348.tWNCISaOfi@vostro.rjw.lan>
	<51104CC7.8030800@gmail.com>
	<2585398.78DPBR35EF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2585398.78DPBR35EF@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5 February 2013 08:13, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, February 04, 2013 04:05:27 PM Dirk Brandewie wrote:

>> Rebased a couple of hours ago testing now.  ATM it looks like it is related to
>> cpufreq_stats handling of the sysfs files
>
> This looks like a problem with commit b8eed8a.  Viresh?

I had some direct chat with Dirk to understand his problem. He has got lots
of minor changes, which by themselves looks incorrect, for ex:
- He is required to cpufreq_frequency_table_put_attr() from his drivers
  init() code to make it NULL... But it should already have been NULL as per
  my understanding. I really want him to test his driver without any additional
  target/set_policy() patches he has.. to see if linux-next works for
him or not.

He will do this testing tomorrow and will let us know of any issues he faces.

We have already tested linux-next and these patches on ARM TC2 and STE
u8500 (by Fabio), with reboots and lots of hotplugging.

Though i am still going to review my own patches once more to see if there is
scope for improvement.

--
viresh
