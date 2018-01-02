From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove bogus const from function
 return type
Date: Tue, 2 Jan 2018 09:50:18 -0800
Message-ID: <20180102175016.GA15928@localhost.localdomain>
References: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
 <CAK8P3a3E0XA_SFJFSH_PYcw1TvaLDD1cuvYK48_HTTrbP1gg+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3E0XA_SFJFSH_PYcw1TvaLDD1cuvYK48_HTTrbP1gg+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Zhang Rui <rui.zhang@intel.com>, Kevin Wangtao <kevin.wangtao@linaro.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 02, 2018 at 12:44:29PM +0100, Arnd Bergmann wrote:
> On Sun, Nov 19, 2017 at 12:04 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > With gcc-4.1.2:
> >
> >     drivers/thermal/hisi_thermal.c: In function ‘hisi_thermal_probe’:
> >     drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored on function return type
> >
> > Remove the "const" keyword to fix this.
> >
> > Fixes: a160a465297362c5 ("thermal/drivers/hisi: Prepare to add support for other hisi platforms")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> For future reference, this kind of warning shows up with gcc-4.2 as
> well, but not with
> gcc-4.3 or higher. I think in this case, both gcc and sparse fail to

Yeah, this is correct. I do not see the same warn while using gcc-4.8.

> provide helpful
> feedback, but the code is probably better done using either a typedef
> for the function
> type, or with a structure containing the function pointer.

I agree.

> 
>          Arnd
