From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 23:58:31 +0100
Message-ID: <20090216225831.GH1370__29607.3831421838$1234825334$gmane$org@ucw.cz>
References: <200902160010.16955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902160010.16955.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The recent descussion about the Android PM patches sent by Arve shows that
> there is a need to introduce a mechanism allowing us to:
> (1) automatically put the system as a whole into a sleep state (eg. suspend to
>     RAM) when it is found to be "idle", where the meaning of "idle" has to be
>     defined too,

Well; I'd prefer to keep the interface very minimal.

If no devices are being used, and next wakeup is far enough in the
future, just put system to sleep. Long enough == so far away that
suspend/wakeup is short compared to that... like 20 seconds on PC.

Ok, it probably needs to be opt-in: echo auto-mem > /sys/power/state
should do the trick.

This will need either fixing all the applications not to poll, or
maybe someone SIGSTOP-ing apps that are in background and poll too
often.

> (2) put given subset of devices into low power states whenever they are not
>     used, without putting the entire system into a sleep state.

Arjan said this nicely...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
