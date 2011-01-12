From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/9] cpuidle: Introduce .abbr (abbrevation)
 for cpuidle states
Date: Wed, 12 Jan 2011 01:56:45 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120150570.19140__2258.05590530417$1294815458$gmane$org@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-5-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294396190-23031-5-git-send-email-trenn@suse.de>
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

I'm not fond of inventing a new 3-character abbreviation field
for every state because display tools can't handle the existing
16-character name field.

If the display tools can only handle 3 characters,
then why not have them simply use the 1st 3 characters
of the existing name field?  If that is not unique,
then re-arrange the strings so that it is unique...

Of course the ACPI part of this patch will not apply,
as it depends on patch 1 in this series, which was erroneous.
For ACPI, the existing name field is already fine,
as C%d fits into 3 characters.

thanks,
Len Brown, Intel Open Source Technology Center
