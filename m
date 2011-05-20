From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v2 1/3] PM: Introduce DEVFREQ: generic DVFS
 framework with device-specific OPPs
Date: Fri, 20 May 2011 14:36:43 +0900
Message-ID: <BANLkTi=Bf0A14iDEyYBtJNOYnSuUjmsFyw__42360.2543226027$1305869871$gmane$org@mail.gmail.com>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<201105180036.03836.rjw@sisk.pl>
	<BANLkTi=_1DJPS+6goLA-UvdHJXEoPWBF2w@mail.gmail.com>
	<201105182202.46820.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105182202.46820.rjw@sisk.pl>
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

Hello,

On Thu, May 19, 2011 at 5:02 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, May 18, 2011, MyungJoo Ham wrote:
>> 2011/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
>> > Hi,
>
> Hi,
>
> ...
[]
>>
>> Umm... yeah.. that option (calling devfreq_remove_device() for errors)
>> is also possible, which will also remove the need for the macro you've
>> mentioned.
>
> Yes.
>
>> However, when the error is temporary or the device has blocked
>> changing frequencies temporarily from target callback or governor, it
>> could be not so desirable.
>
> I guess we need some experience here. =A0Namely, it's difficult to say
> what's going to be more frequent, devices that have temporary failures
> or such that either work or not work at all.
>
> That said, I think the simpler approach is to drop devices from the list
> on errors (perhaps depending on the type of the error).
>
>> So, I'm considering to call devfreq_remove_device() at error if the
>> error is not "EAGAIN". That will also remove the need for the macro
>> and debug messages above. How about that?
>
> Sounds reasonable.

Alright, I'll try this in the next revision.

>
> ...
>> >> @@ -225,3 +225,28 @@ config PM_OPP
>> >> =A0 =A0 =A0 =A0 representing individual voltage domains and provides =
SOC
>> >> =A0 =A0 =A0 =A0 implementations a ready to use framework to manage OP=
Ps.
>> >> =A0 =A0 =A0 =A0 For more information, read <file:Documentation/power/=
opp.txt>
>> >> +
>> >> +config PM_DEVFREQ
>> >> + =A0 =A0 bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) =
Framework"
>> >> + =A0 =A0 depends on PM_OPP
>> >
>> > This assumes the user will know if his/her platform uses that code.
>> > It may be a good idea to make it depend on a user-invisible option that
>> > can be selected by the platform.
>>
>> I think that like CPUFREQ, users will want to enable and disable
>> DEVFREQ feature by choice although they cannot choose the governor
>> directly. I'm also considering to allow users to set governors
>> forcibly and globally at menuconfig (like CPUFREQ does). With CPUFREQ,
>> such options helped a lot in troubleshooting of CPU related issues.
>>
>> Do you think it'd be better to have DEVFREQ enabled unconditionally
>> (if PM_OPP is available) nonetheless?
>
> First off, it doesn't make sense to enable it if the platform is not goin=
g to
> use it. =A0That's why I think it should depend on a platform-selected opt=
ion.
> Only if that option is set the user should be given the choice to select
> DEVFREQ.
>
> Second, I'm not sure if that's a good idea to force DEVFREQ is the platfo=
rm
> is going to use it. =A0Perhaps in the future if there are no major issues=
 with
> it, we can do that.
>
> Thanks,
> Rafael
>

I see.

I'll open an option to enable/diable DEVFREQ and will make it depends
on OPP and add platform-selected option like OPP does.


Thank you.


Cheers! It's Friday :)
- MyungJoo

-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
