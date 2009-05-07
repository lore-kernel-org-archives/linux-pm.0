From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
	if a	suspend_blocker is active.
Date: Thu, 7 May 2009 12:41:43 +0200
Message-ID: <20090507104143.GB6132@elf.ucw.cz>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<20090505195753.GE1379@ucw.cz>
	<d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20905061851y12b07d59t11b43d74a07aad3b@mail.gmail.com>
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

On Wed 2009-05-06 18:51:11, Arve Hj?nnev?g wrote:
> On Tue, May 5, 2009 at 12:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> If a suspend_blocker is active, suspend will fail anyway. Since
> >> try_to_freeze_tasks can take up to 20 seconds to complete or fail, aborting
> >
> > Please fix try_to_freeze not to take significant time rather than
> > this...
> 
> I though we covered this already. Most of the 20 second delays we saw
> on earlier kernel version have been fixed, but this code can run for
> 20 seconds which is an unacceptable wakeup delay. Any
> uninterruptible

If the code runs for 20 seconds, it is a bug to be fixed.

IOW the patch should not be needed when the bugs are fixed. You should
not need it now.

Can you drop it for now (or keep it in private tree or something). If
you have scenario where it takes significant time and that can't be
fixed, please present the scenario and we can reconsider it.

For now, it just makes stuff harder to review.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
