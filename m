From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Thu, 19 Dec 2013 14:16:30 +0100
Message-ID: <1482804.eoqBME3Grn@vostro.rjw.lan>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com> <2651749.Dr3egRT25J@vostro.rjw.lan> <CAKohpokxbAkXznyesdUAV7nhcdxMjcc=uOZE=hQhXnnD=bRNTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokxbAkXznyesdUAV7nhcdxMjcc=uOZE=hQhXnnD=bRNTw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Baron <jbaron@akamai.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 19, 2013 10:57:06 AM Viresh Kumar wrote:
> On 19 December 2013 05:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > +       if (cpufreq_driver->setpolicy) {
> > +               unsigned int ret;
> > +
> > +               /* Use the default policyt if it is valid. */
> > +               if (!cpufreq_parse_governor(policy->governor->name, &ret, NULL))
> > +                       new_policy.policy = ret;
> > +       }
> 
> What about this instead as cpufreq_parse_governor isn't supposed to change
> value of ret in case of errors.
> 
> > +       if (cpufreq_driver->setpolicy)
> > +               cpufreq_parse_governor(policy->governor->name, &new_policy.policy, NULL);

Right, this is even better as far as the code goes, but adding a comment
describing the role of it would still be nice.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
