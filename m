From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Bug 181381] New: Resume from suspend no longer works on Thinkpad X240
Date: Mon, 24 Oct 2016 22:42:23 +0200
Message-ID: <36039093.FNOp46uvm2@vostro.rjw.lan>
References: <bug-181381-76231@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60140 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753274AbcJXUfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 16:35:21 -0400
In-Reply-To: <bug-181381-76231@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: steinar+kernel@gunderson.no, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>

On Monday, October 24, 2016 08:28:18 PM bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=181381
> 
>             Bug ID: 181381
>            Summary: Resume from suspend no longer works on Thinkpad X240
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 4.9.0-rc1
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>           Assignee: rjw@rjwysocki.net
>           Reporter: steinar+kernel@gunderson.no
>                 CC: jarkko.sakkinen@linux.intel.com
>         Regression: No
> 
> Hi,
> 
> I have a Thinkpad X240, which suspends (to RAM) and resumes just fine with
> 4.7.4. However, in 4.9.0-rc1, it completely refuses to resume; when I try to
> press the power button to resume it from sleep, it just ignores the request
> completely and keeps pulsing the light.
> 
> bisect gives the following culprit:
> 
> commit 0c541332231e7957f23013e37f3720db33e7804c
> Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Date:   Fri Jun 17 13:12:20 2016 +0200
> 
>     tpm: use tpm_pcr_read_dev() in tpm_do_selftest()
> 
>     Instead of a ad-hoc protocol message construction it is better to
>     call tpm_pcr_read_dev().
> 
>     Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>     Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> I haven't tried 4.9.0-rc2, because that just hangs directly off of GRUB from
> me.

Jarkko, Jason, any chance to have a look at this?

Thanks,
Rafael

