From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/8] gpio: gpio-wcove: use first level PMIC GPIO irq
Date: Mon, 24 Apr 2017 15:17:34 +0200
Message-ID: <CACRpkdYD8SiTDL1Bc4ordyi4E2fPSRpgbKY_DPd76oQYhXe11A@mail.gmail.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <cd9ddab845e471758b5553fcdc060d6eecd24e93.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cd9ddab845e471758b5553fcdc060d6eecd24e93.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, andy@infradead.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 15, 2017 at 1:25 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> PMIC mfd driver only exports first level irq for GPIO device.
> But currently we are reading the irqs from the second level irq
> chip, So this patch fixes this issue by adding support to use
> first level PMIC GPIO irq.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this gets merged into MFD because of dependencies?
If it compiles on its own and doesn't cause regressions I can
merged it into the GPIO tree.

Yours,
Linus Walleij
