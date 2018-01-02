From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove bogus const from function
 return type
Date: Tue, 2 Jan 2018 12:44:29 +0100
Message-ID: <CAK8P3a3E0XA_SFJFSH_PYcw1TvaLDD1cuvYK48_HTTrbP1gg+Q@mail.gmail.com>
References: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kevin Wangtao <kevin.wangtao@linaro.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 19, 2017 at 12:04 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> With gcc-4.1.2:
>
>     drivers/thermal/hisi_thermal.c: In function =E2=80=98hisi_thermal_pro=
be=E2=80=99:
>     drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored =
on function return type
>
> Remove the "const" keyword to fix this.
>
> Fixes: a160a465297362c5 ("thermal/drivers/hisi: Prepare to add support fo=
r other hisi platforms")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

For future reference, this kind of warning shows up with gcc-4.2 as
well, but not with
gcc-4.3 or higher. I think in this case, both gcc and sparse fail to
provide helpful
feedback, but the code is probably better done using either a typedef
for the function
type, or with a structure containing the function pointer.

         Arnd
