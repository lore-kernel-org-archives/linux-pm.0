From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] dt: power: Add docs for generic SYSCON poweroff driver.
Date: Tue, 10 Mar 2015 16:23:41 -0700
Message-ID: <CAAtXAHfhUK-GhQLscfOpyj_3yaNRMWmjU9wDj_TrUqQtLZ5EBQ@mail.gmail.com>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
	<1426029670-31775-3-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38180 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbCJXXm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 19:23:42 -0400
Received: by obcuz6 with SMTP id uz6so5315154obc.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2015 16:23:41 -0700 (PDT)
In-Reply-To: <1426029670-31775-3-git-send-email-moritz.fischer@ettus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

On Tue, Mar 10, 2015 at 4:21 PM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:
> Add documentation for generic SYSCON poweroff driver.
>
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  .../bindings/power/reset/syscon-poweroff.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
> new file mode 100644
> index 0000000..1422cee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
> @@ -0,0 +1,23 @@
> +Generic SYSCON mapped register poweroff driver
> +
> +This is a generic poweroff driver using syscon to map the poweroff register.
> +The poweroff is generally performed with a write to the poweroff register
> +defined by the register map pointed by syscon reference plus the offset
> +with the mask defined in the poweroff node.
> +
> +Required properties:
> +- compatible: should contain "syscon-poweroff"
> +- regmap: this is phandle to the register map node
> +- offset: offset in the register map for the poweroff register (in bytes)
> +- mask: the poweroff value written to the poweroff register (32 bit access)
> +
> +Default will be little endian mode, 32 bit access only.
> +
> +Examples:
> +
> +       reboot {

Arghhh ...
> +          compatible = "syscon-reboot";
Arghhhh.....
> +          regmap = <&regmapnode>;
> +          offset = <0x0>;
> +          mask = <0x7a>;
> +       };
> --
> 1.9.3
>

Will collect feedback and resubmit, sorry about that.

Moritz
