From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Thu, 9 Sep 2010 09:15:14 +0200
Message-ID: <AANLkTikpwSA411XRTi7Ybj_19URnW0mEMrf6pFYNpxVF__7769.36229453913$1284016577$gmane$org@mail.gmail.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<20100908065333.GG3439@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100908065333.GG3439@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 8, 2010 at 8:53 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
>> Hi,
>>
>> Here is a patch proposal for adding new trace events for power management.
>> Note: thread restarted after the initial discussions on LKML.
>
> Also mind including the ACPI tracepoints we talked about? That way a lot
> more people could test it, etc.
I think the ACPI tracepoints can be added on top of the proposed
patch. Is that ok?

Jean
