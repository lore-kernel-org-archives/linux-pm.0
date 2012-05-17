From: Sundar <sunder.svit@gmail.com>
Subject: Re: Plumbers: PM constraints micro-conf RFP
Date: Thu, 17 May 2012 16:47:48 +0530
Message-ID: <CAMHCuPX_=Vi6mQ0XdyNvca-dq+r8bFok=SQoZkK17GvOrERR+w@mail.gmail.com>
References: <20120502143607.GA21640@G62>
	<CAGF5oy8E26sYHi13ayrrOY5qbXepz1U8ErEfF-Ata9k6Zyzz+Q@mail.gmail.com>
	<CAORVsuU3YDGq713jtmPCpJT=3eXqrvx_qU=uPK86XvDdzHSGtg@mail.gmail.com>
	<4FB13CD3.8000505@ti.com>
	<CAGF5oy-xduO-BjM1NcNvJG1LV1d-1h78v6mdpq5noRFMsxmjkg@mail.gmail.com>
	<CAGF5oy9kKPW5BF9FPXXm8-=9O5AM+NhKxjOysJbDiwDF=RvpKw@mail.gmail.com>
	<CAORVsuV7PrJb4v-7G_JJJMy-fAAFdU-R-JWfwQoRzgtSg-m_KQ@mail.gmail.com>
	<CAP245DUhJ+Y9tKV=JNqdPHEvAe9fZ013ee9NKMkKQQcOs3M15A@mail.gmail.com>
	<20120516001335.GB4260@G62>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120516001335.GB4260@G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: Kevin Hilman <khilman@ti.com>, "Agarwal, Ramesh" <ramesh.agarwal@intel.com>, paulmck@vnet.ibm.com, pdeschrijver@nvidia.com, Praveen Chidambaram <pchidamb@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, John Stultz <john.stultz@linaro.org>, linux-pm@lists.linux-foundation.org, amiettinen@nvidia.com
List-Id: linux-pm@vger.kernel.org

I put in a rough draft @
https://blueprints.launchpad.net/lpc/+spec/lpc2012-power-management-constra=
ints

Cheers!

On Wed, May 16, 2012 at 5:43 AM, mark gross <markgross@thegnar.org> wrote:
> On Tue, May 15, 2012 at 03:58:59PM +0300, Amit Kucheria wrote:
>> On Tue, May 15, 2012 at 12:40 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
>> > Hi!
>> >
>> > Here is my proposal for the PM constraints micro-conf RFP, as e-mailed=
 today:
>> >
>> > Session title: A New Model for the System and Devices Latency
>> >
>> > Name of microconference (if applicable): PM constraints micro-conf,
>> > led by Mark Gross
>> >
>> > Abstract:
>> > =A0Due to the nature of the new SoC architectures the Power Management
>> > needs a new model for the various system latencies. The talk presents:
>> > =A0. the concepts of system, devices, wake-up and resume latencies,
>> > =A0. the recent changes in the devices framework for the latency, why
>> > and how to make it generic,
>> > =A0. the link with the other PM QoS frameworks: thermal, cpuidle,
>>
>> Jean,
>>
>> Do you already consider GPU drivers, backlight drivers and battery
>> charging for setting constraints (performance and thermal) ?
>>
>> Between your, Eduardo's and Antti's proposals, a lot of ground is
>> being covered and I don't want to make a new proposal just for these
>> three. But we're keen on helping consolidate on generic interfaces to
>> deal with these three kinds of devices.
>
> It will be great to have you there in any case.
>
> It feels like we have enough content to come up with portable
> requirements and maybe an ok design that can work for multiple SoC's.
>
> --mark
>
>> > =A0. the recent changes in the ARM/OMAP platform code for the system l=
atency,
>> > =A0. the problems encountered while modelling and measuring the
>> > various latencies,
>> >
>> > =A0. a proposal on the model and on the way to implement it,
>> > =A0. the planned changes in the device framework, the platform code
>> > and the APIs.
>> >
>> > =A0This talk is oriented towards Linux power management developers. The
>> > goal is to agree on a framework implementation and the interfaces
>> > within the kernel and with the user space.
>> >
>> > Experience:
>> > Jean Pihet, NewOldBits.com
>> >
>> > Jean Pihet is working with embedded Linux since many years now, for
>> > companies like Texas Instruments, MontaVista, Motorola and Philips.
>> > Recently NewOldBits.com has been founded to provide high quality
>> > consulting services. The area of work is mainly OMAP Power Management,
>> > tracing and profiling tools (perf, ftrace, oprofile...) for recent ARM
>> > cores.
>> >
>> > Kind regards,
>> > Jean
>> >
>> > On Tue, May 15, 2012 at 7:34 AM, Valentin, Eduardo
>> > <eduardo.valentin@ti.com> wrote:
>> >> FYI,
>> >>
>> >> I will submit later today, something like this:
>> >> "
>> >> Abstract
>> >>
>> >> The thermal challenge is to design an end-product with high
>> >> performance while keeping the junction temperature of the IC
>> >> components used on this product within their limitations and which
>> >> does not present a thermal discomfort for the user. OMAP4/OMAP5 System
>> >> on Chips, operating at highest Operating Performance Points (OPP), is
>> >> a powerful mobile applications processor. However operating at higher
>> >> voltage and higher frequency in a sustained manner may cause thermal
>> >> limits to be exceeded, both for silicon and user comfort. We propose a
>> >> new framework to model per device power constraints, for containment
>> >> of thermal limitations across major heat sources of a end-product
>> >> device, e.g. LCD, CPU, charging, etc. The framework shall facilitate
>> >> the power and thermal management performed by governor and policies,
>> >> depending on device context and use case knowledge.
>> >>
>> >> Authors
>> >>
>> >> Eduardo Valentin, System Software Engineer at Texas Instruments,
>> >> working on OMAP Linux kernel, previously a working on power management
>> >> in maemo for Nokia.
>> >>
>> >>
>> >> On Tue, May 15, 2012 at 8:06 AM, Valentin, Eduardo
>> >> <eduardo.valentin@ti.com> wrote:
>> >>> Benoit,
>> >>>
>> >>> On Mon, May 14, 2012 at 8:11 PM, Cousson, Benoit <b-cousson@ti.com> =
wrote:
>> >>>> Hi Jean,
>> >>>>
>> >>>>
>> >>>> On 5/14/2012 2:45 PM, Jean Pihet wrote:
>> >>>>>
>> >>>>> Hi Benoit,
>> >>>>>
>> >>>>> On Fri, May 11, 2012 at 9:17 AM, Valentin, Eduardo
>> >>>>> <eduardo.valentin@ti.com> =A0wrote:
>> >>>>>>
>> >>>>>> Hello Mark,
>> >>>>>>
>> >>>>>> On Wed, May 2, 2012 at 5:36 PM, mark gross<markgross@thegnar.org>=
 =A0wrote:
>> >>>>>>>
>> >>>>>>> This is a Request For Participation in a micro-conference at thi=
s years
>> >>>>>>> Linux plumbers event. =A0For this micro conference to happen we =
need to
>> >>>>>>> reach a certain critical mass WRT participants as measured by su=
bmitted
>> >>>>>>> talks associated to Power Management Constraints.
>> >>>>>>
>> >>>>>>
>> >>>>>> Nice! Thanks for proposing this.
>> >>>>>>
>> >>>>>>>
>> >>>>>>> The To: list is populated with folks that I've had interactions =
with
>> >>>>>>> over extending pm-qos or constraint based PM over the past year.
>> >>>>>>>
>> >>>>>>> If you are working on problems related to constraining the power=
 /
>> >>>>>>> performance of devices I am inviting your participation and requ=
est you
>> >>>>>>> submit a proposal for presenting your problem space (preferred) =
and or
>> >>>>>>> solution to a group of developers looking for a good solution to=
 push
>> >>>>>>> upstream. =A0The talks will be about 20 min long as I want to ge=
t into
>> >>>>>>> some design and implementation discussions after the requirements
>> >>>>>>> definition is mostly finished.
>> >>>>>
>> >>>>> Is it OK to submit a talk for the next LPC? The deadline is tomorr=
ow IIRC.
>> >>>>
>> >>>>
>> >>>> Yes, it is. Go ahead. It is related to Mark's proposal? Because it =
seems we
>> >>>> have to do some homework in order to participate to the micro-conf =
:-(.
>> >>>
>> >>> Yes, the homework is required in order to drive the discussion based
>> >>> on existing usable solutions..
>> >>>
>> >>> Jean, I'll write down a proposal today, from thermal requirements
>> >>> perspective. But we can discuss also a way to converge either in a
>> >>> common presentation or in even with two presentations but with strong
>> >>> linking together.
>> >>>
>> >>> Just trying to avoid two conflicting proposals from two peers @ti.com
>> >>>
>> >>>>
>> >>>> Regards,
>> >>>> Benoit
>> >>>>
>> >>>>
>> >>>>>
>> >>>>> Regards,
>> >>>>> Jean
>> >>>>>
>> >>>>>>>
>> >>>>>>> I am interested in gathering user mode interface needs as well a=
s kernel
>> >>>>>>> mode.
>> >>>>>>>
>> >>>>>>> =A0From a high level pm-constraints is a generalization of pm-qo=
s to
>> >>>>>>> include
>> >>>>>>> limiting performance as well as its current limiting of device
>> >>>>>>> throttling.
>> >>>>>>>
>> >>>>>>> As performance limiting is typically used for any of the followi=
ng:
>> >>>>>>> 1) staying within thermal operational envelopes
>> >>>>>>> 2) avoiding peak current
>> >>>>>>> 3) extending battery life in active use cases
>> >>>>>>>
>> >>>>>>> I invite anyone working in any of these areas or pm-qos applicat=
ions to
>> >>>>>>> participate in this micro-conference.
>> >>>>>>>
>> >>>>>>> I will organize the micro-conference into 2 parts:
>> >>>>>>> 1) problem statements with specific participant examples where
>> >>>>>>> constraining the performance or throttling is needed.
>> >>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> I could bring something on the use cases where this type of
>> >>>>>> constraining could be used. Essentially major focus gets partitio=
ned
>> >>>>>> in two areas: For device skin/case temperature management, and IC=
's
>> >>>>>> junction temperature management.
>> >>>>>>
>> >>>>>> I am currently checking the traveling arrangements as well. And
>> >>>>>> confirming soon.
>> >>>>>>
>> >>>>>>
>> >>>>>>>
>> >>>>>>> 2) high level design brain storming.
>> >>>>>>>
>> >>>>>>> If the micro-conference happens (i.e. critical mass is reached) =
any
>> >>>>>>> interested linux-plumbers attendees is very welcome to participa=
te.
>> >>>>>>>
>> >>>>>>> Please send me an off list email if you want me to add you to my=
 mutt
>> >>>>>>> alias of interested parties I'll use to cc people on emails. =A0=
Note: must
>> >>>>>>> of the correspondence will cc linux-pm too.
>> >>>>>>>
>> >>>>>>> Please submit a proposal if you are interested in participating =
in this
>> >>>>>>> with me. =A0I know a number of people are working in this space =
for the
>> >>>>>>> past few years now. =A0I think its a good time to compare notes =
and at
>> >>>>>>> least consolidate requirements and use cases. =A0Perhaps we'll e=
ven come
>> >>>>>>> up
>> >>>>>>> with a good design to implement in the process.
>> >>>>>>>
>> >>>>>>> thanks,
>> >>>>>>> --mark
>> >>>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> All best,
>> >>>>>> --
>> >>>>>>
>> >>>>>> Eduardo Valentin
>> >>>>>> _______________________________________________
>> >>>>>> linux-pm mailing list
>> >>>>>> linux-pm@lists.linux-foundation.org
>> >>>>>> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>> >>>>
>> >>>>
>> >>>
>> >>>
>> >>>
>> >>> --
>> >>>
>> >>> Eduardo Valentin
>> >>
>> >>
>> >>
>> >> --
>> >>
>> >> Eduardo Valentin
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm



-- =

---------
The views expressed in this email are personal and do not necessarily
echo my employers.
