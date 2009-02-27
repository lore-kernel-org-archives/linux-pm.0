From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 28 Feb 2009 00:44:59 +0100
Message-ID: <20090227234458.GB2089__23895.5716872171$1235778353$gmane$org@elf.ucw.cz>
References: <200902192215.18365.rjw@sisk.pl> <200902271522.41915.rjw@sisk.pl>
	<20090227204053.GB1387@ucw.cz> <200902272155.42010.rjw@sisk.pl>
	<d6200be20902271456w77951afata1d5f378ddbe6b84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902271456w77951afata1d5f378ddbe6b84@mail.gmail.com>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> > > Wakelocks done right are single atomic_t... and if you set it to 0,
> >> > > you just unblock "sleeper" thread or something. Zero polling and v=
ery
> >> > > simple...
> >> >
> >> > Except that you have to check all of the wakelocks periodically in a=
 loop =3D>
> >> > polling. =A0So?
> >>
> >> No. I want to have single atomic_t for all the wakelocks... at least
> >> in non-debug version. Debug version will be slower. I believe you
> >> originally suggested that.
> >
> > I did, but please don't call it "wakelocks". =A0It's confusing.
> =

> What you are talking about here is mostly an optimization of the
> wakelock api. You have removed timeout support and made each wakelock
> reference counted. If you ignore wakelocks with timeouts, the current
> wakelock interface can be implemented with a global atomic_t to
> prevent suspend, and a per wakelock atomic_t to prevent a single
> client from changing the global reference count by more than one.

Actually I'd go to global atomic_t to prevent suspend, and make sure
single client only changes it once by design.

> There are a couple of reasons that I have not done this. It removes
> the ability to easily inspect the system when it is not suspending. I
> do provide an option to turn off the wakelock stats, which makes
> wake_lock/unlock significantly faster, but we never run with wakelock
> stats off.

It seems wrong to design for the "debugging" case. ... even if you run
with debugging enabled.

> Also, it pushes timeout handling to the drivers. I know
> may
> of you don't like timeout support, but ignoring the problem is not a
> solution. If each driver that needs timeouts uses its own timer, then
> you will often wakeup from idle just to unlock a wakelock that will
> not trigger suspend. This wakeup is a thousand times as costly on the
> msm platform as a wakelock/unlock pair (with wakelock stats
> enabled).

Well, you are free to have a library (or something) those broken
drivers can use. But you have to understand that those drivers are
broken... and please don't make it part of core API.

It should also make the merging easier; merge non-contraversial parts
first (single atomic_t), then add debugging infrastructure, then maybe
add timeout handling if those drivers can really not be fixed in a
nicer way...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
