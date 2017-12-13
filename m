From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Wed, 13 Dec 2017 21:33:33 +0200
Message-ID: <1513193613.7000.58.camel@linux.intel.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
         <20170925191749.2oamusbajgs6clcg@sig21.net>
         <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
         <34396652.fljU28PShI@aspire.rjw.lan>
         <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
         <CAEG3pNDL-8srk_JwqtZxs_waHAPfmRC_5Orhs_=XUhwdHTdM-g@mail.gmail.com>
         <e4760a03-b6af-00fc-6c26-9fff8ed6c378@redhat.com>
         <20171213162206.GA7337@sig21.net>
         <e6aa5c55-8174-7ad9-009f-c254d3aeaf72@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e6aa5c55-8174-7ad9-009f-c254d3aeaf72@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Johannes Stezenbach <js@sig21.net>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-12-13 at 17:37 +0100, Hans de Goede wrote:
> Hi,
> 
> On 13-12-17 17:22, Johannes Stezenbach wrote:
> > 


> > Please don't get confused with the other thread about clocks.
> > This issue sets the "disable IP" bit, found by doing stupid
> > experiments to enable S0ix on E200HA.
> 
> Ah my bad.

Oh, perhaps I also need to refresh my memory from that buglink.

> > 1. no idea if Cherry Trail even has SATA IP, maybe this is a
> >     meaningless bit but PMC firmware carried over from
> >     Bay Trail looks at it
> 
> 
> There are no CHT SoCs with SATA AFAIK, but Braswell SoCs,
> which I believe is the same die do have SATA.
> 
> I think the best fix here is to look at the model-string part
> of the CPU-id and do a quirk based on that, setting the "disable IP"
> bit for the SATA on all SoC models known to not have SATA
> (Z8300, Z8350, Z8500, Z8550, Z8700, Z8750).
> 
> Rafael, Andy how does that sound as a solution?

Yeah, that bit is a property of PMC microcontroller and thus belongs to
its driver in Linux kernel.

To make it strict we need a matching property. AFAIR CPU model ID is all
the same for all CHT and BSW SoCs, so, can't be used to distinguish
them. So, you are thinking about comparing CPU model name then?

It might work. However, SATA itself is a part of PCH, and thus can not
exactly be matched by CPU ID.

Btw, Pentium Celeron N-series according to spec has SATA host.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
