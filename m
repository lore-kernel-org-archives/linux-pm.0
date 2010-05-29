From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 17:43:12 -0700
Message-ID: <AANLkTikEtlbkT4Ws3H2YGt_9QC46B5dr-b1oxJOcG4GN__23538.2438092076$1275093841$gmane$org@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<1275030704.32462.11.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275030704.32462.11.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 12:11 AM, Peter Zijlstra <peterz@infradead.org> wro=
te:
> On Fri, 2010-05-28 at 00:31 -0400, tytso@mit.edu wrote:
>> Keep in mind, though, that a solution which is acceptable for Android
>> has to include making sure that crappy applications don't cause the
>> battery to get drained. =A0There seem to be some people who seem
>> adamently against this requirement.
>
> Again, Alan, Thomas and myself don't argue against that, what we do
> however argue against is suspend running apps as a form of power
> management.
>

You seem to argue that android is not allowed to use suspend because
the hardware we have shipped on can enter the same power state from
idle. From my point of view, since we need to support suspend on some
hardware we should be allowed to leverage this solution on the better
hardware platforms as well if it improves our battery life.

> If you were to read Alan's latest posts he clearly outlines how you can
> contain crappy apps.
>

I have not seen any suggestions for how to deal with all our
interprocess dependencies when pausing a subset of processes. Without
a solution to that we can only pause a subset of the processes we want
to pause.

> A combination of weakening QoS guarantees (delaying wakeups etc.)
> blocking on resources (delay servicing requests) and monitoring resource
> usage (despite all that its still not idle) and taking affirmative
> action (shoot it in the head).
>
> If we pose that a well behaved application is one that listens to the
> environment hints and idles when told to, we can let regular power
> management kick in and let deep idle states do their thing.
>
> If a bad application ignores those hints and manages to avoid getting
> blocked on denied resources, we can easily spot it and promote an
> attitude of violence toward it in the form of SIGXCPU, SIGSTOP, SIGTERM
> and SIGKILL, possibly coupled with a pop-up dialog -- much like we get
> today when we try to close a window and the app isn't responding.
>
> If we then also let the environment maintain a shitlist of crappy apps
> (those it had to take affirmative action against) and maybe set up a
> service that allows people to share their results, it provides an
> incentive to the app developers to fix their thing.
>
> How is this not working?
>

These solutions do not allow us to use suspend. They may get us closer
to the power consumption we get from suspend on the good hardware or
even surpass it, but we still need suspend on some hardware, and we
would get event better results by using these solutions in addition to
suspend compared to using them instead of suspend.

-- =

Arve Hj=F8nnev=E5g
