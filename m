From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / AVS: rockchip-io: add io selectors and supplies for PX30
Date: Thu, 24 May 2018 11:31:31 +0200
Message-ID: <2673153.vuZoQPqmHn@aspire.rjw.lan>
References: <1526384899-11644-1-git-send-email-david.wu@rock-chips.com> <1899248.qiidGlqZWz@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1899248.qiidGlqZWz@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>
Cc: khilman@baylibre.com, rafael.j.wysocki@intel.com, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 15, 2018 1:51:26 PM CEST Heiko Stuebner wrote:
> Hi David,
> 
> Am Dienstag, 15. Mai 2018, 13:48:19 CEST schrieb David Wu:
> > This adds the necessary data for handling io voltage domains on PX30.
> > As interesting tidbit, the PX30 contains two separate iodomain areas.
> > One in the regular General Register Files (GRF) and one in PMUGRF in the
> > pmu power domain.
> > 
> > Signed-off-by: David Wu <david.wu@rock-chips.com>
> 
> thanks for the fast respin, looks great now.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied, thanks!
