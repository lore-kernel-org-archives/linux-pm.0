From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 00/18] add support for AXP20X and AXP22X
 power supply drivers
Date: Wed, 15 Mar 2017 23:46:47 +0100
Message-ID: <20170315224647.suhnptpczykuoffd@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
Reply-To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqlgowxaqelmwsf2"
Return-path: <linux-sunxi+bncBDXMLNOH5ANRBXEIU7DAKGQECIMFXAQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <bc829791-c543-220a-8c42-1023b1a82963-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--qqlgowxaqelmwsf2
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Mar 15, 2017 at 02:18:56PM +0100, Quentin Schulz wrote:
> Hi Lee,
> 
> On 15/03/2017 13:14, Lee Jones wrote:
> > On Wed, 15 Mar 2017, Quentin Schulz wrote:
> > 
> >> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
> >> information and data of the various power supplies they support such as
> >> ACIN, battery and VBUS. For example, they expose the current battery
> >> voltage, charge or discharge, as well as ACIN and VBUS current voltages
> >> and currents, internal PMIC temperature and ADC on 2 different GPIOs
> >> when in the right mode (for the AXP209 only).
> > 
> > What are you missing from this set now?  What Acks etc?  And what's
> > the plan with regards to route to Mainline?  Where are the dependencies
> > etc?
> > 
> 
> Basically, a consensus on how we should named the DT property I added in
> patch 01 and 02 (which is used afterwards in battery driver). All other
> patches have ACKs.
> 
> I added some logic to the battery driver so if anyone wants to review
> that you're welcome. I already got several ACKs from the v3 though.
> 
> No dependencies except for the battery driver (and the first two
> patches) which needs the battery "framework" in the Power Supply
> subsystem. A v9 of this framework has been sent a little bit more than a
> week ago, I need this to be merged first or the battery driver will just
> not compile. I think the other patches are ready to be merged.

FWIW I expect, that the axp battery patches go through my tree, since
there doesn't seem to be a compile time dependency to the other
patches from this series nor vice versa. I'm aware of the dependency
to the bq27xxx series of course.

-- Sebastian
--qqlgowxaqelmwsf2--
