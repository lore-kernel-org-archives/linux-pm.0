From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Sat, 2 Oct 2010 02:43:08 +0200
Message-ID: <201010020243.09928.trenn__39146.7919842855$1285980250$gmane$org@suse.de>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<1285969466.6750.18.camel@gandalf.stny.rr.com>
	<4CA656F7.70703@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA656F7.70703@linux.intel.com>
Content-Disposition: inline
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

On Friday 01 October 2010 11:47:35 pm Arjan van de Ven wrote:
>   On 10/1/2010 2:44 PM, Steven Rostedt wrote:
...
> these tracepoints are used to get information for tools that do power
> analysis (like powertop).
I just had a look at the very latest git code of powertop:
git://git.moblin.org/powertop
File system tracepoints are used, but the affected power events seem *not* to 
be used yet.
Looks like the right time to get this cleaned up.

If you know of any other code making use of these, please point me to the
code, I'd like to analyze whether this would be as easy to adjust as the
perf timechart code was.

Thanks,

        Thomas
