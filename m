From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v3 2/3] PM / DEVFREQ: add example governors
Date: Mon, 4 Jul 2011 17:58:27 +0900
Message-ID: <CAJ0PZbQ0ENk-vEebqiD=DGHZVtswHQkPre8wUqM2vwR_r+V=Uw__48757.9854591333$1309770421$gmane$org@mail.gmail.com>
References: <1306471995-4048-1-git-send-email-myungjoo.ham@samsung.com>
	<201107022358.58319.rjw@sisk.pl>
	<CAJ0PZbQuiwkW-Z+1Wrqmr3r_U+LdWS312RggkkjFBGFHES4wCw@mail.gmail.com>
	<201107041043.25150.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107041043.25150.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 4, 2011 at 5:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, July 04, 2011, MyungJoo Ham wrote:
>> Hello,
>>
>> 2011/7/3 Rafael J. Wysocki <rjw@sisk.pl>:
>> > Hi,
>> >
>> > On Friday, May 27, 2011, MyungJoo Ham wrote:
>> >> Three CPUFREQ-like governors are provided as examples.
>> >>
>> >> powersave: use the lowest frequency possible. The user (device) should
>> >> set the polling_ms as 0 because polling is useless for this governor.
>> >>
>> >> performance: use the highest freqeuncy possible. The user (device)
>> >> should set the polling_ms as 0 because polling is useless for this
>> >> governor.
>> >>
>> >> simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.
>> >>
>> >> When a user updates OPP entries (enable/disable/add), OPP framework
>> >> automatically notifies DEVFREQ to update operating frequency
>> >> accordingly. Thus, DEVFREQ users (device drivers) do not need to upda=
te
>> >> DEVFREQ manually with OPP entry updates or set polling_ms for powersa=
ve
>> >> , performance, or any other "static" governors.
>> >>
>> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> []
>> >> +
>> >> + =A0 =A0 /* Set the desired frequency based on the load */
>> >> + =A0 =A0 a =3D (unsigned long long) stat.busy_time * stat.current_fr=
equency;
>> >
>> > What's the purpose of the conversion?
>>
>> Assuming that the work speed of a device is proportional to its
>> frequency, it measures the amount of work done.
>> It's time * work/time. For example, during the last 10 second, if the
>> busy_time was 5 sec and frequency was 10MHz,
>> it's "50M", which is same as 20MHz and 2.5 sec.
>
> I understand that, but my question was why you're doing a forced conversi=
on
> to (unsigned long long).

Ah.. that was for the 64bit operations.

Both busy_time and current_frequency are 32bit and current_frequency
may be a big number.

Thus, in order to get "freq" value without losing bits (e.g., if
current_frequency =3D 1GHz and busy_time =3D 8000, we get an overflow
without 64bit operations), I've inserted 64bit operations with the
conversion. For the cosmetic reasons, it appears that "u64" looks
better though.

>
> Thanks,
> Rafael
>

Thank you.

- MyungJoo


-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
