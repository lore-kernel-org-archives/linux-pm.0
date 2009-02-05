From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/13] PM: wakelock: Add
	/sys/power/request_state
Date: Thu, 5 Feb 2009 10:27:11 +0100
Message-ID: <20090205092711.GK2077@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<20090205085250.GA2077@elf.ucw.cz>
	<d6200be20902050125h7732313cj50a90c22cf35fda8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902050125h7732313cj50a90c22cf35fda8@mail.gmail.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-02-05 01:25:03, Arve Hj?nnev?g wrote:
> On Thu, Feb 5, 2009 at 12:52 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >>  static const char * const pm_states[PM_SUSPEND_MAX] = {
> >> +#ifdef CONFIG_WAKELOCK
> >> +     [PM_SUSPEND_ON]         = "on",
> >> +#endif
> >>       [PM_SUSPEND_STANDBY]    = "standby",
> >>       [PM_SUSPEND_MEM]        = "mem",
> >>  };
> >
> > By doing this you change /sys/power/state interface. I do not think
> > you want to do that.
> 
> As long as valid_state(PM_SUSPEND_ON) returns 0, /sys/power/state
> should be unaffected.
> However, I can hardcode the "on" state in request_state if you prefer.

As long as /sys/power/state is unaffected, I'm okay with this.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
