From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9] x86 idle cruft removal - v2
Date: Fri, 01 Apr 2011 14:33:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104011313540.2606__34162.5675945126$1301682886$gmane$org@x980>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
	<alpine.LFD.2.02.1104010020280.2797@x980>
	<4D959D25.5010805@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <4D959D25.5010805@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> I guess this would eliminate the problems caused by pm_idle.

Right.

...at least we can contain it inside process.c
where we still need to be able to handle halt/amd-bug/poll.
Probably I'll re-name it to better reflect its function,
say x86_default_idle, in this case.

> In that case I also think we need not implement a default
> driver (like the one I had done https://lkml.org/lkml/2011/3/22/154)
> to handle the case when acpi_idle and intel_idle may not register.

Right.

the stuff in process.c should handle the !cpuidle
and !CPU_IDLE cases, and in the typical case it will
handle idle during boot before cpuidle initializes.

> Additionally, we may not need to support multiple cpuidle driver registration
> as now there would be only acpi_idle and intel_idle
> and mechanism already exists to select between the two.

Right.

I think multiple driver registration is over-kill, though
I have no real opposition to it should a real need for it emerge.
The only need I could come up with is that it would save me
a reboot when I want to compare drivers -- but we should optimize
for real-world-use, not lab use, and simpler is better.

thanks,
Len Brown, Intel Open Source Technology Center
