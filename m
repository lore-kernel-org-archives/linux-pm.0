From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 3 Mar 2009 15:38:16 -0800
Message-ID: <d6200be20903031538s42c8243dk59c505857cdab7cb__42595.098357606$1236123757$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200903020017.52390.rjw@sisk.pl>
	<d6200be20903021548h11f57283t6d6a9053f3feb3fd@mail.gmail.com>
	<200903032339.02002.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903032339.02002.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 3, 2009 at 2:39 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
>> On Sun, Mar 1, 2009 at 3:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Sunday 01 March 2009, Arve Hj=F8nnev=E5g wrote:
>> >> On Sat, Feb 28, 2009 at 2:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Saturday 28 February 2009, Arve Hj=F8nnev=E5g wrote:
>> >> >> Can you summarize what the problems with my current api are? I get=
 the
>> >> >> impression that you think the overhead of using a list is too high,
>> >> >> and that timeout support should be removed because you think all
>> >> >> drivers that use it are broken.
>> >> >
>> >> > In no particular order:
>> >> > 1. One user space process can create an unlimited number of wakeloc=
ks. =A0This
>> >> > =A0 shouldn't be possible. =A0Moreover, it is not even necessary fo=
r any process
>> >> > =A0 to have more than one wakelock held at any time.
>> >>
>> >> This has been addressed. A user space process cannot create more
>> >> wakelocks than it has filedescriptors.
>> >>
>> >> > 2. Timeouts are wrong, because they don't really _solve_ any proble=
m. =A0They are
>> >> > =A0 useful for working around the fact that you can't or you don't =
want to
>> >> > =A0 modify every piece of code that in principle should take a wake=
lock and
>> >> > =A0 that's it.
>> >>
>> >> Yes, timeouts are sometimes wrong, but they are not always wrong. I
>> >> gave two examples where the use of timeouts was not incorrect.
>> >
>> > There still is a problem that the same operation can take time X on one
>> > platform and time Y on another, so how are you going to determine the =
timeouts
>> > that will be suitable for all platforms?
>>
>> This only applies to the timeouts that fall into the wrong category.
>> The timeout used when a driver returns -EBUSY is arbitrary, but any
>> value is technically correct. The one second timeout in the alarm
>> driver is not platform specific. It is one second because the
>> resolution of the rtc api is only one second.
>>
>> For the timeouts that do fall into the wrong category (use a timeout
>> when passing data to a unmodified subsystem), the drivers are mostly
>> (if not all) platform specific.
>
> What drivers are they?

Serial driver used for bluetooth, wifi driver and battery driver for
usb. The msm smd code also need a wakelock with a timeout before
passing data to the tty and network layers, but I did not find this.

>> >> > =A0However, =A0entire concept of having one code path acting on
>> >> > =A0 behalf of another one on a hunch that it might be doing somethi=
ng making
>> >> > =A0 suspend undesirable is conceptually broken IMO.
>> >>
>> >> OK. Do you have an alternative?
>> >
>> > Well, IMO every code path doing something that makes automatic suspend
>> > undesirable should use a suspend blocker of some sort. =A0I'm afraid a=
ny other
>> > approach will be unreliable and racy.
>>
>> I agree with this,
>
> Good.
>
>> but I cannot change every code path at once.
>
> That need not happen at once (eg. in one patch or something). =A0Once we'=
ve
> introduced the basics, the changes can be made gradually wherever necessa=
ry,
> step by step.

If you are OK with merging an unfinished system then this may work.

>> I also don't know if every code path can be easily fixed. Using a timeou=
t in
>> this case is a compromise. It is not as good as protecting every code
>> path, but it is much better than doing nothing. The race condition you
>> have when preventing suspend with a timeout is the same as every code
>> using a timeout. If the system is busy it can fail. The race condition
>> that you have with no protection happens with any load. If the system
>> decides to go to sleep at the same time as a wakeup event occur, the
>> system will sleep.
>
> Well, if you have strictly limited time (eg. you want to ship a product at
> specific date), you have to go for compromises like this, but we're not i=
n a
> hurry (or are we for some unspecified reason?). =A0There's no deadline et=
c., so
> we can afford to do it right from the start (which BTW is likely to save =
us
> time in future).
>
> So, I'd suggest to just separate the timeouted suspend blockers from the
> basic code and introduce the latter first.

How do you want to handle drivers that return -EBUSY from suspend. The
basic code uses a wakelock with a timeout to handle this now. Without
this we can either try suspend again immediately, or activate a
suspend blocker and use a timer to release it.

> IOW, let's first try to merge things that everybody is comfortable with a=
nd
> postpone the merging of the rest. =A0I don't think we're going to lose
> anything by doing it this way.

I think we do loose some flexibility by leaving out timeout support,
but I'll try to separate it from the first patch.

-- =

Arve Hj=F8nnev=E5g
