From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Thu, 04 Jul 2013 12:38:19 +0530
Message-ID: <51D51F63.8080905@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de>	<8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com>	<51D06556.7080204@gmx.de> <51D47FB0.5090604@gmx.de>	<51D51C63.2080702@linux.vnet.ibm.com> <CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomfM55cRfLOohpv4nhLBcwVcD-y3-WcYOaznVhA6H2TAw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/04/2013 12:31 PM, Viresh Kumar wrote:
> On 4 July 2013 12:25, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.=
com> wrote:
>> On 07/04/2013 01:16 AM, Toralf F=F6rster wrote:
>>> On 06/30/2013 07:05 PM, Toralf F=F6rster wrote:
>>>> On 06/30/2013 06:33 PM, Srivatsa S. Bhat wrote:
>>>>> Toralf, can you please
>>>>> try out the below patch and see if it improves anything? (Don't r=
evert anything,
>>>>> just apply the below diff on a problematic kernel and see if it s=
olves your
>>>>> issue).
>>>>
>>>> applied on top of a66b2e5 - issue went away (either fixed or hidde=
n now)
>>>>
>>>> Thx
>>>>
>>> But if I do apply that patch on top of kernel 3.10 then it has no e=
ffect
>>> - 3.10 shows the same issue.
>>>
>>
>> Weird. So I think something *else* got broken by some other patch, _=
after_
>> a66b2e5. Viresh, do you have any suspect commits in mind?
>=20
> If I was God I could have. But as I am a poor human being I
> need more details (preferably with git bisect) :)
>=20

Haha :)

Coming to git bisect, I think it needs to be done between a66b2e5 + thi=
s-patch
and 3.10 + this-patch, to ensure that we look for problematic commits i=
n-between
a66b2e5 and 3.10 (to avoid the bisect result ending up at a66b2e5 again=
).

Regards,
Srivatsa S. Bhat

