From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT] [PATCH v3 0/4] Intel_pstate: HWP Dynamic performance boost
Date: Tue, 5 Jun 2018 11:33:26 +0200
Message-ID: <CAJZ5v0hiY41e3-CMxmsRA1z02vY7gYpEmDE8KMB-imA-X2Bu7Q@mail.gmail.com>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com>
 <20180604180156.4uvb6t4xqxmuwayq@linux-h043> <1528136669.83760.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528136669.83760.11.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@techsingularity.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 4, 2018 at 8:24 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Mon, 2018-06-04 at 20:01 +0200, Giovanni Gherdovich wrote:
>> On Thu, May 31, 2018 at 03:51:39PM -0700, Srinivas Pandruvada wrote:
>> > v3
>> > - Removed atomic bit operation as suggested.
>> > - Added description of contention with user space.
>> > - Removed hwp cache, boost utililty function patch and merged with
>> > util callback
>> >   patch. This way any value set is used somewhere.
>> >
>> > Waiting for test results from Mel Gorman, who is the original
>> > reporter.
>> > [SNIP]
>>
>> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>
>> This series has an overall positive performance impact on IO both on
>> xfs and
>> ext4, and I'd be vary happy if it lands in v4.18. You dropped the
>> migration
>> optimization from v1 to v2 after the reviewers' suggestion; I'm
>> looking
>> forward to test that part too, so please add me to CC when you'll
>> resend it.
> Thanks Giovanni. Since 4.17 is already released and 4.18 pulls already
> started, we have to wait for 4.19.

Not necessarily. :-)

It has been in the works for quite a while and we have another week of
the merge window ahead of us.

Please resubmit the series with the minor issues in the first patch
addressed and with the RFC/RFT tag removed.

Cheers,
Rafael
