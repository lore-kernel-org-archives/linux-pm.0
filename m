From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Sun, 14 Jun 2009 00:04:41 +0200
Message-ID: <200906140004.42223.rjw__15021.4524161585$1244930733$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906131404160.25619-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906131404160.25619-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 13 June 2009, Alan Stern wrote:
> On Sat, 13 Jun 2009, Rafael J. Wysocki wrote:
> 
> > So, the conclusion seems to be that we should break the recurrence
> > at the point we find an already active device or a device with no parent and
> > let the driver(s) handle the more complicated cases.  Is this correct?
> 
> That's right.

OK

> > BTW, is __device_release_driver() the right place for blocking the run-time PM
> > temporarily during remove?
> 
> It is.

OK

> And for submitting a delayed autosuspend request afterward; we
> may as well try to suspend devices that don't have drivers.

OK, but I'd like to add this functionality if future, when at least one bus
type starts using the framework.

I think I have all of the ducks in a row now, so I'm going to post a cleaned-up
patch in a new thread in a while.

Thanks,
Rafael
