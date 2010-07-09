From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 23:42:18 +0200
Message-ID: <201007092342.18286.rjw__15026.5491138727$1278711964$gmane$org@sisk.pl>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
	<20100709081239.4eb8fddd@virtuousgeek.org>
	<20100709160408.GU30043@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100709160408.GU30043@gamma.logic.tuwien.ac.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Norbert Preining <preining@logic.at>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 09, 2010, Norbert Preining wrote:
> Hi Jesse,
> 
> (stripping some people from Cc, hopefully not too many)
> 
> On Fr, 09 Jul 2010, Jesse Barnes wrote:
> > > > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=16179
> > > > Subject         : 2.6.35-rc2 completely hosed on intel gfx?
> > > > Submitter       : Norbert Preining <preining@logic.at>
> > > > Date            : 2010-06-06 11:55 (33 days old)
> > > > Message-ID      : <20100606115534.GA9399@gamma.logic.tuwien.ac.at>
> > > > References      : http://marc.info/?l=linux-kernel&m=127582534931581&w=2  
> > > 
> > > Hmm. That one is the vt.c bug coupled with another problem, which in
> > > turn got opened as a separate bugzilla entry:
> > > 
> > >    http://bugzilla.kernel.org/show_bug.cgi?id=16252
> > > 
> > > which in turn then got closed. I dunno.
> > 
> > Yeah, this is weird.  Norbert, do you still see this?  Have you tried
> > to bisect it?
> 
> I wrote in my last comment of this bug that in *most* of the cases
> the 
> 	echo "mem" > /sys/power/state
> works perfectly, and I'm using it permanently now.
> 
> The problem seems to be in combination with some pm-utils scripts.
> I still haven't been able to pin-point the actual pm-utils script that
> causes the problem, since that is something not 100% reproducible.
> 
> Futhermore, *once* (only once!) the echo mem > method failed as written in
> the bug report with :
> [16273.....] PM: resume of devices complete after 2115.046 msecs
> [16273.....] Restarting tasks ... done
> [16273.....] video LNXVIDEO:00: Restoring backlight state
> hanging here, but only once, not any time again.
> 
> It is hard to say what the culprit is, some new pm-utils script maybe,
> since it happens even when I switch pm-utils to use the kernel method
> (echo mem) to suspend, and not uswsusp (s2ram prog).
> 
> I would suggest keeping that bug closed until I have found the pm-utils
> or a specific culprit, then I can reopen it or open a new bug.
> 
> (more disturbing are iwlagn bugs, they are a PITA without any progress)

OK, closing.

Thanks,
Rafael
