From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Tue, 14 Apr 2015 19:07:46 +0300
Message-ID: <1465982.AWUTj1UaDo@spock>
References: <4708675.eITUXPv8Ih@spock> <1767434.385ncFoNtj@spock> <9508464.Rg48i9FdUc@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <9508464.Rg48i9FdUc@spock>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Cross-posting from kernel bugzilla:

===
Definitely not a kernel bug.

I've replaced RAM module with another one and the issue went away.

No idea why oopses refered to ACPI, but they seem to be the result of simple 
hardware incompatibility.
===

On Tuesday 18 November 2014 21:07:51 Oleksandr Natalenko wrote:
> Hmmm, weird, acpi=off as well as disabling ASPM and NMI watchdog didn't help
> : (.
> 
> Now trying to update BIOS.
> 
> P.S. Still affected while using 3.17.2 kernel.
> 
> On Tuesday 11 November 2014 12:41:18 Oleksandr Natalenko wrote:
> > It seems that this bug has nothing to do with acpi-cpufreq code but with
> > another ACPI area.
> > 
> > With ACPI enabled kernel may hang in a day or in a week (never survived
> > more than approx. 2 weeks). With acpi=off it seems to work OK. For
> > instance, I had to boot Ubuntu installer with acpi disabled to finish it
> > successfully.
> > 
> > Usually, hanging is not accompanied by panic log. Only small vertical red
> > lines appear on the screen near letters (tried to use plaintext 80x25
> > console without radeon and got the same issue).
> > 
> > Still observing this for 3.16 kernel.
> > 
> > On Wednesday 13 August 2014 10:12:06 Viresh Kumar wrote:
> > > On 13 August 2014 00:24, Oleksandr Natalenko <oleksandr@natalenko.name>
> > 
> > wrote:
> > > > Updated logs.
> > > 
> > > Also will it be possible for you to find the last working kernel after
> > > which this
> > > happened?
-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
