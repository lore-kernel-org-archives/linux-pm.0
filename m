From: Li Yang <leoli@freescale.com>
Subject: Re: System suspend states and device driver suspend() callback
Date: Mon, 26 Aug 2013 16:50:53 +0800
Message-ID: <CADRPPNRyJW8N0NCpi0C0dpx5QudLu5V_BeT+XW=mjaa4HnU6Lg@mail.gmail.com>
References: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
	<17024788.0xFN8jEV59@vostro.rjw.lan>
	<02318724-F4F7-4D53-9926-872E9417F672@freescale.com>
	<35306580.ZCUI1aZasW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35306580.ZCUI1aZasW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Li Yang-R58472 <r58472@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 17, 2013 at 7:53 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, August 16, 2013 05:13:42 PM Li Yang-R58472 wrote:
>>
>> =E5=9C=A8 2013-8-16=EF=BC=8C=E4=B8=8B=E5=8D=887:22=EF=BC=8C"Rafael J=
=2E Wysocki" <rjw@sisk.pl> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> > On Friday, August 16, 2013 04:06:26 PM Li Yang wrote:
>> >> Hi Guys,
>> >>
>> >> Is there a standard way for the device drivers to know if the sys=
tem
>> >> is going to =E2=80=9Cstandby=E2=80=9D mode or =E2=80=9Cmem=E2=80=9D=
 mode when the suspend() callbacks
>> >> are called?
>> >
>> > No, there's none.
>> >
>> > What do you need that for?
>>
>> Some chips like ours are putting the on-chip devices into different =
low
>> power states when entering different system low power states.  When =
we enter
>> system standby, on-chip devices are clock gated.  While entering sus=
pend to
>> ram, on-chip devices are power gated.  We want to driver to act diff=
erently
>> too when entering different suspend states.
>
> Can you possibly use platform suspend operations to implement that (i=
n analogy
> with ACPI suspend operations)?

I agree it's best to get the state that the device will be in during
suspend from the platform code.  Will it be better to have a standard
interface to pass this information?  Given the fact that a single
device can be used by different platforms even different architecture
nowadays.  How about exposing some new callbacks from the
platform_suspend_ops for the driver to use?

Regards,
Leo
