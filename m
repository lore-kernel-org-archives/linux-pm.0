From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
Date: Fri, 6 Jul 2018 11:51:48 -0600
Message-ID: <CAL_JsqL8Lc3r7d5b2tnngJksRSiDqDzXjxyK8n1htGbUa6nE6g@mail.gmail.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
 <20180705120528.4b923e16@xps13>
 <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
 <20180706085458.6ed1a483@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180706085458.6ed1a483@xps13>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Eduardo Valentin <edubezval@gmail.com>, David Sniatkiwicz <davidsn@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 6, 2018 at 12:55 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Rob,
>
> Rob Herring <robh@kernel.org> wrote on Thu, 5 Jul 2018 12:03:04 -0600:
>
> > On Thu, Jul 5, 2018 at 4:05 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Rob Herring <robh@kernel.org> wrote on Tue, 3 Jul 2018 15:30:11 -0600:
> > >
> > > > On Mon, Jun 25, 2018 at 05:12:34PM +0200, Miquel Raynal wrote:
> > > > > New bindings (with the syscon and the overheat interrupt) are available
> > > >
> > > > What interrupt? It's not in your new binding.
> >
> > ???
>
> I forgot that point, my bad.
>
> Initially this series introduced an overheat interrupt. Due to some
> dependencies I split the original series in two: this one and another
> one just to add support for the interrupt.

You can split up the driver support, but please make the binding
complete as possible.

Rob
