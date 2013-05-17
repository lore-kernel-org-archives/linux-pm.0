From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 3.10-rc1 system starts regular boot when waking from s2ram
Date: Fri, 17 May 2013 14:11:26 +0200
Message-ID: <1795910.x0krlBPTaf@vostro.rjw.lan>
References: <20130514160108.GA5055@dhcp22.suse.cz> <20130515095608.GB5455@dhcp22.suse.cz> <20130517075446.GA5048@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55026 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab3EQMCy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 May 2013 08:02:54 -0400
In-Reply-To: <20130517075446.GA5048@dhcp22.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>, x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Friday, May 17, 2013 09:54:46 AM Michal Hocko wrote:
> On Wed 15-05-13 11:56:08, Michal Hocko wrote:
> > OK, I have bisected it to 78d77df7 (x86-64, init: Do not set NX bits on
> > non-NX capable hardware). Reverting the patch on top of 3.10-rc1 fixes
> > the issue for me and the machine resumes just fine.
> > 
> > Let's add involved people to the CC.
> > 
> > The original message with the confing and dmesg is bellow.
> 
> Anybody had chance to look at this? I am quite surprised that something
> that is in init code might influence resume from suspend path. Or is it
> just a side effect of some other changes in that area?
> 
> <goes and checks the latest 3.9 stable which has the backport of the patch>
> 
> Yes the latest stable is affected as well!

Well, I suppose there will be more response if you send a revert request to
Linus.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
