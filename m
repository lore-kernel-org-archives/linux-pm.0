From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Thu, 5 Feb 2009 10:14:40 +0100
Message-ID: <20090205091439.GH2077@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-3-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



> +Early-suspend
> +=============
> +
> +The early-suspend api allows drivers to get notified when user-space writes to 
> +/sys/power/request_state to indicate that the user visible sleep state should 
> +change. 

"User visible sleep state"... hmm, PC developers are not going to
understand this.

> A level controls what order the handlers are called in. Suspend 
> +handlers are called in low to high level order, resume handlers are called in 
> +the opposite order. 
> +
> +Four levels are defined:
> +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
> +  On suspend the screen should be turned off but the framebuffer must still be
> +  accessible. On resume the screen can be turned back on.
> +

Blanking screen is traditionally done at user level? Why does this
need to be in kernel?

> +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
> +  On suspend this level notifies user-space that it should stop accessing the 
> +  framebuffer and it waits for it to complete. On resume it notifies user-space 
> +  that it should resume screen access.


> +  Two methods are provided, console switch or a sysfs interface.

Yeah. Pick one.

> +EARLY_SUSPEND_LEVEL_DISABLE_FB:
> +  Turn off the framebuffer on suspend and back on on resume.
> +
> +EARLY_SUSPEND_LEVEL_STOP_INPUT:
> +  On suspend turn off input devices that are not capable of wakeup or where
> +  wakeup is disabled. On resume turn the same devices back on.

At this point I don't see why early suspend should be done in
kernel. Framebuffer control is better left to userspace... and turning
off input devices should not require this kind of API.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
