From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 10:25:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121023010.2915-100000__23333.9404374876$1244816807$gmane$org@iolanthe.rowland.org>
References: <200906112143.57361.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906112143.57361.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Jun 2009, Rafael J. Wysocki wrote:

> > > > It might also be nice to make sure that the driver core autoresumes a 
> > > > device before probing it and autosuspends a device (after some 
> > > > reasonable delay) after unbinding its driver.
> > > 
> > > Agreed.
> > 
> > This is another case where a usage counter comes in handy.  The driver
> > core resumes the device and increments the counter -- thus preventing
> > any unwanted autosuspends -- before making the probe and remove calls.
> 
> I like this idea.
> 
> BTW, where exactly the counter should be increased in that case?
> 
> I thought of driver_probe_device(), but is it sufficient?  Or is there a better
> place?

That's okay.  Or you could put it in really_probe().  Either one.

Alan Stern
