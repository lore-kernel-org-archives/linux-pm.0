From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions (version 3)
Date: Tue, 24 Feb 2009 00:54:26 +0100
Message-ID: <200902240054.27878.rjw@sisk.pl>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<20090222134852.GB1436@ucw.cz>
	<d6200be20902231531r75f8ee05o1f512d1636710c3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902231531r75f8ee05o1f512d1636710c3d@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sun, Feb 22, 2009 at 5:48 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > earlysuspend is an ugly hack and wakelock is very wrong name at the
> >> > very least... as seen in previous discussion. Can we get that fixed?
> >>
> >> I don't have a fix for earlysuspend, but it is far less important than
> >> wakelocks, so I can drop it from the patch series if that is
> >> preferred.
> >>
> >> Regarding the name, I don't agree with your statement that wakelock is
> >> a very wrong name. Like I said before, you can view it as a
> >> reader/writer lock where the readers protect the wake state of the
> >> system. That said, if there is a better name that more than one person
> >> can agree on, I can rename the api. Here is a list of suggestions I
> >> have seen so far along with the api I think they dictate if the
> >> existing functionality is to be preserved:
> >
> >
> >> suspend_inhibitor: (from inhibit_suspend)
> >> - api: suspend_inhibitor_init, suspend_inhibitor_destroy,
> >> suspend_inhibit, suspend_inhibit_timeout, suspend_uninhibit
> >> - pros: The effect is more obvious than *_lock.
> >> - cons: Does not match android user space api (but less confusing than
> >> suspend/sleep_lock).
> >
> > I like this one, as does rafael, so :-).
> >
> > I thought you are switching to /dev based api anyway so rename should
> > not be a problem?
> =

> There is no requirement for the kernel api to match the user-space
> api, it is just less confusing. The android java apis provide a
> wakelock interface. We cannot change this api, but the both the in
> kernel api and the api from the kernel to user space can be changed.
> =

> I did a quick poll here. 2 people preferred suspend_inhibitor and 3
> people preferred wake_lock. The people who preferred wake_lock did not
> like the word inhibit(or). Block(er) was suggested as an alternative.

"blocker" would be fine too, as far as I'm concerned.

Thanks,
Rafael
