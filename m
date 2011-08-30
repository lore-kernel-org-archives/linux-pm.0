From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] bq24022: Add support for the bq2407x
	family
Date: Tue, 30 Aug 2011 11:52:46 +0100
Message-ID: <20110830105245.GD2061@opensource.wolfsonmicro.com>
References: <201108291755.15701.heiko@sntech.de>
	<201108291759.35396.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108291759.35396.heiko@sntech.de>
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

On Mon, Aug 29, 2011 at 05:59:35PM +0200, Heiko St=FCbner wrote:
> The bq2407x family of charger ICs simply supports another machine
> specific charging current above 500mA. To use this setting a
> second gpio pin is used while the rest of the pins stay the same.
> =

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
