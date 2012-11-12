From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH 3/6 v4] cpufreq: tolerate inexact values when collecting
 stats
Date: Mon, 12 Nov 2012 10:35:49 -0600
Message-ID: <50A12565.4070701@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com> <1352313166-28980-4-git-send-email-mark.langsdorf@calxeda.com> <20121111163821.GA21635@x1.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20121111163821.GA21635@x1.osrc.amd.com>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11/11/2012 10:38 AM, Borislav Petkov wrote:
> On Wed, Nov 07, 2012 at 12:32:43PM -0600, Mark Langsdorf wrote:
>> When collecting stats, if a frequency doesn't match the table, go through
>> the table again with both the search frequency and table values shifted
>> left by 10 bits.
> 
> Why would that second pass succeed?

It's effectively a divide by 1024 and minimizes any jitter in the
measured frequency value.

> And why is this in generic code (I'm assuming this is a Calxeda-specific
> case)?

The function is buried pretty deep in the cpufreq_stat code. It didn't
seem appropriate to make it a function pointer as part of struct
cpufreq_driver.

--Mark Langsdorf
Calxeda, Inc.
