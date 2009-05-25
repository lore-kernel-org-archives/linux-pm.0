From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 00:58:53 +0200
Message-ID: <200905260058.54482.rjw__10170.9011164077$1243292376$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905252343.23744.rjw@sisk.pl>
	<200905260045.33902.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905260045.33902.oliver@neukum.org>
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

On Tuesday 26 May 2009, Oliver Neukum wrote:
> Am Montag, 25. Mai 2009 23:43:23 schrieb Rafael J. Wysocki:
> > > Oh, before I forget to mention and you ask - how to know what allowance
> > > for the drivers? I use a sysfs entry - the user then just needs to see
> > > what's needed on their first attempt, set up a means of putting that
> > > value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> > > then forget about it.
> >
> > OK, this is reasonable.
> 
> No, I am afraid it is not. The average user has no clue. Even if that
> is not the problem, the user never knows for sure he has encountered
> the worst case.

OK there, but surely it's better to have a sysfs attribute than a fixed value?

> If you really have drivers that have exceptionally large memory requirements
> (eg. you need to copy video ram), you should tell the system through struct
> driver and do accounting at probe and removal of devices.

Or perhaps the drivers should allocate memory from a PM notifier (which is
called before the freezing of tasks) to avoid the problem?

Rafael
