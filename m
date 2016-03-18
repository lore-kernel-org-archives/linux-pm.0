From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] PM / clk: Add support for obtaining clocks from device-tree
Date: Fri, 18 Mar 2016 01:46:17 +0100
Message-ID: <1724113.VnPWaRLGz3@vostro.rjw.lan>
References: <1458041620-27066-1-git-send-email-jonathanh@nvidia.com> <CAMuHMdV_PVnZ11BJ3FHe9Gc5nH-yk1u-NuHntOnRiQ4npVkd8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45050 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965586AbcCRAoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 20:44:14 -0400
In-Reply-To: <CAMuHMdV_PVnZ11BJ3FHe9Gc5nH-yk1u-NuHntOnRiQ4npVkd8g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tuesday, March 15, 2016 01:15:16 PM Geert Uytterhoeven wrote:
> On Tue, Mar 15, 2016 at 12:33 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> > The PM clocks framework requires clients to pass either a con-id or a
> > valid clk pointer in order to add a clock to a device. Add a new
> > function of_pm_clk_add_clks() to allows device clocks to be retrieved
> > from device-tree and populated for a given device. Note that it is
> > not necessary to make the compilation of this new function dependent
> > upon CONFIG_OF because there are stubs functions for the device-tree
> > APIs used.
> >
> > In order to handle errors encountered when adding clocks from
> > device-tree, add a function pm_clk_remove_clk() to remove any clocks
> > (using a pointer to the clk structure) that have been added
> > successfully before the error occurred.
> >
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

Applied.

Thanks,
Rafael

