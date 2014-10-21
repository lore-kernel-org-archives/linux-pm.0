From: Santosh Shilimkar <santosh.shilimkar@gmail.com>
Subject: Re: [PATCH v2 1/3] PM / clock_ops: Add pm_clk_add_clk()
Date: Tue, 21 Oct 2014 11:00:36 -0700
Message-ID: <54469F44.4060701@gmail.com>
References: <1413809764-21995-1-git-send-email-grygorii.strashko@ti.com> <1413809764-21995-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413809764-21995-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, khilman@linaro.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Kevin, Rafael,

On 10/20/2014 05:56 AM, Grygorii Strashko wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> The existing pm_clk_add() allows to pass a clock by con_id. However,
> when referring to a specific clock from DT, no con_id is available.
>
> Add pm_clk_add_clk(), which allows to specify the struct clk * directly.
>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>
>   Pay attantion pls, that there is another series of patches
>   which have been posted already and which depends from this patch
>     "[PATCH v4 0/3] ARM: rk3288 : Add PM Domain support"
>     https://lkml.org/lkml/2014/10/20/105
>
How do you go about merging the $subject patch ?
I see there are at least 2 series which depends on this one.

Regards,
Santosh
