From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.30-rc2-git2: Reported regressions from 2.6.29
Date: Fri, 17 Apr 2009 23:35:27 +0200
Message-ID: <200904172335.28304.rjw__48302.4308611222$1240008064$gmane$org@sisk.pl>
References: <EJaiQ4Wfaz.A.3YG.4v85JB@chimera>
	<1239931813.7661.394.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1239931813.7661.394.camel@rzhang-dt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 17 April 2009, Zhang Rui wrote:
> On Fri, 2009-04-17 at 05:42 +0800, Rafael J. Wysocki wrote:
> > 
> > 
> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=13095
> > Subject         : thinkpad-acpi: cannot control brightness with hotkeys
> > Submitter       : Niel Lambrechts <niel.lambrechts@gmail.com>
> > Date            : 2009-04-11 23:07 (6 days old)
> > References      : http://lkml.org/lkml/2009/4/11/160
> > Handled-By      : Matthew Garrett <mjg59@srcf.ucam.org>
> > Patch           : http://lkml.org/lkml/2009/4/15/339
> > 
> > 
> > Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=13048
> > Subject         : /sys/class/backlight/acpi_video0/* is gone on vaio laptop with Intel GM45.
> > Submitter       : Rodrigo L. Batista <rodrigo@gus-mg.org>
> > Date            : 2009-04-09 04:57 (8 days old)
> > Handled-By      : yakui_zhao <yakui.zhao@intel.com>
> > Patch           : http://bugzilla.kernel.org/attachment.cgi?id=20967
> >                   http://bugzilla.kernel.org/attachment.cgi?id=20959
> > 
> > 
> bug 13095 is a duplicate of bug 13048.
> patches from Matthew and Yakui are for the same issue.

OK, closed 13095 as a duplicate.

Thanks,
Rafael
