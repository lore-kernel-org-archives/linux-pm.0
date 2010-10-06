From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Wed, 6 Oct 2010 23:47:49 +0200
Message-ID: <201010062347.50722.trenn__33958.1189830371$1286401870$gmane$org@suse.de>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<201010020243.09928.trenn@suse.de>
	<4CA704D2.3040505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA704D2.3040505@linux.intel.com>
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

On Saturday 02 October 2010 12:09:22 pm Arjan van de Ven wrote:
>   On 10/1/2010 5:43 PM, Thomas Renninger wrote:
..
> > I just had a look at the very latest git code of powertop:
> > git://git.moblin.org/powertop
> > File system tracepoints are used, but the affected power events seem
> > *not* to be used yet.
> > Looks like the right time to get this cleaned up.
>
> you're looking at the old powertop.
I googled that latest powertop code moved to above git repo...
Anyway, do you mind giving me a pointer to this code (also see below).

> > If you know of any other code making use of these, please point me to the
> > code, I'd like to analyze
... 

Thanks,

       Thomas
