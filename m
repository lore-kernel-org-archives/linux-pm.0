From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sun, 1 Feb 2009 08:03:44 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9A827@dlee02.ent.ti.com>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<200902010232.22055.rjw@sisk.pl>
	<d6200be20901311814n24518903m23731685324c7cce@mail.gmail.com>
	<200902011330.03579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902011330.03579.rjw@sisk.pl>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Brian Swetland <swetland@google.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

> > In that case, why are you against using wakelocks to abort the suspend
> > sequence? It covers the case where the driver knows that a call is
> > coming in, without any confusion about when the abort condition
> > clears. And, it avoids the overhead of freezing every process for an
> > operation that is doomed to fail.
>
> I'm not really against (yet), I'm only trying to clearly understand the
> benefit.
>
> The problem pointed out by Alan is real, the user expects the system to
> suspend
> as soon as the button is pressed and wakelocks may get in the way.
>
> Your example is also good, but I think the problem in your example (phone
> call coming in while suspending) may be resolved without wakelocks.  Moreover,
> it is a general problem of a wake-up event coming in while suspending and
> it requires a general solution independent of wakelocks.

What is being done is automatic very aggressive use of suspend. This is not a button press by the user.  As the same end mechanism is used (plumbing and end suspend call in driver) people are worried about semantics.

At the driver level it might be viewed as a constraint frame work which allows veto of the system-auto-suspend.  It provides a short circuits of the suspend before it gets very far.

There is a summed user space input point which allows user space to have a vote.  The upper level user space coordination prior to summed kernel interface is interesting.

At the kernel level if you work really really hard and use actively timers I think cpuidle and pm_qos can get you a similar aggressive sleep. However, there are many 'bad' drivers and it's a lot easier to re-use the suspend path. Being told to sleep is something drivers know, but doing it automatically and interfaces around that is not.  For OMAP3 we fixed up all drivers make cpuidle work and also keep traditional suspend.  This has been hard but possible.

While it is possible to fix kernel space doing the same to user space can be very hard. User space is much bigger and badness there can sink all your work in the kernel. What is good about android-system-auto-suspend here is that the freezer will stop a lot of bad processes in their tracks. To stop breakages in user space you can do the preferred thing and fix the code to be smart which could be hard/impossible or raise and lower a wakelock.  The wake lock is easier by comparison.

Any corrections by android experts are welcome.

Regards,
Richard W.

BTW, yes, the screen state is very import event in system power management on a cell phone.  When it blanks you move into a time where you can be very aggressive.  At this point a lot of timers (like user activity) and the like are expired.  You can do things which were not valid before as they would disrupt user experience.  Embedded people will use this as a critical point of reference as it's a pivot point.
