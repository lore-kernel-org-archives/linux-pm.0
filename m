From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions (version 3)
Date: Thu, 19 Feb 2009 13:54:14 +0100
Message-ID: <200902191354.15096.rjw@sisk.pl>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<20090217210504.GD1433@ucw.cz>
	<d6200be20902181743i1bb36fe8m95b50c0fbd6d3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902181743i1bb36fe8m95b50c0fbd6d3c2@mail.gmail.com>
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

On Thursday 19 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Tue, Feb 17, 2009 at 1:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> The following patch series adds two apis, wakelock and earlysuspend.
> >> The Android platform uses the earlysuspend api to turn the screen
> >> and some input devices on and off. The wakelock code determines when
> >> to enter the full suspend state.
> >
> > earlysuspend is an ugly hack and wakelock is very wrong name at the
> > very least... as seen in previous discussion. Can we get that fixed?
> =

> I don't have a fix for earlysuspend, but it is far less important than
> wakelocks, so I can drop it from the patch series if that is
> preferred.

Well, I think it should be rethought at least.

> Regarding the name, I don't agree with your statement that wakelock is
> a very wrong name. Like I said before, you can view it as a
> reader/writer lock where the readers protect the wake state of the
> system. That said, if there is a better name that more than one person
> can agree on, I can rename the api. Here is a list of suggestions I
> have seen so far along with the api I think they dictate if the
> existing functionality is to be preserved:
> =

> wake_lock:
> - api: wake_lock_init, wake_lock_destroy, wake_lock, wake_lock_timout,
> wake_unlock
> - pros: matches android user space api.
> - cons: Can be confused with mutual exclusion apis.
> =

> suspend_stop_valve:
> - api: open/close?
> - pros: ?
> - cons: Api can be confused with device open/close.
> =

> suspend_lock/sleep_lock:
> - api: same as wakelock, but replace wake with suspend or sleep
> - pros: Sleep or suspend is more easily associated with power
> management than wake by some people.
> - cons: Can be confused with mutual exclusion apis, (suspend_lock) was
> confusing to people that also wrote android user space code.
> =

> suspend_inhibitor: (from inhibit_suspend)
> - api: suspend_inhibitor_init, suspend_inhibitor_destroy,
> suspend_inhibit, suspend_inhibit_timeout, suspend_uninhibit
> - pros: The effect is more obvious than *_lock.
> - cons: Does not match android user space api (but less confusing than
> suspend/sleep_lock).

FWIW, I'd prefer the last one.

The timeouted version still remains questionable, though.

Thanks,
Rafael
