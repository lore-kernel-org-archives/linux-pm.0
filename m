From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] PM: earlysuspend: Add console switch
	when user	requested sleep state changes.
Date: Thu, 5 Feb 2009 10:51:02 +0100
Message-ID: <20090205095102.GM2077@elf.ucw.cz>
References: <1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<20090205090316.GD2077@elf.ucw.cz>
	<d6200be20902050137q19cf544fx40f2f3167289ab42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902050137q19cf544fx40f2f3167289ab42@mail.gmail.com>
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

On Thu 2009-02-05 01:37:53, Arve Hj?nnev?g wrote:
> On Thu, Feb 5, 2009 at 1:03 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >> +               Register early suspend handler to perform a console switch to
> >> +               when user-space should stop drawing to the screen and a switch
> >> +               back when it should resume.
> >
> > I could not parse english here.
> 
> The "to"on the first line should be removed.
> 
> > Actually, I'd hope that system where you control everything (such as
> > android) would not need to switch consoles. Console switch was
> > invented as a workaround for X owning the hardware....
> 
> We don't anymore, but if you enable console support (for debugging) we
> support it.

I'd guess the audience of debugging people running android is pretty
limited. I'd suggest this is not really suitable for mainline.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
