From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Sat, 13 Jun 2015 15:50:55 +0200
Message-ID: <20150613135055.GQ19653@lukather>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
 <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
 <5577EDD9.8020900@redhat.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/5eNASeIIpuMggS"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBOHM6CVQKGQE7NWUBJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5577EDD9.8020900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: wens-jdAy2FN1RRM@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--o/5eNASeIIpuMggS
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Jun 10, 2015 at 09:57:13AM +0200, Hans de Goede wrote:
> >>@@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
> >>                 .resources              = axp20x_pek_resources,
> >>         }, {
> >>                 .name                   = "axp20x-regulator",
> >>+       }, {
> >>+               .name                   = "axp20x-usb-power-supply",
> >
> >Could we use either "vbus-power-supply" to match the AXP datasheets,
> >or "otg-power-supply" which is slightly more obvious to board owners?
> 
> I do not like the vbus name, since it does not indicate which bus
> it is, OTOH you are right that is what it is called in the datasheet.
> 
> As for using otg, I think that usb is better then.
> 
> All in all I believe that the current usb name is best, but if others
> disagree I'm open to renaming this.
> 
> So anyone else have an opinion on what would be a good name for the
> cell and the compatible ?

I usually prefer to use the name mentionned in the datasheet, but if
that doesn't make sense, feel free to use an alternative like this
one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--o/5eNASeIIpuMggS--
