From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate immediately
Date: Wed, 28 Oct 2015 17:13:19 +0100
Message-ID: <3949153.K5IjKZhpbI@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <3215277.8YKq8PWCpx@vostro.rjw.lan> <20151028152811.GE3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028152811.GE3716@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 28, 2015 08:58:11 PM Viresh Kumar wrote:
> On 28-10-15, 16:31, Rafael J. Wysocki wrote:
> > Is the current code really problematic?
> 
> Its not problematic, but just that I didn't like special code written
> here.
> 
> Also, its a blocker for the next patch which tries to schedule work on
> all the policy->cpus together.

Well, the second statement above sort of contradicts the first one. :-)

I guess the answer is "it is problematic, because I can't do the other
optimization then".

To that I'd really suggest trying to rework the code to use timer
functions directly in the first place.

Thanks,
Rafael
