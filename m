From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Date: Fri, 21 Dec 2018 18:40:08 +0000
Message-ID: <c1518533-ccc0-1a82-31b4-959682fb9b9e@axentia.se>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <20181221145022.umsugdwadw5a5ag6@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221145022.umsugdwadw5a5ag6@ninjato>
Content-Language: en-US
Content-ID: <02D913DAABD69147955C10E49A5487A1@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2018-12-21 15:50, Wolfram Sang wrote:
>=20
>>>> I think this might be as simple as adding:
>>>>
>>>> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
>>>> 		return -ESHUTDOWN;
>=20
> Peter, I think this should work for muxes, too, or? The i2c_transfer()
> call to the mux will not be rejected, but it will be later when we reach
> the root adapter. And then the error code will be pushed down the tree
> until we arrive at the mux again. So, the rejection will not happen at
> the earliest time, but it will happen. Is my understanding correct?

Yes, I agree with that analysis. All mux actions eventually end up with
an __i2c_transfer() call on the relevant root adapter. Hmm, but not *all*
calls. How about SMBus adapters? Should there not be a similar WARN_ON
in __i2c_smbus_xfer?

But maybe that's not applicable for some reason? Just asking...

Cheers,
Peter
