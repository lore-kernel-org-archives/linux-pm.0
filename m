From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/7] thermal: rcar_gen3_thermal: enable hardware
 interrupts for trip points
Date: Tue, 21 Mar 2017 14:50:59 +0100
Message-ID: <CAMuHMdXJpVdNosRcwqjmy40gDDXo7myKLZtF8y+p-q0cZbqq2Q@mail.gmail.com>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-6-niklas.soderlund+renesas@ragnatech.se>
 <20170307195533.GE2554@tetsubishi> <20170317100630.GA20587@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34326 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757076AbdCUNvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 09:51:39 -0400
In-Reply-To: <20170317100630.GA20587@bigcity.dyn.berto.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Niklas,

On Fri, Mar 17, 2017 at 11:06 AM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-03-07 20:55:33 +0100, Wolfram Sang wrote:
>> On Mon, Mar 06, 2017 at 09:03:59PM +0100, Niklas S=C3=B6derlund wrote:
>> > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnate=
ch.se>
>> > ---
>> >  drivers/thermal/rcar_gen3_thermal.c | 137 +++++++++++++++++++++++++++=
+++++++++
>> >  1 file changed, 137 insertions(+)
>> >
>> > +static int rcar_gen3_thermal_set_trips(void *devdata, int low, int hi=
gh)
>> > +{
>> > +   struct rcar_gen3_thermal_tsc *tsc =3D devdata;
>> > +
>> > +   if (low < -40000)
>> > +           low =3D -40000;
>> > +   if (high > 125000)
>> > +           high =3D 125000;
>>
>> Use clamp_val()?
>
> Good idea, will use.

Why not clamp()? Does the type checking stand in the way?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
