From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Tue, 15 May 2012 11:16:53 +0530
Message-ID: <CAJ6a13aJwesHw0frCV+EfvYaep09cZGcu_PopuHzye1HS2tgvg@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<87397by2h9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87397by2h9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com
List-Id: linux-pm@vger.kernel.org

On Tue, May 8, 2012 at 5:21 AM, Kevin Hilman <khilman@ti.com> wrote:
> Rafael,
>
> Keerthy <j-keerthy@ti.com> writes:
>
>> From: J Keerthy <j-keerthy@ti.com>
>>
>> AVS(Adaptive Voltage Scaling) is a power management technique which
>> controls the operating voltage of a device in order to optimize (i.e=
=2E reduce)
>> its power consumption. The voltage is adapted depending on static fa=
ctors
>> (chip manufacturing process) and dynamic factors (temperature
>> depending performance).
>> The TI AVS solution is named Smartreflex.
>>
>> To that end, create the AVS driver in drivers/power/avs and
>> move the OMAP SmartReflex code to the new directory. The
>> class driver is still retained in the mach-omap2 directory.
>
> How should we handle this for upstream?
>
> It does a bunch of cleanup under arch/arm then does the move to
> drivers/power the end. =A0To avoid conflicts with other OMAP core cha=
nges,
> I would suggest we take this through the OMAP tree.
>
> With your ack, I'd be glad to take it.

Hello Rafael,

A gentle ping on this series.

>
> Thanks,
>
> Kevin
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
