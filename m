From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] PM: earlysuspend: Add console switch
	when user	requested sleep state changes.
Date: Sun, 8 Feb 2009 23:58:13 +0100
Message-ID: <20090208225813.GS6369@elf.ucw.cz>
References: <1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<20090205090316.GD2077@elf.ucw.cz>
	<d6200be20902051829m547664e7j5cba989aaea535a5@mail.gmail.com>
	<20090208220208.GJ6369@elf.ucw.cz>
	<d6200be20902081453q7b988e99t153c4ae5ecebd17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902081453q7b988e99t153c4ae5ecebd17e@mail.gmail.com>
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

On Sun 2009-02-08 14:53:33, Arve Hj?nnev?g wrote:
> On Sun, Feb 8, 2009 at 2:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Thu 2009-02-05 18:29:30, Arve Hj?nnev?g wrote:
> >> On Thu, Feb 5, 2009 at 1:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >> > changelog would be welcome.
> >>     PM: earlysuspend: Add console switch when user requested sleep
> >> state changes.
> >>
> >>     When early-suspend is enabled, the framebuffer is turned off at
> >>     early-suspend. If CONSOLE_EARLYSUSPEND is enabled, a console switch
> >>     is used to notify user space that it should stop drawing before
> >>     the framebuffer is disabled, and that it should repaint and resume
> >>     drawing after the framebuffer is turned back on.
> >
> > I'd say that userspace can just do the switch itself?
> 
> The purpose of the console switch is to take the framebuffer away from
> user-space. Are you suggesting that we instead should initiate sleep
> when user-space switches to the sleep console?

That looks like a solution, yes.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
