From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend, followed by immediate resume
Date: Sat, 3 May 2008 14:50:19 +0200
Message-ID: <200805031450.19960.rjw@sisk.pl>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<20080502210529.56b11328@osprey.hogchain.net>
	<200805031432.12250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805031432.12250.rjw@sisk.pl>
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
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 3 of May 2008, Rafael J. Wysocki wrote:
> On Saturday, 3 of May 2008, Jay Cliburn wrote:
> > On Sat, 3 May 2008 01:49:44 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Friday, 2 of May 2008, Jay Cliburn wrote:
> > [...]
> > > > I poked around in BIOS and changed the behavior somewhat.  There's a
> > > > BIOS setting called "Suspend Mode" with three options:
> > > > 
> > > > 	S1 (POS) only
> > > > 	S3 only
> > > > 	Auto
> > > > 
> > > > When set to "S3 only" or "Auto," the machine spontaneously resumes
> > > > following a suspend.  When set to "S1 (POS) only" the machine stays
> > > > asleep.
> > > > 
> > > > What is "POS" an acronym for?
> > > 
> > > No idea.
> > 
> > Wikipedia to the rescue.  http://en.wikipedia.org/wiki/Acpi
> > 
> > S1 == POS == Power On Standby
> > 
> > I don't think I want to use this mode.  The cpu fan runs continuously at
> > max while suspended and the system won't resume; I have to whack it
> > with the reset button to get it going again (with a reboot).
> 
> That's bad.
> 
> > > > Does it make sense to leave the thing set to "S1 only?"
> > > 
> > > I guess it does.  Still, can you please post a boot log with it set
> > > this way?
> > 
> > Okay, it's attached.
> 
> Well, it says all ACPI sleep states are supported.
>  
> > BTW, I'm still using the modified version of acpi_pm_enter().
> 
> That shouldn't matter a lot, I think you can remove the comment.

BTW, have you tested it with init=/bin/bash already?

Rafael
