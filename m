From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 8/8] platform: x86: intel_bxtwc_tmu: remove first level
 irq unmask
Date: Sat, 22 Apr 2017 05:52:32 +0300
Message-ID: <CAHp75VeGQ=Zb=azNZCEfA25VdvuQcbMJoHuXkyQ24KOh4WQjRw@mail.gmail.com>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <93377b77b9493d79de48741b030fa1b03f80094f.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170421220025.GC31650@fury> <d9ead97f-db7b-a0b0-4eb1-1c783ee1e841@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <d9ead97f-db7b-a0b0-4eb1-1c783ee1e841@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 22, 2017 at 1:34 AM, sathyanarayanan kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> Thanks for brining it up. I was planning to ask either Andy or Lee regarding
> this issue after all patches in the series are reviewed.

Darren, I'm planning to review this soon.

P.S. We have few series flying around regarding to Intel PMIC(s): my
for Kconfig naming, Hans' for Crystal Cove (touches Kconfig as well),
and Sathya's series. I hope Lee can collect them in proper order.

-- 
With Best Regards,
Andy Shevchenko
