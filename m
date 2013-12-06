From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Fri, 06 Dec 2013 10:53:16 +0530
Message-ID: <52A15F44.1030807@linux.vnet.ibm.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <878uvzyecg.fsf@nemi.mork.no> <52A0746F.9010705@linux.vnet.ibm.com> <1505413.a13oF758Fd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1505413.a13oF758Fd@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/06/2013 03:59 AM, Rafael J. Wysocki wrote:
> On Thursday, December 05, 2013 06:11:19 PM Srivatsa S. Bhat wrote:
>> On 12/05/2013 12:27 PM, Bj=C3=B8rn Mork wrote:
>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>>
>>>> Sending from phone.. html.. so left list.
>>>>
>>>> Here is the old thread where we discussed this.. see if this helps=
=2E.
>>>>
>>>> http://marc.info/?t=3D136845016900003&r=3D1&w=3D2
>>>
>>> Thanks.  That helped a lot.
>>>
>>> Unless I miss something, it looks like the permission problem *star=
ted*
>>> with fallout from special suspend code - surprising the user by not
>>> creating any offline/online event on suspend/resume.  Quoting from
>>> http://marc.info/?l=3Dlinux-pm&m=3D136847781510358 :
>>>
>>>   (And yes, even code-wise, we use a slightly different
>>>    path in the S3 code, to initiate hotplug. That's why the uevents
>>>    are by-passed.)
>>>
>>
>> I hope you didn't miss the main idea I was trying to convey in that
>> reply:=20
>> "IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is
>> supposed to be totally internal to the suspend/resume code. It is no=
t
>> intended for userspace to know that we are internally offlining/
>> onlining CPUs."
>=20
> By the way, in the meantime I discussed this with Viresh in the conte=
xt of
> a different (although related) fix and I suggested a different approa=
ch.
>=20
> Namely, to split the CPU offline/online code into "core" and "add-ons=
"
> parts, where the core part will do just whatever is needed to offline=
/online
> CPU cores cleanly and the "add-ons" part will carry out the rest (e.g=
=2E
> removal/addition of sysfs attributes and so on).
>=20
> Then, the system suspend/resume code path will only run the "core" pa=
rt
> and whatever else CPU handling is needed during suspend/resume will b=
e
> carried out by the device suspend/resume code (via driver callbacks o=
r
> stuff similar to cpufreq_suspend() and cpufreq_resume() recently prop=
osed
> by Viresh).
>=20
> In turn, the "runtime" CPU offline/online will carry out both the cor=
e
> and the add-ons parts as it does today.
>=20
> In my view this should address the problems we have with sysfs attrib=
utes,
> governors start/stop etc. during system suspend/resume.
>=20

Hmm, yes that sounds like a good idea. Are you suggesting this "core" a=
nd
"add-on" split only for the cpufreq parts of CPU hotplug or for everyth=
ing
involved in CPU hotplug code? IIUC you are suggesting the latter, which=
 is
likely to be a significant undertaking, but very well worth it in the l=
ong
run, since it gives us an elegant solution for all these problems.

I guess the *_FROZEN CPU hotplug notifications were originally introduc=
ed
to provide us an infrastructure to do something like this, but obviousl=
y
that hasn't worked out very well. So I agree that a fundamental restruc=
turing
is in order, to cure all the innumerable problems.

Regards,
Srivatsa S. Bhat

