From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 11/18] dt-bindings: power: supply: add
 AXP20X/AXP22X battery DT binding
Date: Thu, 16 Mar 2017 00:02:29 +0100
Message-ID: <20170315230229.woqzt6dthzmpuohd@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
 <20170315222852.z2qrwoexcsjt7vs6@earth>
 <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
Reply-To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efz7gnmstlbr6cht"
Return-path: <linux-sunxi+bncBDXMLNOH5ANRBDMQU7DAKGQEAQNFM6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <761e35fc-932a-953c-cfad-7e967ea3d126-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--efz7gnmstlbr6cht
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Wed, Mar 15, 2017 at 11:41:07PM +0100, Quentin Schulz wrote:
> Hi,
> 
> On 15/03/2017 23:28, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Mar 15, 2017 at 11:55:30AM +0100, Quentin Schulz wrote:
> >> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> >>
> >> This patch adds the DT binding documentation for the battery power
> >> supply which gets various data from the PMIC, such as the battery status
> >> (charging, discharging, full, dead), current max limit, current current,
> >> battery capacity (in percentage), voltage max and min limits, current
> >> voltage and battery capacity (in Ah).
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > I suggest to do "s/battery-power-supply/battery-fuel-gauge/g"
> > 
> 
> The IP is way more than a simple fuel gauge, you have info about the
> voltage, current, you can set different things, even though you have the
> percentage of the battery returned by the PMIC.

Most chips sold under the label battery-fuel-gauges actually give
you that kind of information ;)

> Does it really make sense to rename it that way?

If everybody is fine with it I don't mind too much.

-- Sebastian
--efz7gnmstlbr6cht--
