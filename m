From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCHv2 07/19] mfd: ab8500: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 20 Jan 2015 17:06:03 +0100
Message-ID: <20150120160602.GB32144@amd>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
 <20150120133617.GG13701@x1>
 <1421763376.8855.4.camel@AMDC1943>
 <20150120155149.GG13701@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150120155149.GG13701@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2015-01-20 15:51:49, Lee Jones wrote:
> On Tue, 20 Jan 2015, Krzysztof Kozlowski wrote:
> 
> > On wto, 2015-01-20 at 13:36 +0000, Lee Jones wrote:
> > > On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:
> > > 
> > > > Replace direct calls to power supply function attributes with wrappers.
> > > > Wrappers provide safe access in case of unregistering the power
> > > > supply (e.g. by removing the driver). Replace:
> > > >  - get_property -> power_supply_get_property
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > You've sent this to me already Acked.  I don't see 00/00, so I have no
> > > idea what's going on.  Do you want me to take this patch?  Can it be
> > > taking on its own?
> > 
> > git send-email automatically CC-you because you acked this. The depends
> > on previous patches adding this API so please do not pick it up. 
> 
> You should always send MFD related patches to me (either
> automatically, or manually).
> 
> > Everything (with respective acks) should go through one power supply
> > tree.
> 
> That's not how it works.  We need to decide that amongst ourselves
> and it needs to culminate in pull-requests being sent out to all of
> the effected Maintainers.

So go ahead and decide. If the patches are ok, I see no problem in it
going through power supply tree, and neither should you. I feel you
are making it more complex than it is.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
