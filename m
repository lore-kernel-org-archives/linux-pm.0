From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Sun, 27 May 2007 23:01:58 +0100
Message-ID: <20070527220158.GB22687__10730.2982047715$1180303369$gmane$org@srcf.ucam.org>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<20070527204955.GA22202@srcf.ucam.org>
	<200705272345.04518.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705272345.04518.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, May 27, 2007 at 11:45:03PM +0200, Rafael J. Wysocki wrote:
> On Sunday, 27 May 2007 22:49, Matthew Garrett wrote:
> > If we remove process freezing in STR, this should just work[1] without the
> > need to complicate things. 
> 
> Under the (optimistic, IMO) assumption that the relevant user space task won't
> block on I/O with a suspended device involved or something like this.

Yeah, I forgot the footnote that was going to mention that. Clearly 
there are issues if this is on some block device that hasn't been 
resumed yet.

> BTW, I know of two subsystems that want their kernel threads to be frozen for
> synchronization purposes.  Please see these messages:
> 
> 1) https://lists.linux-foundation.org/pipermail/linux-pm/2007-May/012592.html
> (plus follow up)
> 
> 2) http://marc.info/?l=linux-kernel&m=117919066830575&w=2

I'm not entirely sold on this. The issue is that there's the possibility 
of races during suspend/resume? It sounds like that should be 
implemented in the driver, rather than depending on a side-effect of 
process freezing. Otherwise there's no way of selectively suspending 
that device.

> Besides, there's the hibernation that needs to freeze tasks for another reason,
> so it needs some way to ensure that drivers won't request firmware while
> the user land is frozen.

I agree that that's an issue right now, but I think we should see if 
this is repairable without just breaking those drivers. One option would 
be to defer resuming them until userspace is alive again - that would be 
no worse than the suspend to RAM case without process freezing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
