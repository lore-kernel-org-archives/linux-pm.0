From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: thermal/drivers/hisi: Remove bogus const from function return type
Date: Tue, 2 Jan 2018 08:36:31 +0100
Message-ID: <CAMuHMdU-_Obwo8t=2oE3CfEmZ0nks03HNssS53cKVfbLCi2sdA@mail.gmail.com>
References: <1511089467-20525-1-git-send-email-geert@linux-m68k.org> <20180101182123.GA3753@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33741 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeABHgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 02:36:33 -0500
In-Reply-To: <20180101182123.GA3753@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kevin Wangtao <kevin.wangtao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Eduardo,

On Mon, Jan 1, 2018 at 7:21 PM, Eduardo Valentin <edubezval@gmail.com> wrot=
e:
> On Sun, Nov 19, 2017 at 12:04:27PM +0100, Geert Uytterhoeven wrote:
>> With gcc-4.1.2:
>>
>>     drivers/thermal/hisi_thermal.c: In function =E2=80=98hisi_thermal_pr=
obe=E2=80=99:
>>     drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored=
 on function return type
>>
>> Remove the "const" keyword to fix this.
>
> Interesting.
>
> I intentionally asked Daniel to include the modifier because sparse
> pointed this to me:
>
> This patch adds this issue to hisi driver (sparse)
>
> drivers/thermal/hisi_thermal.c:398:24: warning: incorrect type in assignm=
ent (different modifiers)
> drivers/thermal/hisi_thermal.c:398:24:    expected int ( *platform_probe =
)( ... )
> drivers/thermal/hisi_thermal.c:398:24:    got void const *

Sparse doesn't like assigning void pointers to function pointers without a =
cast.

> which makes sense to me to be const, given that it is receiving the retur=
n
> of a function which returns a const void *.
> nclude/linux/of_device.h:extern const void *of_device_get_match_data(cons=
t struct device *dev);

That const applies to what is returned by of_device_get_match_data() (a con=
st
void *), not to what is returned by the returned function (an int).

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
