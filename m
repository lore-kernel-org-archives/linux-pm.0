From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 02:39:14 +0200
Message-ID: <201005280239.14819.rjw__5499.89558426223$1275007230$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005271344040.3239-100000@iolanthe.rowland.org>
	<201005280110.17075.rjw@sisk.pl>
	<20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528005045.6ea5feba@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 28 May 2010, Alan Cox wrote:
> > That's correct, but to me the Arve's goal is simply to maximize battery life
> > and he found experimentally that the longest battery life is achieved if
> > system suspend is used whenever the system doesn't need to be active (from its
> > user's perspective).  This actually is different from "when the system is
> > idle", because the system isn't idle, for example, when updatedb is running.
> > However, from the user's perspective the updatedb process doesn't really need
> > to run at this particular time, it can very well do it's job in parallel with
> > the user typing or reading news.  So, the system may very well be suspended
> > when updatedb is running.
> 
> This is where the original questions around QoS came in
> 
> > Since I think we've now rejected the feature, do we have a clear picture about
> > what the Android people should do _instead_ and yet keep the battery life they
> > want?  Because I don't think telling "let them do what they want, who cares"
> > is right.
> 
> Today "idle" means "no task running"
> 
> If you are prepared to rephrase that as "no task that matters is running"
> what would need to answer ?
> 
> - How do we define who matters: QoS ?

That's reasonable IMO.

> - Can you describe "idle" in terms of QoS without then breaking the
>   reliable wakeup for an event (and do you need to ?)
> 
> 	Could this for example look like
> 
> 	Set QoS of 'user apps' to QS_NONE
> 	Button pushed
> 	Button driver sets QoS of app it wakes to QS_ABOVESUSPEND
> 
> 	That would I think solve the reliable wakeup case although
> 	drivers raising a QoS parameter is a bit unusual in the kernel.
> 	That would at least however be specific to a few Android drivers
> 	and maybe a tiny amount of shared driver stuff so probably not
> 	unacceptable. (wake_up_pri(&queue, priority); isn't going to
> 	kill anyone is it - especially if it usually ignores the
> 	priority argument)
> 
> 	I am curious Thomas how that would tie in with PI in the RT
> 	world, it's effectively inheriting priority from the users finger.
> 
> - Would a model where the UI side behaviour looked like
> 
> 	Timeout
> 	Screen Off
> 	Set QoS of 'user apps' to QS_NONE
> 
> 	Event
> 	[Some chain of activity]
> 	Screen On
> 	Set QoS of 'user apps' to QS_ABOVESUSPEND
> 
>   do the job combined with the ability to see who is stopping us dropping
>   to suspend so user space can take action. This could be a data table
>   from the Android cpu manager provided to Android specific policy in
>   whoever owns the display.
> 
> 
> If so how do we fix the UI policy code doing
> 
> 	Screen Off
> 					Button Press
> 					task to QS_ABOVESUSPEND
> 	task to QS_NONE
> 
> without touching the app userspace code
> 
> 
> Perhaps
> 
> 	count2 = tasks to QS_NONE | QS_NOTCHANGED
> 	Screen off
> 					Button Press
> 					task to QS_ABOVESUSPEND
> 	count = tasks that are QS_NOTCHANGED to QS_NONE
> 
> 	if (count != count2) {
> 		Stuff happened ... rethink
> 	}
> 
> That is still a bit weird and wonderful but all the logic is in the right
> places. The special magic remains in the Android policy code and in the
> kernel specifics for Android.
> 
> Thoughts ?

Hmm.  How do we prevent the "non-relevant" tasks from being scheduled
once we've decided to go for power saving?

Rafael
