From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] drivers/cpufreq: Warn user when powernow-k8 tries to
 fall back to acpi-cpufreq and it is unavailable.
Date: Thu, 17 Jan 2013 12:54:37 +0100
Message-ID: <20130117115436.GA3853@pd.tnic>
References: <1357780161-30581-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <20130111144940.GB21882@liondog.tnic>
 <20130111165054.GD10751@liondog.tnic>
 <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36457 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab3AQLyj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Jan 2013 06:54:39 -0500
Content-Disposition: inline
In-Reply-To: <4923C2DE085EEB4FAB1D375DD09D0BA6100CF170@sausexdag04.amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gopalakrishnan, Aravind" <Aravind.Gopalakrishnan@amd.com>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: Andre Przywara <andre@andrep.de>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas <linuxuser330250@gmx.net>

On Fri, Jan 11, 2013 at 07:03:35PM +0000, Gopalakrishnan, Aravind wrote:
> So, I had tried out the case when acpi-cpufreq was compiled into the
> kernel and looked at the return values from request_module(); it
> returns a positive value (255) both when acpi-cpufreq was compiled-in
> and when not compiled-in. (Please do let me know if I am missing
> something here...) (This was the case Andreas had mentioned in the bug
> report too)
>
> It was due to this that I had decided to just check the CONFIG option
> and print out a warning to the user.

Well, when both are built-in, I get -2 from request_module which is most
probably the retval of modprobe with a missing module (I delved deep
into the do_execve bowels but didn't go deep enough).

So, handoff to acpi-cpufreq still has some issues. When both are
built-in, the module_init functions turn into normal initcalls and
in that case, they're executed in link order and it can happen that
powernowk8_init() runs before acpi_cpufreq_init().

In that case, we get -2 (-ENOENT, see above) and even though there's an
error, acpi-cpufreq gets loaded so the error is bogus:

[    2.225413] powernow-k8: This CPU is now supported by acpi-cpufreq, loading it.
[    2.227266] powernow-k8: Error(-2) loading acpi-cpufreq, make sure you have it enabled, else you won't have any Pstates support on this CPU!
[    2.227868] acpi-cpufreq: overriding BIOS provided _PSD data

I still need to think hard about this case and how to fix it.

In the meantime, here's fix for Andreas' issue (as a reply to this
message). Rafael, the patch is trivial, you might want to send it now
and for stable.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
