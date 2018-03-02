From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and cpu_frequency
Date: Fri, 2 Mar 2018 10:24:45 +0100
Message-ID: <CAJZ5v0j8GsaK7kJ4hyvyQYOpa6QmoP2Pc69egg0hb=tb2EwpuA@mail.gmail.com>
References: <1519809638-24248-1-git-send-email-changbin.du@intel.com>
 <CAJZ5v0jqG0pcqOuvAVoP7sNKoOe+3ByMk4X5AZASp84OPcrgPg@mail.gmail.com> <20180301022719.xyfcu5tpmadjxbut@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301022719.xyfcu5tpmadjxbut@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Fix up LKML address.]

On Thu, Mar 1, 2018 at 3:27 AM, Du, Changbin <changbin.du@intel.com> wrote:
> Hi,
> On Wed, Feb 28, 2018 at 11:27:09AM +0100, Rafael J. Wysocki wrote:
>> On Wed, Feb 28, 2018 at 10:20 AM,  <changbin.du@intel.com> wrote:
>> > From: Changbin Du <changbin.du@intel.com>
>> >
>> > The type of state is signed int, convert it to unsigned int looks weird.
>> > (-1 become 4294967295)
>> >    932.123 power:cpu_idle:state=1 cpu_id=0)
>> >    932.125 power:cpu_idle:state=4294967295 cpu_id=0)
>> >    932.132 power:cpu_idle:state=1 cpu_id=0)
>> >    932.133 power:cpu_idle:state=4294967295 cpu_id=0)
>> >
>> > Similarly for cpu_frequency as "state=%lu cpu_id=%lu". User need to read
>> > the code to understand what 'state' means.
>> >
>> > No functional change in this patch.
>>
>> That rather isn't the case if negative values are ever passed to the
>> tracepoint, right?
>>
> yes.
>> Which seems to be the reason why you want to make this change, isn't it?
>>
> yes, to improve readability.
>
>> So maybe fix the code using the tracepoint(s) to avoid passing
>> negative values to it(them)?
> For cpu_idle event, [0, CPUIDLE_STATE_MAX) are used to index the idle state arrary,
> so I think a appropriate value for PWR_EVENT_EXIT is -1 (defined in include/trace/events/power.h).
> Or do you have a better idea? Thanks!

Sorry, I'm not sure what you mean.

I'm saying that the code using the CPU PM tracepoints is not expected
to pass -1 as the CPU number to them.  IOW, neither -1 nor its UL
representation should ever appear in the output of these tracepoints.
If that happens, it is a problem with the code using the tracepoints
which needs to be fixed.  Users should not see any of these values.
