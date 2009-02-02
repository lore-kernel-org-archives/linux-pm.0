From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/11] PM: Enable early suspend
	through	/sys/power/state
Date: Mon, 2 Feb 2009 12:45:14 +0100
Message-ID: <20090202114514.GB4631@elf.ucw.cz>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231896476-22445-5-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
	<20090128193409.GC1222@ucw.cz>
	<d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-01-30 19:13:32, Arve Hj?nnev?g wrote:
> On Wed, Jan 28, 2009 at 11:34 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> If EARLYSUSPEND is enabled then writes to /sys/power/state no longer
> >> blocks, and the kernel will try to enter the requested state every
> >> time no wakelocks are held. Write "on" to resume normal operation.
> >
> > No, please don't break compatibility like this. You changed semantics
> > of 'mem'...
> >
> > Just add another two states, for example "auto-mem" and
> > "auto-standby", and make them enter mem/standby when required.
> >
> 
> What would you want to happen if someone writes "mem"? If we just call
> enter_state, it will fail and return an error if a wakelock is
> locked.

That would be fine. And ignoring wakelocks in this case would be even better.

> We can call request_suspend_state and then wait for another thread to
> write "on", but this still requires user-space changes to work
> correctly. If the goal is to allow the kernel to be compiled with
> wakelock and early suspend support while preserving the old behaviour
> if wakelocks are not used, then the first option is better.

Yes, goal is that compiling in  wakelock / early suspend support has
no effect on existing functionality.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
