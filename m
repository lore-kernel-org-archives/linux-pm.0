From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: Query: When will drv->poweroff() called
Date: Thu, 16 Feb 2012 07:16:11 -0800
Message-ID: <CAOh2x=n42kU+9Yvz2-KFxAm2OFvoc427oibSh4Y7bkQxWRdy5w@mail.gmail.com>
References: <4F2F6B40.6070308@st.com>
	<201202061307.40628.rjw@sisk.pl>
	<4F30A668.8010407@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F30A668.8010407@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kucheria@linaro.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@st.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "len.brown@intel.com" <len.brown@intel.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Armando VISCONTI <armando.visconti@st.com>, Mirko GARDI <mirko.gardi@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, "pavel@ucw.cz" <pavel@ucw.cz>, Deepak SIKRI <deepak.sikri@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>
List-Id: linux-pm@vger.kernel.org

[Sorry for mailing again, earlier mail bounced on linux-pm list,
as i wasn't subscribed to it]

Hi Amit,

Can you please clear my doubt regarding calling of
hibernation_set_ops() for ARM SoC's?

--
viresh

On Mon, Feb 6, 2012 at 8:19 PM, Viresh Kumar <viresh.kumar@st.com> wrot=
e:
> On 2/6/2012 5:37 PM, Rafael J. Wysocki wrote:
>> On Monday, February 06, 2012, Viresh Kumar wrote:
>>> >
>>> > Hi Guys,
>>> >
>>> > Sorry for asking this silly question, but i couldn't locate much
>>> > help for it in documentation, so asking it.
>>> >
>>> > We were testing hibernation for SPEAr13xx SoC family, based on
>>> > ARM Cortex a9.
>>> >
>>> > I observed that poweroff() callback of individual drivers are not
>>> > getting called at all, while we test hibernate.
>> They should be called in the last phase of hibernation, after the im=
age
>> has been created and the system is going for "power off" (hance the
>> callback name).
>>
>>> > I tried to go through the code to see what happened. It looked li=
ke
>>> > there should be call to hibernation_set_ops() for platforms that =
are
>>> > willing to get a call to poweroff() for their drivers.
>> That's correct. =C2=A0The ->poweroff() callbacks are only executed i=
f
>> hibernation_mode is equal to HIBERNATION_PLATFORM, which is not the
>> default.
>>
>>> > Otherwise shutdown of the busses gets called, which is a complete=
ly
>>> > different path.
>>> >
>>> > There are many drivers today, that are registering poweroff() fro=
m dev_pm_ops
>>> > but are not doing bus specific shutdown stuff.
>>> >
>>> > Even i tried to look for hibernation_set_ops() in kernel, and onl=
y acpi
>>> > code is calling it.
>> That's correct too.
>>
>>> > I didn't understood how other ARM Sub-Arch's are handling this.
>> Well, they are supposed to call hibernation_set_ops() and set the op=
erations
>> appropriately. =C2=A0Those operations may be empty routines if they =
don't need
>> to do anything, but they have to be defined.
>
> Hi Amit,
>
> Can you give some input on why none of the ARM platforms are calling
> this routine currently.
