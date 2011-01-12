From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] X86: Cleanup idle= internal variables by
 getting rid of idle_halt idle_nomwait
Date: Wed, 12 Jan 2011 01:22:01 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120120370.19140__24661.7750301541$1294813388$gmane$org@x980>
References: <201011021441.09258.trenn@suse.de>
	<alpine.LFD.2.00.1011030150560.3378@localhost.localdomain>
	<201011031706.15248.trenn@suse.de> <201011051124.49973.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201011051124.49973.trenn@suse.de>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, stable@kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> > > That function and all these idle workaround flags
> > > need to be re-whacked.

> > Whatabout this (compile tested (on x86_64/ia64)).
> > Adding lkml as this affects x86 core code.
> as this mostly affects intel_idle and acpi processor driver,
> can you apply this one to your acpi test branch if you are
> ok with it.

Looks good to me, Thomas, thanks for the follow-up.

I don't think it needed for -stable, but it is a good cleanup
for upstream.

applied to idle-test.

thanks,
Len Brown, Intel Open Source Technology Center
