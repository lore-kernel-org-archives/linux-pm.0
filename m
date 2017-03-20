From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/15] mfd: Add Cherry Trail Whiskey Cove PMIC driver
Date: Mon, 20 Mar 2017 14:55:05 +0200
Message-ID: <1490014505.19767.103.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <20170317095527.10487-2-hdegoede@redhat.com>
         <1489770046.19767.66.camel@linux.intel.com>
         <20170320104152.lba24r2qilpjr2kk@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320104152.lba24r2qilpjr2kk@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-03-20 at 10:41 +0000, Lee Jones wrote:
> On Fri, 17 Mar 2017, Andy Shevchenko wrote:
> > On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:

> > > +enum {
> > > +	CHT_WC_PWRSRC_IRQ = 0,
> > > +	CHT_WC_THRM_IRQ,
> > > +	CHT_WC_BCU_IRQ,
> > > +	CHT_WC_ADC_IRQ,
> > > +	CHT_WC_EXT_CHGR_IRQ,
> > > +	CHT_WC_GPIO_IRQ,
> > > +	/* There is no irq 6 */
> > > +	CHT_WC_CRIT_IRQ = 7,
> > 
> > I would prefer explicit over implicit (adding = N to each line), but
> > this is minor.
> 
> No need.  The C standard is clear on what is expected of enums.

I understand that, though I don't like gaps in enums. That's why I
prefer in such cases pure #define over enum (yes, I understand that enum
in many cases is better).

But this all matter of taste. So, I will not insist if it would be left
as it is now.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
