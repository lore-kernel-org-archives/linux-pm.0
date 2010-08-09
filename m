From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 8 Aug 2010 22:29:48 -0700
Message-ID: <AANLkTimncsuARHeavMCHL4imEOVXMomTJoDQns4-wq5o__27717.1227302917$1281331842$gmane$org@mail.gmail.com>
References: <AANLkTinQD3ggLFVd2KvX95U2B_j=ZJquZgiBGieukJ+r@mail.gmail.com>
	<AANLkTinebiC=9Xd-D_sOwmvA8w_YPWMdhTYz2NRbZ7jH@mail.gmail.com>
	<AANLkTim-a6qHL_Xo+iVUW4p79EMMRssa0-AqZenNSYJr@mail.gmail.com>
	<201008082117.39082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008082117.39082.rjw@sisk.pl>
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
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/8/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/8/7 Arve Hj=F8nnev=E5g <arve@android.com>:
>> > 2010/8/7 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> On Saturday, August 07, 2010, Arve Hj=F8nnev=E5g wrote:
>> >>> 2010/8/6 Alan Stern <stern@rowland.harvard.edu>:
>> >>> > On Thu, 5 Aug 2010, Arve Hj=F8nnev=E5g wrote:
>> ...
>> >>> >> total_time, total time the wake lock has been active. This one sh=
ould
>> >>> >> be obvious.
>> >>> >
>> >>> > Also easily added.
>> >>> >
>> >>> Only with a handle passed to all the calls.
>> >>
>> >> Well, I'm kind of tired of this "my solution is the only acceptable o=
ne"
>> >> mindset. =A0IMHO, it's totally counter productive.
>> >>
>> >
>> > How do you propose to track how long a driver has blocked suspend when
>> > you have an unblock call that takes no arguments.
>> >
>>
>> Also, I did not not see a response to my question about why you don't
>> want to pass a handle.
>
> It doesn't really matter what I personally want. =A0In fact, I'm not tota=
lly
> opposed to that idea, although there are disadvantages (eg. a "handle"
> would really mean a pointer to an object with certain life cycle that nee=
ds to
> be managed by the caller and it's not that clear to me who should manage =
the
> objects that the PCI wakeup code would pass to pm_wakeup_event(), for one

Wouldn't a single global handle work for the way you are handling pci
wakeup events? It looked like you just reset a global timeout every
time a pci wakeup event occurs.

> example). =A0I sent a pull request for your original patchset to Linus af=
ter all. :-)
>
> I said I didn't think "it would fly", meaning that I was afraid the other=
 kernel
> developers wouldn't like that change.
>
> The reason why I think so is that you'd like to add a whole new infrastru=
cture
> whose only purpose would be debugging that would only be useful to systems
> using opportunistic suspend. =A0That, however, is only Android right now =
and it
> cannot use the mainline kernel for other reasons, so basically we would a=
dd
> infrastructure that's useful to no one.
>

I'm not sure what you mean by this. The debugging is useful for anyone
using the api, not just Android, and a handle is also needed to mix
timeouts and pm_relax. The handle can be the device, but some drivers
need several handles per device.

-- =

Arve Hj=F8nnev=E5g
