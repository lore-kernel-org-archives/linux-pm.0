From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and X86 due for the v4.13
 merge window
Date: Mon, 19 Jun 2017 18:08:27 +0300
Message-ID: <CAHp75VcoS4khrYJ_6_hr_s+7eOz0GUA0qrjv5uKvw5KqQUuRMA@mail.gmail.com>
References: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
 <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com> <20170619144849.ltx2qny5v66od3ml@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619144849.ltx2qny5v66od3ml@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 19, 2017 at 5:48 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Enjoy!

Thanks!

I suppose this one kbuild bot doesn't complain about :-)

Darren, do we need it or we can survive until v4.13-rc1?

>
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43=
f6:
>
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-x86-v4=
.13
>
> for you to fetch changes up to 94d68594a7b4fd2eec457f22110de644e1c4ee57:
>
>   platform/x86: intel_bxtwc_tmu: Remove first level IRQ unmask (2017-06-1=
9 15:45:30 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and X86 due for the v4.13 merge window
>
> ----------------------------------------------------------------
> Kuppuswamy Sathyanarayanan (6):
>       mfd: intel_soc_pmic_bxtwc: Fix TMU interrupt index
>       mfd: intel_soc_pmic_bxtwc: Remove thermal second level IRQs
>       mfd: intel_soc_pmic_bxtwc: Remove second level IRQ for gpio device
>       mfd: intel_soc_pmic_bxtwc: Utilize devm_* functions in driver probe
>       mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ ch=
ips
>       platform/x86: intel_bxtwc_tmu: Remove first level IRQ unmask
>
>  drivers/gpio/gpio-wcove.c                |  14 +-
>  drivers/mfd/intel_soc_pmic_bxtwc.c       | 232 +++++++++++++++++++++----=
------
>  drivers/platform/x86/intel_bxtwc_tmu.c   |   4 -
>  drivers/thermal/intel_bxt_pmic_thermal.c |   2 +-
>  drivers/usb/typec/typec_wcove.c          |   2 +-
>  include/linux/mfd/intel_soc_pmic.h       |   5 +-
>  6 files changed, 175 insertions(+), 84 deletions(-)
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
With Best Regards,
Andy Shevchenko
