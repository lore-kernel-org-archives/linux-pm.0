From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Mon, 26 Sep 2016 23:06:45 +0200
Message-ID: <2477506.olat0BX4ex@vostro.rjw.lan>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net> <3919370.SGLjGupePs@vostro.rjw.lan> <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, September 26, 2016 11:15:45 AM Larry Finger wrote:
> On 09/26/2016 06:37 AM, Rafael J. Wysocki wrote:
> > On Friday, September 23, 2016 09:45:09 PM Larry Finger wrote:
> >> On 09/18/2016 09:54 PM, Larry Finger wrote:
> >>> On 09/14/2016 11:00 AM, Larry Finger wrote:
> >>>> On 09/09/2016 12:39 PM, Larry Finger wrote:
> >>>>> I have found a regression in kernel 4.8-rc2 that causes the speed of my laptop
> >>>>> with an Intel(R) Core(TM) i7-4600M CPU @ 2.90GHz to suddenly have a maximum cpu
> >>>>> frequency of ~400 MHz. Unfortunately, I do not know how to trigger this problem,
> >>>>> thus a bisection is not possible. It usually happens under heavy load, such as a
> >>>>> kernel build or the RPM build of VirtualBox, but it does not always fail with
> >>>>> these loads. In my most recent failure, 'hwinfo --cpu' reports cpu MHz of
> >>>>> 396.130 for #3. The bogomips value is 5787.73, and the cpu clock before the
> >>>>> fault is 3437 MHz. Nothing is logged when this happens.
> >>>>>
> >>>>> If I were to get a patch that would show a backtrace when the maximum CPU
> >>>>> frequency is changed, perhaps it would be possible to track this bug.
> >>>>
> >>>> I have not yet found the bad commit, but I have reduced the range of commits a
> >>>> bit. This bug has been difficult to trigger. So far, it has not taken over 1/2
> >>>> day to appear in bad kernels, thus I am allowing three days before deciding that
> >>>> a given trial is good. I never saw the problem with 4.7 kernels, but I did in
> >>>> 4.8-rc1. I also know that it appeared before commit 581e0cd. Commit 1b05cf6 did
> >>>> not show the bug.
> >>>>
> >>>> Testing continues.
> >>>
> >>> And still does. My bisection seemed to be trending toward an improbable set of
> >>> commits, and I needed to do some other work with the machine, thus I started
> >>> running 4.8-rc6. It failed nearly 48 hours after the reboot, which indicated
> >>> that using 3 days to indicate a "good" trial was likely too short. I am
> >>> currently testing the first of the trial and will run it for at least a week. It
> >>> is unlikely that these tests will be complete before 4,8 is released, even if
> >>> -rc8 is needed. I will keep attempting to find the faulty commit.
> >>
> >> My debugging continues. After 7 days of beating on commit f7816ad, I have
> >> concluded that it is likely good. Thus I think the bug lies between commit
> >> 581e0cd (bad) and f7816ad (good). I will need to do a long test on commit
> >> 1b05cf6, which did not fail with a shorter run.
> >
> > 581e0cd is not a valid mainline commit hash AFAICS.
> 
> That was a typo. The correct value is 581e0c7.
> >
> > What cpufreq driver do you use?
> 
> My "Default CPUFreq governor" is on demand.
> 
> Running the command 'egrep -r "CPU_FREQ|CPUFREQ" .config' results in
> 
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> # CONFIG_CPU_FREQ_STAT is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> CONFIG_CPU_FREQ_GOV_USERSPACE=m
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
> CONFIG_X86_PCC_CPUFREQ=m
> CONFIG_X86_ACPI_CPUFREQ=m
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> 
> Commit 1b05cf6 did fail on longer testing, thus my bisection had ended up going 
> wrong. Further tests have shown that commit 351a4ded is bad. Once again, by 
> bisection seems to be converging to a set of commits that seem unlikely to cause 
> this problem. Perhaps commit f7816ad is not really good even though it survived 
> 7 days of heavy CPU usage.
> 
> I have been reluctant to post my entire .config on the list. It is available at 
> http://pastebin.com/aMZaAKwL.

If the governor is ondemand, the driver is acpi-cpufreq, most likely.

How do you measure the frequency?

Thanks,
Rafael
