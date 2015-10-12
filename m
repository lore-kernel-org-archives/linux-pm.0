From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v5] x86, suspend: Save/restore extra MSR registers for suspend
Date: Mon, 12 Oct 2015 21:15:44 +0200
Message-ID: <8500000.DY8G18orHR@vostro.rjw.lan>
References: <1444533601-12330-1-git-send-email-yu.c.chen@intel.com> <20151012163750.GA4539@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012163750.GA4539@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Chen Yu <yu.c.chen@intel.com>, mingo@redhat.com, pavel@ucw.cz, tglx@linutronix.de, hpa@zytor.com, rui.zhang@intel.com, luto@kernel.org, linux@horizon.com, dsmythies@telus.net, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, marcin.kaszewski@intel.com
List-Id: linux-pm@vger.kernel.org

On Monday, October 12, 2015 06:37:50 PM Borislav Petkov wrote:
> On Sun, Oct 11, 2015 at 11:20:01AM +0800, Chen Yu wrote:
> > A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> 
> I get:
> 
> "You are not authorized to access bug #1227208.
> 
> Most likely the bug has been restricted for internal development
> processes and we cannot grant access."
> 
> > that, after resumed from S3, CPU is running at a low speed.
> > After investigation, it is found that, BIOS has modified the value
> > of THERM_CONTROL register during S3, and changes it from 0 to 0x10
> > (thus changes the clock modulation from reserved to enabled),
> > since value of 0x10 means CPU can only get 25% of the Duty Cycle,
> > this triggers the problem.
> 
> Is this what the bug described above is? In any case, please remove the
> private bugzilla link and describe the bug in text here.
> 
> Also, from reading the other thread about the v4 patch, it sounds like
> intel_pstate can't handle the clock modulation properly, according to
> what Doug says.
> 
> So let's have this aspect sorted out properly first please before adding
> yet another ugly BIOS workaround.
> 
> Btw, why can't that BIOS be fixed instead?

Because it's been shipped to users.

Thanks,
Rafael
