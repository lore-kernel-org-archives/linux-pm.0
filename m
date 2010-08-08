From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 21:17:38 +0200
Message-ID: <201008082117.39082.rjw__28796.2580951445$1281295217$gmane$org@sisk.pl>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<AANLkTinebiC=9Xd-D_sOwmvA8w_YPWMdhTYz2NRbZ7jH@mail.gmail.com>
	<AANLkTim-a6qHL_Xo+iVUW4p79EMMRssa0-AqZenNSYJr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim-a6qHL_Xo+iVUW4p79EMMRssa0-AqZenNSYJr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/8/7 Arve Hj=F8nnev=E5g <arve@android.com>:
> > 2010/8/7 Rafael J. Wysocki <rjw@sisk.pl>:
> >> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
> >>> 2010/8/6 Alan Stern <stern@rowland.harvard.edu>:
> >>> > On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:
> ...
> >>> >> total_time, total time the wake lock has been active. This one sho=
uld
> >>> >> be obvious.
> >>> >
> >>> > Also easily added.
> >>> >
> >>> Only with a handle passed to all the calls.
> >>
> >> Well, I'm kind of tired of this "my solution is the only acceptable on=
e"
> >> mindset.  IMHO, it's totally counter productive.
> >>
> >
> > How do you propose to track how long a driver has blocked suspend when
> > you have an unblock call that takes no arguments.
> >
> =

> Also, I did not not see a response to my question about why you don't
> want to pass a handle.

It doesn't really matter what I personally want.  In fact, I'm not totally
opposed to that idea, although there are disadvantages (eg. a "handle"
would really mean a pointer to an object with certain life cycle that needs=
 to
be managed by the caller and it's not that clear to me who should manage the
objects that the PCI wakeup code would pass to pm_wakeup_event(), for one
example).  I sent a pull request for your original patchset to Linus after =
all. :-)

I said I didn't think "it would fly", meaning that I was afraid the other k=
ernel
developers wouldn't like that change.

The reason why I think so is that you'd like to add a whole new infrastruct=
ure
whose only purpose would be debugging that would only be useful to systems
using opportunistic suspend.  That, however, is only Android right now and =
it
cannot use the mainline kernel for other reasons, so basically we would add
infrastructure that's useful to no one.

Thanks,
Rafael
