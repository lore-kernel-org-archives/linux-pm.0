From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Wed, 24 Jun 2015 14:18:48 +0200
Message-ID: <CAOMqctS=-Go-ETa=G__4hpBc13GJ7M7D3c0EUnQxc-a_fyX1rA@mail.gmail.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com> <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
 <5577EDD9.8020900@redhat.com> <20150613135055.GQ19653@lukather>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCQMLUOX54MBBT6AVKWAKGQE3WMEM5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150613135055.GQ19653@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 13 June 2015 at 15:50, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Wed, Jun 10, 2015 at 09:57:13AM +0200, Hans de Goede wrote:
>> >>@@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
>> >>                 .resources              = axp20x_pek_resources,
>> >>         }, {
>> >>                 .name                   = "axp20x-regulator",
>> >>+       }, {
>> >>+               .name                   = "axp20x-usb-power-supply",
>> >
>> >Could we use either "vbus-power-supply" to match the AXP datasheets,
>> >or "otg-power-supply" which is slightly more obvious to board owners?
>>
>> I do not like the vbus name, since it does not indicate which bus
>> it is, OTOH you are right that is what it is called in the datasheet.
>>
>> As for using otg, I think that usb is better then.
>>
>> All in all I believe that the current usb name is best, but if others
>> disagree I'm open to renaming this.
>>
>> So anyone else have an opinion on what would be a good name for the
>> cell and the compatible ?
>
> I usually prefer to use the name mentionned in the datasheet, but if
> that doesn't make sense, feel free to use an alternative like this
> one.

The power source is known as USB power since the reference Allwinner
design connects this pin to the USB OTG connector and all known boards
that use the AXP copy the design.

If somebody gets creative with the vbus input or there is another
manufacturer using AXP with different design it might get problematic
naming it usb.

However, either name is pretty much arbitrary and there is no need for
the vbus to be connected to a bus connector. You could design a board
with two plain power jacks and the AXP would switch between those
according to its priority. If this priority is not configurable then I
think it would be most descriptive to name the inputs as primary and
secondary AC.

The most important part is adding proper documentation so whatever the
name the user can understand that this is the part that is called vbus
in datasheed and is typically wired to the usb otg port.

I only found very terse doc patch.
It adds a new file without a reference in the main axp20x file. IMHO
there should be a reference for the sub-nodes or they should be all in
one file. Spreading the text into multitude of files that contain 2
lines of explanation and an example seems counter-productive. The
examples can be combined in one.

Another nit is that the doc shows axp202-usb-power-supply compatible
while the usb power is available on all AXP regulators for which there
are drivers since axp152. IMHO this can be just
x-powers,usb-power-supply since it can only appear as subnode of the
axp, anyway.

Thanks

Michal
