From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [Bug 181381] New: Resume from suspend no longer works on
 Thinkpad X240
Date: Wed, 26 Oct 2016 13:52:35 +0300
Message-ID: <20161026105235.fb5l733zqdwonl4k@intel.com>
References: <bug-181381-76231@https.bugzilla.kernel.org/>
 <36039093.FNOp46uvm2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36039093.FNOp46uvm2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bugzilla-daemon@bugzilla.kernel.org, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, steinar+kernel@gunderson.no, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 24, 2016 at 10:42:23PM +0200, Rafael J. Wysocki wrote:
> On Monday, October 24, 2016 08:28:18 PM bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=181381
> > 
> >             Bug ID: 181381
> >            Summary: Resume from suspend no longer works on Thinkpad X240
> >            Product: Power Management
> >            Version: 2.5
> >     Kernel Version: 4.9.0-rc1
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Hibernation/Suspend
> >           Assignee: rjw@rjwysocki.net
> >           Reporter: steinar+kernel@gunderson.no
> >                 CC: jarkko.sakkinen@linux.intel.com
> >         Regression: No
> > 
> > Hi,
> > 
> > I have a Thinkpad X240, which suspends (to RAM) and resumes just fine with
> > 4.7.4. However, in 4.9.0-rc1, it completely refuses to resume; when I try to
> > press the power button to resume it from sleep, it just ignores the request
> > completely and keeps pulsing the light.
> > 
> > bisect gives the following culprit:
> > 
> > commit 0c541332231e7957f23013e37f3720db33e7804c
> > Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Date:   Fri Jun 17 13:12:20 2016 +0200
> > 
> >     tpm: use tpm_pcr_read_dev() in tpm_do_selftest()
> > 
> >     Instead of a ad-hoc protocol message construction it is better to
> >     call tpm_pcr_read_dev().
> > 
> >     Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >     Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > 
> > I haven't tried 4.9.0-rc2, because that just hangs directly off of GRUB from
> > me.
> 
> Jarkko, Jason, any chance to have a look at this?

I've fixed this a while ago but the pull request is still on hold:

http://www.spinics.net/lists/kernel/msg2356176.html 

> Thanks,
> Rafael

/Jarkko
