From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/4] constify thermal_zone_of_device_ops structures
Date: Tue, 8 Aug 2017 15:46:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708081546130.28470@hadrien>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr> <1502199838.4296.64.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1502199838.4296.64.camel@intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Aug 2017, Zhang Rui wrote:

> On Sat, 2017-08-05 at 22:37 +0200, Julia Lawall wrote:
> > The thermal_zone_of_device_ops structures are only passed as the
> > fourth
> > argument to thermal_zone_of_sensor_register, which is declared as
> > const.
> > Thus the thermal_zone_of_device_ops structures themselves can be
> > const.
> >
> > Done with the help of Coccinelle.
>
> I still see the same problem in other thermal drivers, which is not
> covered by this patch set. Can we fix them all in one time?

OK.

julia
