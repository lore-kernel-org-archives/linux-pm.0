From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 4/4] PERF: fix power:cpu_idle double end
	events
Date: Mon, 01 Nov 2010 09:11:28 +0100
Message-ID: <1288599088.2712.47.camel__40571.3583961644$1288627560$gmane$org@localhost>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
	<1288136605-10526-5-git-send-email-trenn@suse.de>
	<201010271742.04545.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010271742.04545.trenn@suse.de>
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
Cc: jean.pihet@newoldbits.com, linux-trace-users@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, den 27.10.2010, 17:42 +0200 schrieb Thomas Renninger:

> Robert: I expect you tested this on a machine with no cpuidle
> driver registered?

You're right, there was no idle driver, but the idle process from
process_64.c which called the idle routine.
I reported my thoughts on this on 14th of May this year 2010, mostly
claiming for a standard on where to report these events.

You're also missing the other idle routines from x86/kernel/process.c
mwait_idle_with_hints and mwait_idle only throw start events, so they
should behave like default_idle. poll_idle on the other hand reports the
end event itself.

Robert
