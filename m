From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 09/11] OPP: Add support for opp-suspend
Date: Mon, 27 Jul 2015 16:50:56 +0200
Message-ID: <3276614.ibSSrYN5Ae@amdc1976>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <ec715e6ab8c026340cad992a79eea34c64a3f05a.1437972635.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <ec715e6ab8c026340cad992a79eea34c64a3f05a.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, July 27, 2015 10:32:39 AM Viresh Kumar wrote:
> With "operating-points-v2" bindings, its possible to specify the OPP to
> which the device must be switched, before suspending.
> 
> This patch adds support for getting that information.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
