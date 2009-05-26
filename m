From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 01:10:53 +0200
Message-ID: <200905270110.54259.rjw__40364.5558319569$1243379638$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260058.54482.rjw@sisk.pl>
	<200905270051.35831.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905270051.35831.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 May 2009, Oliver Neukum wrote:
> Am Dienstag, 26. Mai 2009 00:58:53 schrieb Rafael J. Wysocki:
> > > No, I am afraid it is not. The average user has no clue. Even if that
> > > is not the problem, the user never knows for sure he has encountered
> > > the worst case.
> >
> > OK there, but surely it's better to have a sysfs attribute than a fixed
> > value?
> 
> Maybe I should have been more verbose.
> 
> A tunable setting is a race condition in itself. The right amount depends
> on the drivers loaded and the devices attached and possibly on the status
> of devices. Nothing of this can be determined statically.
> 
> You want hibernation to work even if the user has plugged in a new device.
> You have to calculate that amount in kernel space.

In practice, though, the drivers don't usually tell us in advance how much
memory they are going to need and I believe the only way they could do that
would be by allocating the memory from a hibernation notifier.

So, until the drivers start to use hibernation (and suspend for that matter)
notifiers, we need workarounds.

Best,
Rafael
