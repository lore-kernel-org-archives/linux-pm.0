From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 21:09:47 +0100
Message-ID: <200802242109.48573.rjw__41158.4206311547$1203883961$gmane$org@sisk.pl>
References: <200802241451.17334.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0802241409320.11316-100000@netrider.rowland.org>
	<c4e36d110802241142t9cb340dpc42a2d89166beb7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <c4e36d110802241142t9cb340dpc42a2d89166beb7b@mail.gmail.com>
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
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sunday, 24 of February 2008, Zdenek Kabelac wrote:
> 2008/2/24, Alan Stern <stern@rowland.harvard.edu>:
> > On Sun, 24 Feb 2008, Rafael J. Wysocki wrote:
> >
> >
> > > > You know, with this new patch we probably don't need
> >  > > device_pm_schedule_removal() any more.
> >  >
> >  > No, we don't.  However, because of that dpm_suspend() and device_power_down()
> >  > need to be changed not to assume that the removed devices will end up on
> >  > dpm_destroy.
> >
> >
> >  with analogous changes to dpm_suspend().
> >
> >  Any more suggestions for updates?
> >
> 
> Is there any current patch I should actually test - it looks there is
> ongoing discussion from the time Rafael has proposed his last patch to
> check by me: http://bugzilla.kernel.org/attachment.cgi?id=14961&action=view
> 
> But I think it's visible the only suspend update will not resolve my
> problems and the problems is deeper in the mmc.

Yes, there are problems in there, but your feedback is needed nevertheless.
 
> So should I still test yesterdays' patch ?

Yes please.  It will be valuable information to us whether it fixes the suspend
issue at least.

Thanks,
Rafael
