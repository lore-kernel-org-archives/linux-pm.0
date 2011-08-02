From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/13] OMAP PM: early init of the pwrdms
	states
Date: Tue, 2 Aug 2011 10:57:31 +0200
Message-ID: <CAORVsuVHAvQRxPz8cCfQ0L1jN1nT5aNDVZ7fpuajAUosyvumeA__17434.7461354502$1312275522$gmane$org@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-8-git-send-email-j-pihet@ti.com>
	<20110729080820.GB26959@google.com>
	<CAORVsuUovg7px5SGC+mt7CoDcXZ8r2d09obkXqSp=g44U1G9EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuUovg7px5SGC+mt7CoDcXZ8r2d09obkXqSp=g44U1G9EQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Todd,

On Fri, Jul 29, 2011 at 10:50 AM, Jean Pihet <jean.pihet@newoldbits.com> wr=
ote:
> On Fri, Jul 29, 2011 at 10:08 AM, Todd Poynor <toddpoynor@google.com> wro=
te:
>> On Thu, Jul 28, 2011 at 10:30:14AM +0200, jean.pihet@newoldbits.com wrot=
e:
...

>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
>>> index 9af0847..63c3e7a 100644
>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>> @@ -108,6 +108,9 @@ static int _pwrdm_register(struct powerdomain *pwrd=
m)
>>> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>>> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
>>>
>>> + =A0 =A0 /* Early init of the next power state */
>>> + =A0 =A0 pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_RET);
>>> +
>>
>> Wanted to check that it's OK to initialize the next state of a power
>> domain to RETENTION early in the boot sequence. =A0I believe patches
>> have been previously discussed that set the state to ON to ensure the
>> domain doesn't go to a lower state, and possibly lose context, before
>> the PM subsystem is setup to handle it? =A0Not sure, thought maybe worth
>> a doublecheck.
> Indeed I need to check the behavior for OMAP3 & 4 which seem to
> initialize the pwrdm states differently.
> BTW the patch that inits all pwrdms to ON is not yet in l-o master
> that is why I (lazily) submitted this one for now.

Ok I will update the patch to make it compliant with [1]. v4 will
include this change.

Thanks,
Jean

[1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D131052762623823&w=3D2

>
>>
>>
>> Todd
