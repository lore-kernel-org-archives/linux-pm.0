From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-git] pci_choose_state() works,
	does ACPI magic
Date: Thu, 10 May 2007 13:35:03 -0700
Message-ID: <200705101335.03821.david-b__8228.86355822465$1178829372$gmane$org@pacbell.net>
References: <200705091222.29561.david-b@pacbell.net>
	<200705102223.06087.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705102223.06087.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 10 May 2007, Rafael J. Wysocki wrote:
> On Wednesday, 9 May 2007 21:22, David Brownell wrote:
> > Provide new ACPI method tracking the target system state, for use
> > during suspend() and other PM calls.  It returns ACPI_STATE_S0
> > except during true suspend paths.
> > 
> > Use that to finally implement the platform_pci_choose_state() hook
> > on ACPI platforms.  It calls "_S3D" and similar methods, and uses
> > the result appropriately.
> > 
> > Fix pci_choose_state() to finally behave sanely too.
> > 
> > ...
> > 
> > ---
> >  drivers/acpi/sleep/main.c |   29 +++++++++++-
> >  drivers/pci/pci-acpi.c    |  107 +++++++++++++++++++++++++++++++++-------------
> >  drivers/pci/pci.c         |   51 ++++++++++++---------
> >  include/acpi/acpixf.h     |    2 
> >  4 files changed, 135 insertions(+), 54 deletions(-)
> > 
> > ...
> 
> I guess we'll need an analogous change for the hibernation too?

I guess so too.  This probably isn't in shape to merge, because
of those changes to split hibernation out; and not enough testing.
So far as I know, those are the only real issues with this patch.

- Dave
