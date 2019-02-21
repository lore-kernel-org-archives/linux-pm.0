From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v5 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Date: Wed, 20 Feb 2019 17:21:30 -0800
Message-ID: <20190221012130.GB5838@wrath>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-2-lkundrak@v3.sk>
 <20190111143635.GA21484@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190111143635.GA21484@bogus>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 11, 2019 at 08:36:35AM -0600, Rob Herring wrote:
> On Thu, 10 Jan 2019 18:58:36 +0100, Lubomir Rintel wrote:
> > The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> > signals for handshaking. It needs to know when is the slave (Linux)
> > side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> > controller node) and when does it wish to respond with a command (the
> > cmd-gpio property).
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/cmd-gpio/cmd-gpios/
> > - s/ready-gpio/ready-gpios/ in the documentation paragraph
> > - Remove status = "okay" from the example
> > 
> >  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Rob, I saw you ack this patch in an earlier version. Based on your comment here,
is that ack still valid?

-- 
Darren Hart
VMware Open Source Technology Center
