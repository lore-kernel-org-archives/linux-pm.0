From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sun, 26 Apr 2009 11:42:53 +0200
Message-ID: <20090426094253.GA1376@ucw.cz>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
	<d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
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

Hi!

> >> --- a/kernel/power/power.h
> >> +++ b/kernel/power/power.h
> >> @@ -223,3 +223,9 @@ static inline void suspend_thaw_processes(void)
> >> =A0{
> >> =A0}
> >> =A0#endif
> >> +
> >> +#ifdef CONFIG_SUSPEND_BLOCK
> >> +/* kernel/power/suspend_block.c */
> >> +void request_suspend_state(suspend_state_t state);
> >> +#endif
> >
> > Is the #ifdef really necessary?
> >
> =

> No, but it gives a compile error instead of a link error if you call
> request_suspend_state when it is not available so it is useful.

I believe #ifdef is too ugly and link error is really good enough.

  	  	    	     	      	       	      	   Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
