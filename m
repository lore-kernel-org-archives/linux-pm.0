From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 01 Oct 2010 14:47:35 -0700
Message-ID: <4CA656F7.70703__32944.9050747373$1285969710$gmane$org@linux.intel.com>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>	
	<1285945464-10884-2-git-send-email-trenn@suse.de>	
	<4CA60385.6040405@linux.intel.com>
	<1285969466.6750.18.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285969466.6750.18.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

  On 10/1/2010 2:44 PM, Steven Rostedt wrote:
>
> What ABI is broken? Trace points have not been declared an ABI. They
> expose too much of the internals of the system to be considered one. Any
> tool that can not cope with a tracepoint change is fundamentally broken.

what you are saying that any tool using tracepoints is fundamentally 
broken...

these tracepoints are used to get information for tools that do power 
analysis (like powertop).
while the absence of these named tracepoints does not cause a crash; 
these tools have no longer
any useful function left at that point.
