From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
Date: Wed, 13 Jul 2016 16:42:50 +0800
Message-ID: <20160713084250.GB11863@shlinux2>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
 <1468394851.3638.13.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1468394851.3638.13.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, festevam@gmail.com, stillcompiling@gmail.com, pawel.moll@arm.com, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, arnd@arndb.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 13, 2016 at 09:27:31AM +0200, Philipp Zabel wrote:
> Am Mittwoch, den 13.07.2016, 10:06 +0800 schrieb Peter Chen:
> > Add binding doc for generic power sequence library.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > new file mode 100644
> > index 0000000..186c58c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > @@ -0,0 +1,53 @@
> > +The generic power sequence library
> > +
> > +Some hard-wired USB/MMC devices need to do power sequence to let the
> > +device work normally,
> 
> I would replace "to let the device work normally" with "before the
> device can be enumerated [on the bus]" here.
> 

Ok.

> >  the typical power sequence like: enable USB
> > +PHY clock, toggle reset pin, etc. But current Linux USB driver
> > +lacks of such code to do it, it may cause some hard-wired USB devices
> > +works abnormal or can't be recognized by controller at all. The
> > +power sequence will be done before this device can be found at USB
> > +bus.
> > +
> > +The power sequence properties is under the device node.
> > +
> > +Required properties:
> > +- power-sequence: this device needs to do power sequence before enumeration
> 
> As Joshua pointed out, is this even needed at all?
> 

If no, how we decide whether allocates pwrseq instance through pwrseq
library or not?

-- 

Best Regards,
Peter Chen
