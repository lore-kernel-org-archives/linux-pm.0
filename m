From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: od_set_powersave_bias: NULL pointer dereference
Date: Wed, 26 Jun 2013 20:02:29 +0530
Message-ID: <CAKohpom_jHQeR2FKFS3-RkxpPrJvekw8pDb-qnApnzu-VqreBQ@mail.gmail.com>
References: <51C87ADC.4070409@canonical.com>
	<CAKohponCrC93D88Fgg_3LKsLG0KMeCVKsTEoy-N3jsdUQdgWvA@mail.gmail.com>
	<20130625161935.GA10208@jshin-Toonie>
	<CAKohpomSa0FRviZHkkJOeUUxubbzueVb3yyP5G8ASwpRB6wANQ@mail.gmail.com>
	<20130626142852.GA2326@jshin-Toonie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130626142852.GA2326@jshin-Toonie>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: Tim Gardner <tim.gardner@canonical.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26 June 2013 19:58, Jacob Shin <jacob.shin@amd.com> wrote:
> On Wed, Jun 26, 2013 at 12:18:27PM +0530, Viresh Kumar wrote:

>> I am not sure if this is enough. What if we had ondemand as the
>> governor initially, then we changed it to something else. Now also
>> cur_policy contains a address and isn't zero.
>
> Right, so we check below ..
>
>>
>> >                 cpumask_or(&done, &done, policy->cpus);
>> > +
>> > +               if (policy->governor != &cpufreq_gov_ondemand)
>> > +                       continue;
>
> This should catch that case no ?

Policy might be freed and reallocated by then. And so doing
policy->governor is dangerous.
