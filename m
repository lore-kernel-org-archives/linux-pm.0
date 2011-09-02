From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: how to best map device regulators
Date: Fri, 2 Sep 2011 13:49:17 +0100
Message-ID: <20110902124916.GB27415@opensource.wolfsonmicro.com>
References: <201109021142.01057.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201109021142.01057.heiko@sntech.de>
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
Cc: linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 02, 2011 at 11:42:00AM +0200, Heiko St=FCbner wrote:

> My first candidate is a "GMT G9093", i.e. two fixed voltage regulators in=
 one ic =

> controlled via GPIOs. Here intuition suggest to simply use two instances =
of =

> the fixed-driver - no use in duplicating its function. Correct?

Seems sensible.

> Second, more complex chip, is a TI tps650240, i.e. 3 fixed voltage regula=
tors, =

> 1 regulator switchable between 2 voltages - all controllable via GPIOs - =
 and =

> two regulators whose enabled-state is controlled by one gpio only.

> Here I'm torn between (1) building a new driver and (2) using fixed volta=
ge =

> drivers and building a switch-driver for the two voltage-regulator (here =
I'm =

> also not sure if this should be crammed into the fixed-driver, as I think=
 it is =


A separate driver for one that can select voltages seems sensible.

> called fixed for a reason). For (2) I'm also not sure, on how to implemen=
t =

> support for the two regulators controlled by one gpio.

That's not really well supported but from a system integration point of
view it's usually fine since the design tends to be such that the two
are always enabled together so you can just give the enable to one of
the regulators and ignore the fact that it's actually controlling both
and software actually works fine even if it's not truly correct.
