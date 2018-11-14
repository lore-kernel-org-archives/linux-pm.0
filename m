From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date: Tue, 13 Nov 2018 22:26:22 -0800
Message-ID: <004901d47be2$fa1d0c20$ee572460$@net>
References: <000001d476bb$ec964520$c5c2cf60$@net> KfE8gqrRG7nW7KfEDgBkXZ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: KfE8gqrRG7nW7KfEDgBkXZ
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.11.08 00:00 Rafael J. Wysocki wrote:
> On Wednesday, November 7, 2018 6:04:12 PM CET Doug Smythies wrote:
>> On 2018.11.04 08:31 Rafael J. Wysocki wrote:

...[snip]...
>> The results are:
>> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
>> http://fast.smythies.com/linux-pm/k420/histo_compare.htm

...[snip]...

>> There are some odd long idle durations with TEOv3 for idle
>> states 1, 2, and 3 that I'll watch for with v4 testing.
>
> That unfortunately is a result of bugs in the v4 (and v2 - v3 too).
>
> Namely, it doesn't take the cases when the tick has been stopped already
> into account correctly.  IOW, all of the data points beyond the tick boundary
> should go into the "final" peak.
>
> I'll send a v5.

With v5 there were no long idle durations for idle states 1, 2, and 3 for
this same Phoronix dbench test.

... Doug
