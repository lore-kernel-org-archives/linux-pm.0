From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] bq24022: Keep track of gpio states
Date: Mon, 29 Aug 2011 10:18:07 +0100
Message-ID: <20110829091805.GC9477@opensource.wolfsonmicro.com>
References: <201108281507.35105.heiko@sntech.de>
	<201108281509.24250.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108281509.24250.heiko@sntech.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 28, 2011 at 03:09:23PM +0200, Heiko St=FCbner wrote:
> gpio_get_value is not definied for output-gpios and can therefore not be
> used for the is_enabled and get_current_limit methods of the bq24022.
> =

> This patch introduces a private struct to keep track of the values set.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This also fixes the use of platform data after probe - platform data
should be able to be marked as initdata which may mean that the kernel
discards it after boot.
