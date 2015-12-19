From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/3] i2c: document binding for multi-master case
Date: Fri, 18 Dec 2015 22:18:54 -0600
Message-ID: <20151219041854.GM14936@rob-hp-laptop>
References: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
 <1450291460-10514-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450291460-10514-2-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 16, 2015 at 07:44:18PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> We need this binding because some I2C master drivers will need to adapt
> their PM settings for the arbitration circuitry. I skipped the "i2c-"
> prefix because I can imagine to be useful outside of i2c.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
