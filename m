From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: bq24735 charger and ac-detect
Date: Wed, 14 Dec 2016 17:22:26 +0000
Message-ID: <e053d0ca-53d0-d458-1b8c-0ecee0fa1f8b@nvidia.com>
References: <d796f6f9-1b6a-647c-100b-b3e85fc2f4c0@axentia.se>
 <20161214142502.su4auesnlqmgxspv@earth>
 <20161214145951.uuoijetzat2bxmbv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214145951.uuoijetzat2bxmbv@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 14/12/16 14:59, Sebastian Reichel wrote:
> * PGP Signed by an unknown key
> 
> Hi,
> 
> Ok, Darbha Sriharsha's mail address no longer works, so I Cc'd
> linux-tegra instead. Maybe some of the people there have the
> schematics for one of the Tegra boards using the bq24735 and/or
> could check if charger presence detection actually works on
> those boards with current mainline kernel.

I just gave this a quick test on my tegra124-nyan-big with v4.9 and I do
see the status for the bq24735 switching from "Charging" to "Not
charging" when plugging and unplugging the charger.

Please note for this board, the bq24735 is connected to the Google
chrome EC (embedded controller) and not directly to Tegra. If you look
at the device-tree source, tegra124-nyan.dtsi, you will see there is
this ec-i2c-tunnel that is exposing the device to the kernel.

Cheers
Jon

-- 
nvpublic
