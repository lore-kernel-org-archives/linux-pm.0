From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Thu, 8 Mar 2018 17:37:55 +0100
Message-ID: <CAJZ5v0gjB+8rgKNO_3FDnuJZjbjW0mxjptd6h1--McwGjTKj9A@mail.gmail.com>
References: <000a01d3b636$57b75c00$07261400$@net> <000a01d3b6f0$c870d380$59527a80$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000a01d3b6f0$c870d380$59527a80$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 8, 2018 at 4:18 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.07 17:29 Doug wrote:
>> On 2018.03.07 14:12 Rafael J. Wysocki wrote:
>>> On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
>>>> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>>>
>>>> During the test I got some messages (I also got some with the V1 patch set):
>>
>>> Can you please check if that's reporoducible with just the first three
>>> patches in the series applied?
>>
>> I will.
>
> No issues. Test duration: 7 hours and 26 minutes.
> Boot seems normal. Times re-booted 4.

Cool, thanks!

This means that the other patches introduce the problem, most likely.
