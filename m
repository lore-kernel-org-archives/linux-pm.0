From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 00:51:35 +0200
Message-ID: <200905270051.35831.oliver__12554.5199182399$1243378602$gmane$org@neukum.org>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260045.33902.oliver@neukum.org>
	<200905260058.54482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905260058.54482.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 26. Mai 2009 00:58:53 schrieb Rafael J. Wysocki:
> > No, I am afraid it is not. The average user has no clue. Even if that
> > is not the problem, the user never knows for sure he has encountered
> > the worst case.
>
> OK there, but surely it's better to have a sysfs attribute than a fixed
> value?

Maybe I should have been more verbose.

A tunable setting is a race condition in itself. The right amount depends
on the drivers loaded and the devices attached and possibly on the status
of devices. Nothing of this can be determined statically.

You want hibernation to work even if the user has plugged in a new device.
You have to calculate that amount in kernel space.

	Regards
		Oliver
