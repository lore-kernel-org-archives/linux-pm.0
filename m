From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/9] X86/perf: fix power:cpu_idle double end
 events and throw cpu_idle events from the cpuidle layer
Date: Wed, 12 Jan 2011 18:12:15 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101121806570.19754__37595.8443306901$1294874044$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-4-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120141330.19140@x980>
	<201101121616.54613.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201101121616.54613.trenn@suse.de>
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Robert Schoene <robert.schoene@tu-dresden.de>, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

Applied to idle-test

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-test

Thomas,
Please test this branch, and base your incremental patches on it.

thanks,
Len Brown, Intel Open Source Technology Center
