From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
Date: Mon, 2 Jul 2018 10:29:19 -0700
Message-ID: <20180702172918.GA28262@localhost.localdomain>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
 <20180626092931.7f0f0ad4@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180626092931.7f0f0ad4@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Miquel,

On Tue, Jun 26, 2018 at 09:29:31AM +0200, Miquel Raynal wrote:
> Hi Baruch,
> =

> On Tue, 26 Jun 2018 06:37:24 +0300, Baruch Siach <baruch@tkos.co.il>
> wrote:
> =

> > Hi Miquel,
> > =

> > On Mon, Jun 25, 2018 at 05:12:22PM +0200, Miquel Raynal wrote:
> > > Until recently, only one register was referenced in MVEBU thermal IP
> > > node. Recent changes added a second entry pointing to another
> > > register right next to it. We cannot know for sure that we will not
> > > have to access other registers. That will be actually the case when
> > > overheat interrupt feature will come, where it will be needed to acce=
ss
> > > DFX registers in the same area.
> > > =

> > > This approach is not scalable so intead of adding consinuously memory
> > > areas in the DT (and change de DT bindings, while keeping backward  =

> > =

> > s/de/the/
> =

> Oh and s/intead/instead/ too.

Can you please fix the minor above and also refresh against linus master
branch? Patch does not apply clean anymore.
checking file drivers/thermal/armada_thermal.c
Hunk #3 FAILED at 64.
Hunk #4 succeeded at 89 (offset -1 lines).
Hunk #5 succeeded at 112 (offset -1 lines).
Hunk #6 succeeded at 144 (offset -1 lines).
Hunk #7 succeeded at 165 (offset -1 lines).
Hunk #8 succeeded at 196 (offset -1 lines).
Hunk #9 succeeded at 209 (offset -1 lines).
Hunk #10 succeeded at 218 (offset -1 lines).
Hunk #11 succeeded at 258 (offset -1 lines).
Hunk #12 succeeded at 290 (offset -1 lines).
Hunk #13 succeeded at 303 (offset -1 lines).
Hunk #14 succeeded at 316 (offset -1 lines).
Hunk #15 succeeded at 331 (offset -1 lines).
Hunk #16 succeeded at 347 (offset -1 lines).
Hunk #17 succeeded at 362 (offset -1 lines).
Hunk #18 FAILED at 399.
Hunk #19 succeeded at 400 (offset -31 lines).
Hunk #20 succeeded at 413 with fuzz 1 (offset -31 lines).
Hunk #21 succeeded at 417 (offset -34 lines).
2 out of 21 hunks FAILED

I get the above after applying the first 5 patches of your series.

> =

> Thanks for pointing it,
> Miqu=E8l
