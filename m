From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/5] w1: core: match sub-nodes of bus masters in
 devicetree
Date: Fri, 6 Jul 2018 16:51:33 +0200
Message-ID: <20180706145133.GA8930@kroah.com>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-4-daniel@zonque.org>
 <20180706135205.dkcrhbmaak2iteyw@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706135205.dkcrhbmaak2iteyw@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Daniel Mack <daniel@zonque.org>, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 06, 2018 at 03:52:05PM +0200, Sebastian Reichel wrote:
> Hi Greg & Evgeniy,
> 
> I suggest, that I take this patch and the DT bindings together
> with the power-supply changes, once the bindings have been
> reviewed by Rob (Herring). I will prepare an immutable branch,
> that can be pulled into w1 as needed. Are you fine with this?

You can take it, no need to mess with me :)

greg k-h
