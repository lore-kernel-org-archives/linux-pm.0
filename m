From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Mon, 20 Mar 2017 13:30 +0100
Message-ID: <3593437.Z2HPvjKf4F@aspire.rjw.lan>
References: <2084010.4xkKok06Gp@aspire.rjw.lan> <CAJZ5v0h1C6o72boe_DJRS_U3xebaU6h=kzL8biNjGUoA1S8B8w@mail.gmail.com> <20170320032156.GG31040@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320032156.GG31040@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, March 20, 2017 08:51:56 AM Viresh Kumar wrote:
> On 17-03-17, 18:40, Rafael J. Wysocki wrote:
> > On Fri, Mar 17, 2017 at 5:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 17 March 2017 at 22:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > >> IMO if we are not going to restore the governor, we also should not
> > >> restore the limits as those things are related.  Now, the governor can
> > >> be unloaded while the CPU is offline.
> > >
> > > I thought about it earlier but then governor and policy min/max
> > > looked independent to me. Why do you think they are related?
> > 
> > They are parts of one set of settings.
> > 
> > If the governor is not restored, the policy starts with the default
> > one, so why would it not start with the default limits then?
> 
> Do we reset the limits when we change governor's normally? No. Then
> why should we consider suspend/resume special in that sense? These are
> completely different and independent settings which user has done and
> we don't really need to relate them.
> 
> > My opinion is that either we restore everything the way it was, or we
> > start afresh entirely.
> 
> What about fields like: policy->user_policy.*? They aren't reset for
> existing policies if the last governor isn't found. And there are
> drivers which call cpufreq_update_policy(), and that would mean that
> the CPU will come back to user defined policies before system
> suspended. And that kind of defeats whatever you were trying to do in
> this patch. Isn't it?

OK, it looks like I don't care as much as you do. :-)

Send the patch with a changelog.

Thanks,
Rafael
