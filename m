From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Thu, 28 Oct 2010 13:31:19 +0200
Message-ID: <201010281331.19503.rjw__10566.3193077364$1288265660$gmane$org@sisk.pl>
References: <1288256579-22957-1-git-send-email-trenn@suse.de>
	<1288256579-22957-3-git-send-email-trenn@suse.de>
	<201010281317.55502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010281317.55502.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: jean.pihet@newoldbits.com, linux-trace-users@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thursday, October 28, 2010, Rafael J. Wysocki wrote:
> On Thursday, October 28, 2010, Thomas Renninger wrote:
> > Recent changes:
> >   - Enable EVENT_POWER_TRACING_DEPRECATED by default
> > 
> > New power trace events:
> > power:cpu_idle
> > power:cpu_frequency
> > power:machine_suspend
> > 
> > 
> > C-state/idle accounting events:
> >   power:power_start
> >   power:power_end
> > are replaced with:
> >   power:cpu_idle
> > 
> > and
> >   power:power_frequency
> > is replaced with:
> >   power:cpu_frequency
> > 
> > power:machine_suspend
> > is newly introduced, a first implementation
> > comes from the ARM side, but it's easy to add these events
> > in X86 as well if needed.
> 
> Can you please check that changelog, please?

Sorry s/check/modify/

In fact, there won't be any ARM implementation, because it's going to be
added at the core level.

> I've asked you for that already once.

Thanks,
Rafael
