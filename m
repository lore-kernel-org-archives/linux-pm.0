From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Date: Wed, 5 Dec 2018 10:10:35 +0000
Message-ID: <20181205101035.GA31059@e107155-lin>
References: <87k1kowf7i.fsf@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87k1kowf7i.fsf@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org, orenbh <orenbh@marvell.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 05, 2018 at 09:27:45AM +0100, Gregory CLEMENT wrote:
> Hi Baruch,
>  =

>  On mer., d=E9c. 05 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> =

> > Hi Gregory,
> >
> > On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> >> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >> > >
> >> > > This commit breaks boot on Armada 8K based systems. Reverting it m=
akes
> >> > > affected systems boot again.
> >> > >
> >> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> >> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> > =

> >> > I would like to know more about it because on the McBin I use there =
is
> >> > no issue with 4.20-rc1.
> >> > =

> >> > Do you observe this issue with the arm64 defconfig or do you have so=
me
> >> > specific configuration option?
> >> =

> >> I tested the attached defconfig on Clearfog GT-8K and on another custo=
m Armada =

> >> 8K based board.
> >> =

> >> Tomorrow I'll test Macchiatobin with this config and the arm64 defconf=
ig.
> >
> > I reproduced same issue on a Macchiatobin board with both this config a=
nd the =

> > arm64 defconfig. The latter produced this splat:
> =

> OK thanks, for this, I also got the confirmation by my colleagues. The
> only difference I can think of, is the firmware, but the surprising
> thing, is that I have an old firmware: 17.06.2 and that with a recent
> one, it doesn't work.
> =

> So I will apply it in mvebu/fixes.
> =


Sorry if it's too late. But I would rather disable the states that are
broken on old firmware and see if it's possible for bootloader or boot
firmware loading DT can modify the status to "enabled" if it can detect
the firmware version.

--
Regards,
Sudeep
