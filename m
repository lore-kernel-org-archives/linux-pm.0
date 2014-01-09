From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/cpufreq: delete non-required instances of include
 <linux/init.h>
Date: Thu, 9 Jan 2014 10:42:31 -0500
Message-ID: <52CEC367.3030609@windriver.com>
References: <1389280207-11846-1-git-send-email-paul.gortmaker@windriver.com> <CAOh2x=mfQ1qoWBW3=kwML0aLYu60v107svb4knYwTwsSXTzEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=mfQ1qoWBW3=kwML0aLYu60v107svb4knYwTwsSXTzEaQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-01-09 10:17 AM, Viresh Kumar wrote:
> On Thu, Jan 9, 2014 at 8:40 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one driver to the next.
> 
> Are you sure? Its not only about devinit or cpuinit but module_init()
> and others as well. And they are pretty much used by most of them.

Actually, module_init is an interesting point; we are implicitly getting
init.h in module.h -- but (1) that should be explicit, and (2) module_init
should/could really be in module.h and not stuck in init.h

I'll add that to my queue and do some testing.

Thanks for the comments,
Paul.
