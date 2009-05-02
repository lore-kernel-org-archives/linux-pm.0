From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sat, 2 May 2009 14:17:52 +0200
Message-ID: <200905021417.53703.rjw@sisk.pl>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
	<20090426094253.GA1376@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090426094253.GA1376@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 26 April 2009, Pavel Machek wrote:
> Hi!
> 
> > >> --- a/kernel/power/power.h
> > >> +++ b/kernel/power/power.h
> > >> @@ -223,3 +223,9 @@ static inline void suspend_thaw_processes(void)
> > >>  {
> > >>  }
> > >>  #endif
> > >> +
> > >> +#ifdef CONFIG_SUSPEND_BLOCK
> > >> +/* kernel/power/suspend_block.c */
> > >> +void request_suspend_state(suspend_state_t state);
> > >> +#endif
> > >
> > > Is the #ifdef really necessary?
> > >
> > 
> > No, but it gives a compile error instead of a link error if you call
> > request_suspend_state when it is not available so it is useful.
> 
> I believe #ifdef is too ugly and link error is really good enough.

Well, I agree with this FWIW.

We don't ususally use #ifdefs around function headers, unless they are defined
conditionally.

Thanks,
Rafael
