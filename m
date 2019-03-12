From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Date: Tue, 12 Mar 2019 10:50:21 -0500
Message-ID: <20190312155021.GA23277@bogus>
References: <20190226150437.3704-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226150437.3704-1-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Feb 2019 16:04:36 +0100, Artur Rojek wrote:
> Add documentation for the "status-gpios" property.
> Update the "gpios" property with a valid example.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Changes:
> 
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
> 
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
