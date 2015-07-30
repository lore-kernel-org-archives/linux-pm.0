From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] bus: subsys: propagate errors from subsys interface's
 ->add_dev()
Date: Thu, 30 Jul 2015 09:14:31 +0530
Message-ID: <20150730034431.GH5100@linux>
References: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org>
 <2867166.mZBGleMS1o@vostro.rjw.lan>
 <20150729223743.GA17250@kroah.com>
 <2113628.vmLC8GdsGl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2113628.vmLC8GdsGl@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pi-cheng.chen@linaro.org
List-Id: linux-pm@vger.kernel.org

On 30-07-15, 01:29, Rafael J. Wysocki wrote:
> > > There is a small problem with it that I've already pointed out to Viresh.
> > > 
> > > Namely, while changing subsys_interface_(un)register() to handle return
> > > values from ->add_dev(), it doesn't do the same thing in bus_probe_device()
> > > which I believe it should for consistency at least.
> > 
> > Oops, sorry, missed that response.  I'll go drop this patch then, thanks
> > for letting me know.

It was discussed in last 2-3 days over a cpufreq related thread, no way you
could have caught that :)

But, I think we should keep this patch until the time we find a better solution
to our problem.

You are the driver core maintainer and probably no one can give a better
suggestion to fix our problem, so lemme explain that again here :)

A platform specific cpufreq driver may depend on a external driver (say i2c
which may control access to regulators) for its working, and until the time
regulator is up along with i2c we need to defer cpufreq driver from being
registered. We already have an EPROBE_DEFER mechanism to handle such situations
nicely.

cpufreq core calling sequence at a glance:
cpufreq_register_driver()
 -> subsys_interface_register()
   -> subsys->add_dev() for all present CPUs one by one
     -> cpufreq_add_dev()
       -> cpufreq_driver->init()

	  Now init() is the only location where the drivers initialize per
	  policy (group of CPUs that share clock/voltage rails) stuff and can
	  check if all the resources like clk/regulator are available or not.
	  And so -EPROBE_DEFER will be returned from here.

The only broken part here is the return value of subsys->add_dev() and that I
tried to fix.

Another important part here is that the cpufreq driver isn't probed against a
cpu device, but a dummy platform device to get the EPROBE_DEFER story right,
plus there are few other issues that it solves, like probing the right cpufreq
driver.

Now, please explain a sane way to get things working for such platforms.

> > > But then, the question is whether or not the probing should fail and
> > > what if device_attach() returns 0 and one of the ->add_dev() callbacks
> > > returns an error.
> > 
> > That's a total mess...

Right and so modifying that to propagate return value wouldn't be that straight
forward.

> > Given that there are almost no uses of this api, I think people should
> > work it out before any more start to pop up :)
> 
> cpufreq is one of the users and that's where the problem is, but in my opinion
> it should be addressed in a different way.
> 
> But while we are at it, should the ->add_dev and ->remove_dev callbacks in
> struct subsys_interface return an int if their return values are always
> ignored?  Maybe it would be better to redefine them to be void to make it clear
> that they can't fail?

For remove_dev(), surely a void return type will make sense. I can put some
effort to get that done. But not sure about add_dev() yet.

-- 
viresh
