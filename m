From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [RFC PATCH 2/2] clk: x86: Disable unused clocks to fix S0ix
Date: Wed, 13 Dec 2017 10:20:08 +0000
Message-ID: <CAL9uMOFVWZW41r=s6LO6Lz+wwBh8N=CpcoBwx-96NwWr84hdRg@mail.gmail.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <1555462.9U3gvkyXAX@aspire.rjw.lan>
 <20170925192352.ihzakshd7yofowdd@sig21.net> <7178688.oS2VOf73im@aspire.rjw.lan>
 <fb202f9b-1fa2-4b9c-de75-4431a6273d12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <fb202f9b-1fa2-4b9c-de75-4431a6273d12@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Johannes Stezenbach <js@sig21.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 8:56 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,

/cut
> Carlo, do you remember which clock you needed this for ?

In one of our machine the problem was with the r8169 driver not
claiming the pmc_plt_clk_4 clock.

We also tried something like this
https://www.spinics.net/lists/platform-driver-x86/msg12094.html but
it's not like this is a much better solution IMO.

Also AFAICT the same is done in:

drivers/staging/media/atomisp/platform/intel-mid/atomisp_gmin_platform.c
sound/soc/intel/boards/bytcht_es8316.c
sound/soc/intel/boards/bytcr_rt5640.c
sound/soc/intel/boards/bytcr_rt5651.c
sound/soc/intel/boards/cht_bsw_max98090_ti.c
sound/soc/intel/boards/cht_bsw_rt5645.c
sound/soc/intel/boards/cht_bsw_rt5672.c

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
