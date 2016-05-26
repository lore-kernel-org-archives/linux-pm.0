From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: DT description of SRAM with power manageable banks
Date: Thu, 26 May 2016 13:30:31 -0500
Message-ID: <CAL_Jsq+R8E7UwAW+aUcmHPhgMS0D39C77kxgqwLK0_kTWHkWFw@mail.gmail.com>
References: <57473709.1020108@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57473709.1020108-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 26, 2016 at 12:48 PM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org> wrote:
> Hi DT team,
>
> let me ask you for advice how to extend a common "mmio-sram" compatible
> binding description with information about power manageable banks,
> which are specific to some SRAM. My main interest is to give a better
> support of NXP LPC32xx SRAM, but as far as I know it concerns other
> controllers from the LPC series, and maybe some other ones.
>
> Taking a simple visual example let's consider NXP LPC3250 SRAM, which
> has four banks, three of them has independent power controls:
>
>         0x00000 - 0x0ffff (64KiB), always on-power bank,
>         0x10000 - 0x1ffff (64KiB), power manageable bank
>         0x20000 - 0x2ffff (64KiB), power manageable bank
>         0x30000 - 0x3ffff (64KiB), power manageable bank
>
> All banks together form a single continuous address space, and it seems
> important to have just one SRAM device and not 4, since e.g. in normal
> runtime operation continuous 100KiB from the whole SRAM area are reserved
> for storing MAC RX/TX buffers, it won't fit into one bank, however in
> sleep mode (or when there is no users of some SRAM banks in runtime)
> it is desirable to turn off unused banks, thus there should be a connection
> between each power manageable bank and some power domain like this:
>
>         sram_pd: power-controller@110 {
>                 compatible = "nxp,lpc3220-pos";
>                 reg = <0x110 0x8>;
>                 #power-domain-cells = <1>;
>         };
>
> ...
>
>         sram-bank@08010000 {
>                 reg = <0x08010000 0x10000>;
>                 power-domains = <&sram_pd 0>;
>         };
>
> ...
>
> The ordinary SRAM device node looks like
>
>         sram@08000000 {
>                 compatible = "mmio-sram";
>                 reg = <0x08000000 0x40000>;
>         };
>
> and I would happy to have it just like that, and actually it works
> perfectly, if the problem with delicate power management is ignored.
> At least it demonstrates that a generic wide compatible "mmio-sram"
> suits well here.
>
> The problem I face is in setting a proper layout of "sram@" and three
> "sram-bank@" device nodes (remember 1 of 4 banks has no power control).
> Unfortunately "sram-bank@" device nodes can not be children of "sram@",
> because children of "mmio-sram" compatible device node play a role
> of reserved areas ("partitions"), and that's not what I want. Moreover
> reserved areas and power manageable banks are orthogonal, for instance
> one reserved area may overlap with two power manageable banks or
> vice versa.
>
> Questions I have concerning this case:
>
> 1) would it be correct to add the second compatible like this?
>
>         sram@08000000 {
>                 compatible = "mmio-sram", "nxp,lpc3220-sram";

Yes, but reverse the order. Most specific first.

>                 reg = <0x08000000 0x40000>;

You can just add a single property like this:

power-domains = <&sram_pd 0>, <&sram_pd 1>, <&sram_pd 2>;

The knowledge of what range each PD controls is encoded in the fact
that the node is a "nxp,lpc3220-sram" and the information would stay
in your driver.

Of course, if there's a lot of variation in sizes and domains, we may
want to fully describe things in the DT.

>         };
>
> Or should I add the new compatible to device nodes of each of the power
> manageable banks?
>
> 2) I assume that "sram-bank@" device nodes still should be descendants
> of "sram@" node, but because children with "reg" property of "mmio-sram"
> compatible device node can not be used to describe power manageable banks,
> what name for an umbrella device node would you suggest? Would "banks" be
> good enough? Should it have its own compatible?

I don't think you need all this, but in general you want to have
compatible strings in each node (though there are many exceptions).

> 3) Do you think that reserved areas nodes should be placed under their
> own device node with probably own compatible? So, something like it
> was done recently with MTD partitions (compatible = "fixed-partitions").

If we did go down the path of have 2 sets of ranges, then yes.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
