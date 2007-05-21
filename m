From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 4/4] swsusp: Fix hibernation code
	ordering (updated)
Date: Tue, 22 May 2007 01:31:38 +0200
Message-ID: <20070521233138.GL10714__42442.4569624991$1179790383$gmane$org@elf.ucw.cz>
References: <200705180019.35548.rjw@sisk.pl> <200705180026.20647.rjw@sisk.pl>
	<200705191036.58177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705191036.58177.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Change the code ordering so that hibernation_ops->prepare() is called after
> device_suspend().  This is needed so that we don't violate the ACPI
> specification, which states that the _PTS and _GTS system-control methods,
> executed from acpi_sleep_prepare(), ought to be called after devices have been
> put in low power states.
> 
> The "Finish" label in hibernation_restore() is moved, because device_suspend()
> resumes devices if the suspending of them fails and the restore code ordering
> should reflect the hibernation code ordering.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
