From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 01:13:46 +0200
Message-ID: <200905260113.46440.oliver__44432.5307188139$1243293484$gmane$org@neukum.org>
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
> On Tuesday 26 May 2009, Oliver Neukum wrote:

> > No, I am afraid it is not. The average user has no clue. Even if that
> > is not the problem, the user never knows for sure he has encountered
> > the worst case.
>
> OK there, but surely it's better to have a sysfs attribute than a fixed
> value?

Why? The driver knows best. Tunables are generally the worst solution.

> > If you really have drivers that have exceptionally large memory
> > requirements (eg. you need to copy video ram), you should tell the system
> > through struct driver and do accounting at probe and removal of devices.
>
> Or perhaps the drivers should allocate memory from a PM notifier (which is
> called before the freezing of tasks) to avoid the problem?

That's also possible. It is slightly more wasteful, as you are required
to actually the memory. If you tell the core, it is sufficient that the memory
can be freed without a device driver becoming involved, that is the page
must be cleaned but doesn't have to be dropped.

	Regards
		Oliver
