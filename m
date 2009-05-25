From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 00:45:33 +0200
Message-ID: <200905260045.33902.oliver__3633.59712432629$1243291611$gmane$org@neukum.org>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1243245907.16743.101.camel@nigel-laptop>
	<200905252343.23744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905252343.23744.rjw@sisk.pl>
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

Am Montag, 25. Mai 2009 23:43:23 schrieb Rafael J. Wysocki:
> > Oh, before I forget to mention and you ask - how to know what allowance
> > for the drivers? I use a sysfs entry - the user then just needs to see
> > what's needed on their first attempt, set up a means of putting that
> > value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> > then forget about it.
>
> OK, this is reasonable.

No, I am afraid it is not. The average user has no clue. Even if that
is not the problem, the user never knows for sure he has encountered
the worst case. If you really have drivers that have exceptionally
large memory requirements (eg. you need to copy video ram), you
should tell the system through struct driver and do accounting at
probe and removal of devices.

	Regards
		Oliver
