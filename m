From: Simon Arlott <simon-A6De1vDTPLDsq35pWSNszA@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: Add brcm,bcm63xx-regulator device tree
 binding
Date: Thu, 3 Dec 2015 23:38:28 +0000
Message-ID: <5660D274.7000402@simon.arlott.org.uk>
References: <565A18DD.60108@simon.arlott.org.uk>
 <20151130121043.GX1929@sirena.org.uk> <565CB1CF.5040306@simon.arlott.org.uk>
 <20151201221615.GY1929@sirena.org.uk>
 <b7ecdc8ebcdf9582620c22b0e8a4a96d24ba67c1@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <20151202125325.GI1929@sirena.org.uk> <565F53FC.5080309@simon.arlott.org.uk>
 <20151203000631.GM1929@sirena.org.uk> <565FF9E9.1090503@simon.arlott.org.uk>
 <20151203150528.GG5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151203150528.GG5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 03/12/15 15:05, Mark Brown wrote:
> On Thu, Dec 03, 2015 at 08:14:33AM +0000, Simon Arlott wrote:
>> On 03/12/15 00:06, Mark Brown wrote:
> 
>> > this it should know at least something about how to control the device
>> > from the compatible string.  If you're making a generic driver it should
>> > not make reference to specific devices.
> 
>> Will you accept a generic driver for a simple enable regulator device on
>> a regmap? What should its compatible string be?
> 
> Perhaps.  I really don't like putting the entire driver into DT, it's
> not a pattern I want to encourage.

I don't like putting the list of which bit is which regulator name into
a driver because it means that new hardware that adds a regulator or
moves them around requires a change to the driver.

Documentation/devicetree/usage-model.txt:
  2.1 High Level View
  -------------------
  [...] Using
  it allows board and device support to become data driven; to make
  setup decisions based on data passed into the kernel instead of on
  per-machine hard coded selections.

I agree that an entire driver shouldn't be put in the DT (especially
given that you then need the DT to debug any issue), but this isn't much
of a driver when it involves flipping a single bit.

The key thing would be to avoid it growing into something too complex
(e.g. set register X to 42 to enable and set register Y to 90 to
disable, would not belong in DT).

Should I be looking at trying to use generic_pm_domain instead of a
regulator? Those don't appear to require a name so a phandle with an
argument for the bit would work.

>> > There could be one if it would help, but we do normally manage to do
>> > this without - look at how other regulator drivers work.
> 
>> Several of them have a fixed list of supported regulator names in the
> 
> Yes, that's the way this is handled.

I see two variants of the hardware bits (three if you consider that the
GMAC isn't on every SoC):

#define MISC_IDDQ_CTRL_GMAC         (1<<18)
#define MISC_IDDQ_CTRL_WLAN_PADS    (1<<13)
#define MISC_IDDQ_CTRL_PCIE         (1<<12)
#define MISC_IDDQ_CTRL_FAP          (1<<11)
#define MISC_IDDQ_CTRL_VDSL_MIPS    (1<<10)
#define MISC_IDDQ_CTRL_VDSL_PHY     (1<<9)
#define MISC_IDDQ_CTRL_PERIPH       (1<<8)
#define MISC_IDDQ_CTRL_PCM          (1<<7)
#define MISC_IDDQ_CTRL_ROBOSW       (1<<6)
#define MISC_IDDQ_CTRL_USBD         (1<<5)
#define MISC_IDDQ_CTRL_USBH         (1<<4)
#define MISC_IDDQ_CTRL_DECT         (1<<3)
#define MISC_IDDQ_CTRL_MIPS         (1<<2)
#define MISC_IDDQ_CTRL_IPSEC        (1<<1)
#define MISC_IDDQ_CTRL_SAR          (1<<0)

#define MISC_IDDQ_CTRL_EPHY         (1<<9)
#define MISC_IDDQ_CTRL_ROBOSW       (1<<8)
#define MISC_IDDQ_CTRL_PCIE         (1<<7)
#define MISC_IDDQ_CTRL_USBH         (1<<6)
#define MISC_IDDQ_CTRL_USBD         (1<<5)
#define MISC_IDDQ_CTRL_PCM          (1<<4)
#define MISC_IDDQ_CTRL_SAR          (1<<3)
#define MISC_IDDQ_CTRL_ADSL2_AFE    (1<<2)
#define MISC_IDDQ_CTRL_ADSL2_PHY    (1<<1)
#define MISC_IDDQ_CTRL_ADSL2_MIPS   (1<<0)

I could put these lists of bits in a driver (associated with the names)
but I'd strongly prefer to put the list of bits in the DT.

If they are in the driver, then there is nothing to stop someone from
deciding to force it to fit a different new piece of hardware by
deliberately using the wrong names in the DT just because they match
the bits they want to use, and they think they can't wait for a new 
list of bits to be added to the kernel.

e.g. someone adds an LTE chip and reuses the obsolete DECT regulator:

misc_iddq_ctrl@42 {
  compatible = "...-regulator";
  reg = <0x42>;

  regulators {
    lte_power: dect {
      regulator-name = "LTE";
    };
  };
};

Associating the bits with the names in the DT avoids this problem at
the expense of having a very generic driver.

A lot of the existing regulator drivers have mostly numbered regulator
pins which could have been connected to anything on a hardware variant.

>> driver. The regulator names for this device are meaningless to the
>> driver because all of the regulators look the same. They don't have a
>> known or controllable voltage and can only be turned on or off.
> 
> Nonsense.  The names are useful to identify which supply is being
> referred to.  Having voltage control is irrelevant to identifying
> regulators.

Ok, but from the driver's point of view there's nothing different about
any of the regulators on this hardware. I could have numbered them
"BIT0" to "BIT31" in the driver and used a meaningful alias in DT.

>> Any table mapping regulator names to bits in the register would be
>> different for each SoC making the list of regulator names in the device
>> tree redundant. If they're not listed in the device tree then I can't
>> use them as a phandle for other devices.
> 
> The list of regulator nodes in device tree is not redundant, it is as
> you say used to connect things together.  The question is where to put
> the control data for those regulators (in this case the enable time and
> the switch).

Ok, I hadn't considered that regulator names could be in DT without
any enable bit information when this was in the driver.

-- 
Simon Arlott
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
