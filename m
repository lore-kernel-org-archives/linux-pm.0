From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date: Sat, 8 Dec 2018 08:24:20 -0800
Message-ID: <000d01d48f12$7e2e16c0$7a8a4440$@net>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>         T62Cgz3BqpqCWT62HgcJvj <001a01d48b24$9aa38c00$cfeaa400$@net> VZhHgXUsnXrKKVZhNgPvLt
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: VZhHgXUsnXrKKVZhNgPvLt
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.12.08 02:23 Giovanni Gherdovich wrote:

> sorry for the late reply, this week I was traveling.

No Problem. Thanks very much for your very detailed reply,
which obviously took considerable time to write. While
I was making progress, your instructions really fill in
some gaps and mistakes I was making.

Eventually (probably several days) I'll report back my test
results.


> Some specific remarks you raise:
>
> On Mon, 2018-12-03 at 08:23 -0800, Doug Smythies wrote:
>> ...
>> My issue is that I do not understand the output or how it
>> might correlate with your tables.
>> 
>> I get, for example:
>> 
>>    3    1   1     0.13s     0.68s     0.80s  1003894.302 1003779.613
>>    3    1   1     0.16s     0.64s     0.80s  1008900.053 1008215.336
>>    3    1   1     0.14s     0.66s     0.80s  1009630.439 1008990.265
>> ...
>> 
>> But I don't know what that means, nor have I been able to find
>> a description anywhere.
>
> I don't recognize this output. I hope the illustration above can clarify how
> MMTests is used.

Due to incompetence on my part, the config file being run for my tests was
always just the default config file from my original
git clone https://github.com/gormanm/mmtests.git
command. So regardless of what I thought I was doing, I was running "pft"
(Page Fault Test).

... Doug
