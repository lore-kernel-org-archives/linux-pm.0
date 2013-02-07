From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] cpufreq: sleeping function called from invalid context at kernel/workqueue.c:2811
Date: Thu, 7 Feb 2013 16:00:17 +0530
Message-ID: <CAOh2x=kVQ0JOgY7-1UTiz4nwSHkngQ74A0pF8TPDgqaciZnR5g@mail.gmail.com>
References: <20130206202513.GA5626@thinkpad.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130206202513.GA5626@thinkpad.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Artem Savkov <artem.savkov@gmail.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2013 at 1:55 AM, Artem Savkov <artem.savkov@gmail.com> wrote:
> I get the following BUG on suspend using systemd-sleep(this doesn't
> happen with pm-suspend). This seems to be introduced by some of the
> Viresh's patches.

Hi Artem,

I have sent another patchset (and you are in --to), please test your platform
with these and tell us the results.
