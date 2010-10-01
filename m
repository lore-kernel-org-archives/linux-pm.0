From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 1 Oct 2010 17:58:25 +0200
Message-ID: <20101001155823.GD5338__20158.6888907061$1285948869$gmane$org@nowhere>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<1285945464-10884-2-git-send-email-trenn@suse.de>
	<4CA60385.6040405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CA60385.6040405@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 01, 2010 at 08:51:33AM -0700, Arjan van de Ven wrote:
>  On 10/1/2010 8:04 AM, Thomas Renninger wrote:
>> New power trace events:
>> power:processor_idle
>> power:processor_frequency
>> power:machine_suspend
>>
>>
>> C-state/idle accounting events:
>>    power:power_start
>>    power:power_end
>> are replaced with:
>>    power:processor_idle
>>
>> and
>>    power:power_frequency
>> is replaced with:
>>    power:processor_frequency
>>
>> power:machine_suspend
>> is newly introduced, a first implementation
>> comes from the ARM side, but it's easy to add these events
>> in X86 as well if needed.
>>
>> the type= field got removed from both, it was never
>> used and the type is differed by the event type itself.
>>
>> perf timechart
>> userspace tool gets adjusted in a separate patch.
>>
>> Signed-off-by: Thomas Renninger<trenn@suse.de>
>> CC: Jean Pihet<jean.pihet@newoldbits.com>
>> CC: Arjan van de Ven<arjan@linux.intel.com>
>
>
> As before, strong NACK from me before, this is an ABI break.


Yeah. I wish we can keep power_start and power_end events,
at least for some time.

I know this is very ugly, but this is the only solution if
we want to conciliate forward progress and backward
compatibility.
