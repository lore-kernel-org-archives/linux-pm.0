From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 linux-next 2/2] cpufreq: Convert the cpufreq_driver_lock to use the rcu
Date: Wed, 06 Feb 2013 14:00:30 +0100
Message-ID: <4413377.ZEeF7Y7rnE@vostro.rjw.lan>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com> <CAKohpo=3qnhtVOniYWPJQLSkAnhMkYj8_yvHR+QE46Pzdi=WhA@mail.gmail.com> <CAKohpo=JQX4N4UoR_APD9J-JXJY0uv2kJwqiL4uNmpqmCUscTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=JQX4N4UoR_APD9J-JXJY0uv2kJwqiL4uNmpqmCUscTA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 06, 2013 02:21:11 PM Viresh Kumar wrote:
> On 6 February 2013 08:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 6 February 2013 07:34, Nathan Zimmer <nzimmer@sgi.com> wrote:
> >> In general rwlocks are discourged so we are moving it to use the rcu instead.
> >>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> >> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 173 +++++++++++++++++++++++++---------------------
> >>  1 file changed, 96 insertions(+), 77 deletions(-)
> >
> > bleeding-edge got updated again and this patch would have conflicts :)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Rafael,
> 
> I have applied them over bleeding-edge after resolving few conflicts.
> Please pick them up from:
> 
> Branch: for-rafael
> Repo: git://git.linaro.org/people/vireshk/linux.git
> http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-rafael

That's really helpful, thanks a lot!

Both applied to bleeding-edge.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
