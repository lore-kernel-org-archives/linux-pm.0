From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 55411] sysfs per-cpu cpufreq subdirs/symlinks screwed up after s2ram
Date: Fri, 22 Mar 2013 15:03:44 +0100
Message-ID: <2638366.c1da3MGMT5@vostro.rjw.lan>
References: <bug-55411-12968@https.bugzilla.kernel.org/> <20130322134334.BFF2711FB81@bugzilla.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130322134334.BFF2711FB81@bugzilla.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, March 22, 2013 01:43:34 PM bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=55411
> 
> --- Comment #19 from Viresh Kumar <viresh.kumar@linaro.org>  2013-03-22 13:43:34 ---
> Hi guys,
> 
> I will answer to questions of both of you in this mail.
> 
> On 22 March 2013 18:23, Thomas Renninger <trenn@suse.de> wrote:
> > Is this all to try to fix "cpufreq driver gets loaded while some cores
> > were set offline before"?
> 
> Not really. There are problems with acpi-cpufreq without that case too.
> 
> > I wonder how you run into "cpufreq is initialized with offlined cpus" case.
> > I remember that there were problems, but it's nearly impossible to run
> > into this if the cpufreq driver is loaded early at boot.
> 
> I always thought there is a way not to boot all cpus by passing stuff in
> command line and so this is a easy case to reproduce.
> 
> > cpufreq_add_dev() and friends are complicated.
> 
> Not anymore, they are hugely simplified now.
> 
> > Those init functions got split some time ago and there also slipped
> > in a bug even it was simple splitting of functions.
> >
> > I do not have time to look at fcf8058296edbc3de43adf095824fc32b067b9f8
> > right now. Don't know how much other stuff depends on it and how
> > sever it is on ARM that cpufreq does not correctly initialize with offlined
> > cpus..., I would revert this patch.
> 
> Let me clear it to everybody. There isn't/shouldn't be a bug in cpufreq core,
> its just that acpi-cpufreq driver isn't adapted well with the changes related
> to affected_cpus and related_cpus.

Which doesn't matter a whit.  It worked before your changes and it has to work
after them.

> I have never gone into coding for any non-ARM platform and am really not
> aware of acpi-cpufreq driver and its users. That's why i told everybody where
> the issue is, and they just need to fix acpi-cpufreq driver with right values
> of policy->cpus (affected_cpus) and everything else would work after that.

Which wasn't the right thing to do.

If your changes break something, *you* (and nobody else) are responsible for
fixing that.

Asking for help is obviously fine, but even if no one can (or has the time to)
help at the moment, you are still responsible for fixing the breakage.  If you
aren't familiar with the code in question, it's the time for a crash course.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
