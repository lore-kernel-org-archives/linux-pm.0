From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Tue, 11 Nov 2014 12:41:18 +0200
Message-ID: <1767434.385ncFoNtj@spock>
References: <4708675.eITUXPv8Ih@spock> <2067094.cJOA1APdny@spock> <CAKohponLC=NqTUG-mENuJ5Tomx6xgCYEBocj2P5RXXZumZaPZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponLC=NqTUG-mENuJ5Tomx6xgCYEBocj2P5RXXZumZaPZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It seems that this bug has nothing to do with acpi-cpufreq code but with 
another ACPI area.

With ACPI enabled kernel may hang in a day or in a week (never survived more 
than approx. 2 weeks). With acpi=off it seems to work OK. For instance, I had 
to boot Ubuntu installer with acpi disabled to finish it successfully.

Usually, hanging is not accompanied by panic log. Only small vertical red 
lines appear on the screen near letters (tried to use plaintext 80x25 console 
without radeon and got the same issue).

Still observing this for 3.16 kernel.

On Wednesday 13 August 2014 10:12:06 Viresh Kumar wrote:
> On 13 August 2014 00:24, Oleksandr Natalenko <oleksandr@natalenko.name> 
wrote:
> > Updated logs.
> 
> Also will it be possible for you to find the last working kernel after
> which this
> happened?
-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
