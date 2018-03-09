From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 3/6] power: supply: axp20x_battery: use
 data struct for variant specific code
Date: Fri, 9 Mar 2018 18:04:22 +0100
Message-ID: <20180309170422.svf2covhrtxgnj5o@qschulz>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <c157320cf4c443e6904346c9072f46e713498161.1519813976.git-series.quentin.schulz@bootlin.com>
 <20180309160825.fde2am6jo6qs6vp6@earth.universe>
Reply-To: quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qghohmptoyiqutrd"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBGP5RLKQKGQEYPUE4RQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180309160825.fde2am6jo6qs6vp6-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--qghohmptoyiqutrd
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi Sebastian,

On Fri, Mar 09, 2018 at 05:08:25PM +0100, Sebastian Reichel wrote:
> Hi Quentin,
> 
> On Wed, Feb 28, 2018 at 11:35:58AM +0100, Quentin Schulz wrote:
> > We used to use IDs to select a function or a feature depending on the
> > variant. It's easier to maintain the code by adding data structure
> > storing the few differences between variants so that we don't add a pile
> > of if conditions.
> > 
> > Let's use this data structure and update the code to use it.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> > ---
> 
> I applied this, but modified the patch slightly, so that
> it actually calls your new set_max_voltage() callback in
> axp20x_battery_set_prop(). Please check that the resulting
> patch looks correct to you:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=648badd797c762a713b48afc3b67d56abdd0073b
> 

You actually fixed an error in this patch while doing so, so thank you :)

Looks good to me.

Quentin
--qghohmptoyiqutrd--
