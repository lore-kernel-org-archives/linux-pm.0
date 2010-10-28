From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Thu, 28 Oct 2010 13:17:55 +0200
Message-ID: <201010281317.55502.rjw__23202.4682256908$1288264825$gmane$org@sisk.pl>
References: <1288256579-22957-1-git-send-email-trenn@suse.de>
	<1288256579-22957-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288256579-22957-3-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: jean.pihet@newoldbits.com, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thursday, October 28, 2010, Thomas Renninger wrote:
> Recent changes:
>   - Enable EVENT_POWER_TRACING_DEPRECATED by default
> 
> New power trace events:
> power:cpu_idle
> power:cpu_frequency
> power:machine_suspend
> 
> 
> C-state/idle accounting events:
>   power:power_start
>   power:power_end
> are replaced with:
>   power:cpu_idle
> 
> and
>   power:power_frequency
> is replaced with:
>   power:cpu_frequency
> 
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.

Can you please check that changelog, please?

I've asked you for that already once.

Thanks,
Rafael
