From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Bug 55411] sysfs per-cpu cpufreq subdirs/symlinks screwed up
 after s2ram
Date: Fri, 22 Mar 2013 19:36:25 +0530
Message-ID: <CAKohpom_Nbk=eqXw5+x7cgmvRVcXYFP0mNFDsdxxq7k931XLaQ@mail.gmail.com>
References: <bug-55411-12968@https.bugzilla.kernel.org/>
	<20130322134334.BFF2711FB81@bugzilla.kernel.org>
	<2638366.c1da3MGMT5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2638366.c1da3MGMT5@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: bugzilla-daemon@bugzilla.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 March 2013 19:33, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, March 22, 2013 01:43:34 PM bugzilla-daemon@bugzilla.kernel.org wrote:
>> I have never gone into coding for any non-ARM platform and am really not
>> aware of acpi-cpufreq driver and its users. That's why i told everybody where
>> the issue is, and they just need to fix acpi-cpufreq driver with right values
>> of policy->cpus (affected_cpus) and everything else would work after that.
>
> Which wasn't the right thing to do.
>
> If your changes break something, *you* (and nobody else) are responsible for
> fixing that.

Yes, i already replied in another mail on what actually happened.

> Asking for help is obviously fine, but even if no one can (or has the time to)
> help at the moment, you are still responsible for fixing the breakage.  If you
> aren't familiar with the code in question, it's the time for a crash course.

yes, i need to do that now.
