From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Date: Wed, 25 Oct 2006 10:28:20 +0200
Message-ID: <20061025082820.GD7083@elf.ucw.cz>
References: <20061022122355.GC3502@stusta.de> <20061024150050.GA8766@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061024150050.GA8766@mellanox.co.il>
Sender: linux-ide-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2006-10-24 17:00:51, Michael S. Tsirkin wrote:
> Quoting r. Adrian Bunk <bunk@stusta.de>:
> > Subject: 2.6.19-rc2: known unfixed regressions (v3)
> > 
> > This email lists some known unfixed regressions in 2.6.19-rc2 compared 
> > to 2.6.18 that are not yet fixed Linus' tree.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> >
> 
> skip, hope I didn't trim too much.
> 
> >
> > Subject    : T60 stops triggering any ACPI events
> > References : http://lkml.org/lkml/2006/10/4/425
> >              http://lkml.org/lkml/2006/10/16/262
> > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > Status     : unknown
> 
> Just retested with 2.6.19-rc3 - it's still there:
> e.g. after I do a full kernel compile, my T60 stops triggering any ACPI events:
> tail -f /var/log/acpid does not show anything, even on Fn/F4 which is supposed
> to be always enabled.  Restarting the acpid doesn't do anything either - ACPI
> starts working again, for a while, only after reboot.
> 
> Works fine in 2.6.18 ( + this patch http://lkml.org/lkml/2006/7/20/56).

Bugzilla.kernel.org, assign it to acpi people...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
