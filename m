From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
Date: Fri, 27 Jul 2018 14:15:57 -0700
Message-ID: <20180727211556.GA4450@localhost.localdomain>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13> <20180725095222.054f1e80@xps13>
 <1532570441.2358.27.camel@intel.com>
 <20180726211442.GB3487@localhost.localdomain>
 <20180726213517.GA15690@localhost.localdomain>
 <20180726221423.GA3569@localhost.localdomain>
 <20180727005928.6bbe021f@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180727005928.6bbe021f@xps13>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 27, 2018 at 12:59:28AM +0200, Miquel Raynal wrote:
> Hi Eduardo,
> =

> Eduardo Valentin <edubezval@gmail.com> wrote on Thu, 26 Jul 2018
> 15:14:24 -0700:
> =

> > =

> > =

> > Given that I let this one fall into the cracks and that these are minor
> > issues, I fixed them manually, and applied up to patch 19. But next at
> > least compile test your series and run checkpatch on them.
> =

> I was really surprised of your remark but indeed there was a build
> issue in the middle of the series that I did not see because I always
> test with a last patch fixing it (this patch adds interrupt support, I
> plan to send it for the next release). I'm very sorry for this
> mistake, thanks for fixing it by yourself.

Oh, you cannot do that :-). You have to diligently test each patch.

> =

> > =

> > Patches 20-23 need to go via your arch tree.
> =

> Sure, they will enter in the next release now.
> =

> Thanks,
> Miqu=E8l
