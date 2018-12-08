From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date: Sat, 8 Dec 2018 08:36:07 -0800
Message-ID: <000e01d48f14$21ca7020$655f5060$@net>
References: <006901d48cef$5bb88a00$13299e00$@net> UpeTgvCH1QLjuUpeUg0j37
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: UpeTgvCH1QLjuUpeUg0j37
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, "'open list:DOCUMENTATION'" <linux-doc@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.12.06 01:09 Rafael J. Wysocki wrote:
> On Thu, Dec 6, 2018 at 12:08 AM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.12.03 04:32 Rafael J. Wysocki wrote:
>>
>>> Add two new metrics for CPU idle states, "high" and "low", to count
>>> the number of times the given state had been asked for (or entered
>>> from the kernel's perspective), but the observed idle duration turned
>>> out to be too high or too low for it (respectively).
>>
>> I wonder about the "high" "low" terminology here.
>
> I took these names, because they are concise and simple.  I could use
> "below" and "above" respectively I guess.  What about these?

I see you already sent a new patch with these names. Yes, myself I like
them better.

I am going to try to add these counts to my next sets of graphs.

... Doug
