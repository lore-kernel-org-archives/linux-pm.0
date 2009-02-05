From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/13] PM: earlysuspend: Removing dependence
	on console.
Date: Thu, 5 Feb 2009 10:53:06 +0100
Message-ID: <20090205095305.GN2077@elf.ucw.cz>
References: <1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<1233802226-23386-12-git-send-email-arve@android.com>
	<20090205090621.GE2077@elf.ucw.cz>
	<d6200be20902050142p8924340mdc00100293b4dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902050142p8924340mdc00100293b4dda@mail.gmail.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, Rebecca Schultz <rschultz@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> >> +               Register early suspend handler that notifies and waits for
> >> +               user-space through sysfs when user-space should stop drawing
> >> +               to the screen and notifies user-space when it should resume.
> >>  endchoice
> >
> > Hmm, as far as I can tell, turning this option on will immediately
> > break suspend on all existing setups. Bad.
> 
> I'm not aware of any existing interface that works if console support
> is not enabled.

That's why console switching support is mandatory today.

If you want to change that, fine, but CONFIG_ option should not
immediately break existing setups. Rather, you should detect that
userspace is capable of using new interface, and only then wait for
it...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
