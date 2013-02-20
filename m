From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/16] blackfin idle: delete pm_idle
Date: Wed, 20 Feb 2013 21:21:16 +0100
Message-ID: <5125303C.3080507@metafoo.de>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <1656351.lki82jZfSs@vostro.rjw.lan> <512529C2.4050909@metafoo.de> <1759773.UdmLmFNAfS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1759773.UdmLmFNAfS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-pm@vger.kernel.org

On 02/20/2013 08:59 PM, Rafael J. Wysocki wrote:
> On Wednesday, February 20, 2013 08:53:38 PM Lars-Peter Clausen wrote:
>> On 02/20/2013 08:52 PM, Rafael J. Wysocki wrote:
>>> On Monday, February 18, 2013 05:28:19 PM Lars-Peter Clausen wrote:
>>>> On 02/10/2013 06:58 AM, Len Brown wrote:
>>>>> From: Len Brown <len.brown@intel.com>
>>>>>
>>>>> pm_idle is dead code on blackfin.
>>>>>
>>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>>> Cc: uclinux-dist-devel@blackfin.uclinux.org
>>>>> ---
>>>>>  arch/blackfin/kernel/process.c | 7 -------
>>>>>  1 file changed, 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kerne=
l/process.c
>>>>> index 3e16ad9..8061426 100644
>>>>> --- a/arch/blackfin/kernel/process.c
>>>>> +++ b/arch/blackfin/kernel/process.c
>>>>> @@ -39,12 +39,6 @@ int nr_l1stack_tasks;
>>>>>  void *l1_stack_base;
>>>>>  unsigned long l1_stack_len;
>>>>> =20
>>>>> -/*
>>>>> - * Powermanagement idle function, if any..
>>>>> - */
>>>>> -void (*pm_idle)(void) =3D NULL;
>>>>> -EXPORT_SYMBOL(pm_idle);
>>>>> -
>>>>>  void (*pm_power_off)(void) =3D NULL;
>>>>>  EXPORT_SYMBOL(pm_power_off);
>>>>> =20
>>>>> @@ -81,7 +75,6 @@ void cpu_idle(void)
>>>>>  {
>>>>>  	/* endless idle loop with no priority at all */
>>>>>  	while (1) {
>>>>> -		void (*idle)(void) =3D pm_idle;
>>>>
>>>> Hi,
>>>>
>>>> This results in the following error:
>>>>
>>>> arch/blackfin/kernel/process.c: In function =E2=80=98cpu_idle=E2=80=
=99:
>>>> arch/blackfin/kernel/process.c:83: error: =E2=80=98idle=E2=80=99 u=
ndeclared (first use in
>>>> this function)
>>>> arch/blackfin/kernel/process.c:83: error: (Each undeclared identif=
ier is
>>>> reported only once
>>>> arch/blackfin/kernel/process.c:83: error: for each function it app=
ears in.)
>>>> arch/blackfin/kernel/process.c:88: error: implicit declaration of =
function
>>>> =E2=80=98idle=E2=80=99
>>>>
>>>>
>>>> This change on top of your patch, fixes it.
>>>
>>> Lars, I need your sign-off for the patch below.  May I add it?
>>>
>>> Rafael
>>
>> Sure, I didn't realize the patches had already been merged, otherwis=
e I'd have
>> sent a proper patch.
>=20
> Please do now, if you can.  Sorry for the trouble.
>=20

I can send it tomorrow morning, it's on my machine at work.

- Lars
