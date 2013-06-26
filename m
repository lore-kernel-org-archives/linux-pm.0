From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: od_set_powersave_bias: NULL pointer dereference
Date: Wed, 26 Jun 2013 09:35:55 -0500
Message-ID: <20130626143555.GA2989@jshin-Toonie>
References: <51C87ADC.4070409@canonical.com>
 <CAKohponCrC93D88Fgg_3LKsLG0KMeCVKsTEoy-N3jsdUQdgWvA@mail.gmail.com>
 <20130625161935.GA10208@jshin-Toonie>
 <CAKohpomSa0FRviZHkkJOeUUxubbzueVb3yyP5G8ASwpRB6wANQ@mail.gmail.com>
 <20130626142852.GA2326@jshin-Toonie>
 <CAKohpom_jHQeR2FKFS3-RkxpPrJvekw8pDb-qnApnzu-VqreBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpom_jHQeR2FKFS3-RkxpPrJvekw8pDb-qnApnzu-VqreBQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tim Gardner <tim.gardner@canonical.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 26, 2013 at 08:02:29PM +0530, Viresh Kumar wrote:
> On 26 June 2013 19:58, Jacob Shin <jacob.shin@amd.com> wrote:
> > On Wed, Jun 26, 2013 at 12:18:27PM +0530, Viresh Kumar wrote:
> 
> >> I am not sure if this is enough. What if we had ondemand as the
> >> governor initially, then we changed it to something else. Now also
> >> cur_policy contains a address and isn't zero.
> >
> > Right, so we check below ..
> >
> >>
> >> >                 cpumask_or(&done, &done, policy->cpus);
> >> > +
> >> > +               if (policy->governor != &cpufreq_gov_ondemand)
> >> > +                       continue;
> >
> > This should catch that case no ?
> 
> Policy might be freed and reallocated by then. And so doing
> policy->governor is dangerous.

Hm . any hints on how to check for if ondemand is running on this CPU
or not ? I'm not sure what the best way to handle this is ..

Thanks,

