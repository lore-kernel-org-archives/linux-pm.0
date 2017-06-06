From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/7] USB: of: document reference taken by child-lookup
 helper
Date: Tue, 6 Jun 2017 17:38:15 +0200
Message-ID: <20170606153815.GJ15860@localhost>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-3-johan@kernel.org>
 <eda774a3-7bd2-94e4-a5b8-67a93ec2fcf4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eda774a3-7bd2-94e4-a5b8-67a93ec2fcf4@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 30, 2017 at 03:40:03PM -0700, Tyrel Datwyler wrote:
> On 05/30/2017 09:25 AM, Johan Hovold wrote:
> > Document that the child-node lookup helper takes a reference to the
> > device-tree node which needs to be dropped after use.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/usb/core/of.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> > index d563cbcf76cf..17a4af02cf5b 100644
> > --- a/drivers/usb/core/of.c
> > +++ b/drivers/usb/core/of.c
> > @@ -28,6 +28,9 @@
> >   *
> >   * Find the node from device tree according to its port number.
> >   *
> > + * Takes a reference to the returned device-tree node, which needs to be
> > + * dropped after use.
> > + *
> >   * Return: On success, a pointer to the device node, %NULL on failure.
> 
> I would use the same blurb used throughout drivers/of/* for consistency.
> 
>  *      Returns a node pointer with refcount incremented, use
>  *      of_node_put() on it when done.
>  */
> 
> Just my 2-cents

I updated the comment to use a version of this also found in drivers/of:

 * Return: A pointer to the node with incremented refcount if found, or
 * %NULL otherwise.

which is on kernel-doc format. I don't think we need to explicitly
mention which function to manipulate the refcount with in every header.

Thanks,
Johan
