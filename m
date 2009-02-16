From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:26:05 +0100
Message-ID: <200902170026.06966.rjw__3172.41188972748$1234826919$gmane$org@sisk.pl>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216225831.GH1370@ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 16 February 2009, Pavel Machek wrote:
> Hi!
> 
> > The recent descussion about the Android PM patches sent by Arve shows that
> > there is a need to introduce a mechanism allowing us to:
> > (1) automatically put the system as a whole into a sleep state (eg. suspend to
> >     RAM) when it is found to be "idle", where the meaning of "idle" has to be
> >     defined too,
> 
> Well; I'd prefer to keep the interface very minimal.
> 
> If no devices are being used,

We'll need some kind of infrastructure to detect such situations.

> and next wakeup is far enough in the future,

What exactly do you mean by "next wakeup"?

> just put system to sleep.  Long enough == so far away that suspend/wakeup
> is short compared to that... like 20 seconds on PC.

Well 10s will be fine on the majority of my test boxes, but that's a detail.

> Ok, it probably needs to be opt-in: echo auto-mem > /sys/power/state
> should do the trick.

Agreed.

> This will need either fixing all the applications not to poll, or
> maybe someone SIGSTOP-ing apps that are in background and poll too
> often.

Polling in general is not PM-friendly, so we'll need to deal with it somehow
at one point anyway.

Thanks,
Rafael
