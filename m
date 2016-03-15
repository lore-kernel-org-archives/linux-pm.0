From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V4] PM / clk: Add support for obtaining clocks from device-tree
Date: Tue, 15 Mar 2016 13:15:16 +0100
Message-ID: <CAMuHMdV_PVnZ11BJ3FHe9Gc5nH-yk1u-NuHntOnRiQ4npVkd8g@mail.gmail.com>
References: <1458041620-27066-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458041620-27066-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 15, 2016 at 12:33 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> The PM clocks framework requires clients to pass either a con-id or a
> valid clk pointer in order to add a clock to a device. Add a new
> function of_pm_clk_add_clks() to allows device clocks to be retrieved
> from device-tree and populated for a given device. Note that it is
> not necessary to make the compilation of this new function dependent
> upon CONFIG_OF because there are stubs functions for the device-tree
> APIs used.
>
> In order to handle errors encountered when adding clocks from
> device-tree, add a function pm_clk_remove_clk() to remove any clocks
> (using a pointer to the clk structure) that have been added
> successfully before the error occurred.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert
