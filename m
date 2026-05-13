Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF4390616
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650486; cv=none; b=tzSVDvjM77hCl6/X5VfPsxYohFfazEuPW2bvSoK5wfYWbJot5c6CAYznqYlsoXikrgmG1bpwYZbERdyvQ+ulvpiEDDjcm1wrPHtKYvrU18IH+p0StU2mow+CknjgpdmBguHcWqrS3NqXomSl05dpMgYdF3hKhEgMB0v//gavCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650486; c=relaxed/simple;
	bh=2dm9LJzKS2vHlnPyimeXOnAI0qwpLFhX3y1a2u/Y9Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQIIbTEWuCaMQt2luT5mGavMpPtJJuSm/swTN/x6dlE0z4610VGsigCaGPlf+/P5iO0bi9C+qNONyaVO8SkyQ0lfsisTjXK9wYanMDl5vi71l0Bb+f7/8H1ir9mhRS2bLQr5keFpNe7Zr+Q0SPFpfZm+ygbwmTaX3uSBxm/GZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8gM3oBs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8gM3oBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FC9C2BCFA
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650485;
	bh=2dm9LJzKS2vHlnPyimeXOnAI0qwpLFhX3y1a2u/Y9Bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8gM3oBsbHV8k34o9bhkyMz0b5wdcK8C/sgC+p5gbihq2la7ktttWgVB3vtArXM+1
	 a1cANCChgi94ji6Jt2qiuhzfW8fgQLwCYQzDR+c50iWBPXqWI9DBUhoi6w8fTKbEvL
	 QSWCrAu8neKj7OqQ67rVcJ5ZtLhs4mAaPXnBChN0sEhB3Tkh0mE/beenNUP2q7IAKZ
	 PPRCCPEhFGz7kJF16oOYq1AqQwPgxysQjE1rfDDtBAMlkcpYfwVYgP0GGxDQpvK5fD
	 R9FVrGgfiEBeS1/rzLPTDZaTLyT0s8jE2d5zAdenyru+xuLG/IZ9DaJ6K5vYjeokGg
	 FqV2o9LefrMgg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso9254420a12.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 22:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9efZ7s08QNBHtn5YPppagLusWkyq1E1A5J4wszssnNcDyc0UaAevTwyNF3hL3/cbjJhlOENa8QCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPGAha+6u62K/wPZ9UP9yrW5a59QTKjiheGt52RPh53vUIxDQ
	9OAg/AzxzB7Wp4kKDsspQ/+r+V6gxRa69HWI8VU7paaQpvi/4WGEHi/TMSJHBbRiswwwVmD2Dxf
	jr1/JmDS+h96V7oF2i07BKeh74xUlUOc=
X-Received: by 2002:a17:906:8d8b:b0:ba4:94f8:4df with SMTP id
 a640c23a62f3a-bd3bfb8f581mr101033666b.17.1778650484437; Tue, 12 May 2026
 22:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-7-ulf.hansson@linaro.org> <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
 <CAPDyKFoxJ8AOyqzbEQc8x-e5fRf0p3faE23PRNcbA4aPSY_cdg@mail.gmail.com>
In-Reply-To: <CAPDyKFoxJ8AOyqzbEQc8x-e5fRf0p3faE23PRNcbA4aPSY_cdg@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Tue, 12 May 2026 22:34:28 -0700
X-Gmail-Original-Message-ID: <CACRMN=cyMjHtW1xjoYPWa8_TjmQEoJBvKtMo-UgP5yZJ=zDh2Q@mail.gmail.com>
X-Gm-Features: AVHnY4LyfY4cUuXax6ixWmnl65gxoZBZuMNMRgoV0xiInOYdE0OY_bavPn835OQ
Message-ID: <CACRMN=cyMjHtW1xjoYPWa8_TjmQEoJBvKtMo-UgP5yZJ=zDh2Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] pmdomain: core: Add initial fine grained
 sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 3:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> wrot=
e:
> >
> > On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > A onecell (#power-domain-cells =3D <1 or 2>; in DT) power domain prov=
ider
> > > typically provides multiple independent power domains, each with thei=
r own
> > > corresponding consumers. In these cases we have to wait for all consu=
mers
> > > for all the provided power domains before the ->sync_state() callback=
 gets
> > > called for the supplier.
> > >
> > > In a first step to improve this, let's implement support for fine gra=
ined
> > > sync_state support a per genpd basis by using the ->queue_sync_state(=
)
> > > callback. To take step by step, let's initially limit the improvement=
 to
> > > the internal genpd provider driver and to its corresponding genpd dev=
ices
> > > for onecell providers.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > >         - Addressed some cosmetic comments from Geert.
> > >
> > > ---
> > >  drivers/pmdomain/core.c   | 124 ++++++++++++++++++++++++++++++++++++=
++
> > >  include/linux/pm_domain.h |   1 +
> > >  2 files changed, 125 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index ad57846f02a3..c01a9a96e5c2 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -2699,6 +2699,119 @@ static struct generic_pm_domain *genpd_get_fr=
om_provider(
> > >         return genpd;
> > >  }
> > >
> > > +static bool genpd_should_wait_for_consumer(struct device_node *np)
> > > +{
> > > +       struct generic_pm_domain *genpd;
> > > +       bool should_wait =3D false;
> > > +
> > > +       mutex_lock(&gpd_list_lock);
> > > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> > > +                       genpd_lock(genpd);
> > > +
> > > +                       /* Clear the previous state before reevaluati=
ng. */
> > > +                       genpd->wait_for_consumer =3D false;
> > > +
> > > +                       /*
> > > +                        * Unless there is at least one genpd for the=
 provider
> > > +                        * that is being kept powered-on, we don't ha=
ve to care
> > > +                        * about waiting for consumers.
> > > +                        */
> > > +                       if (genpd->stay_on)
> > > +                               should_wait =3D true;
> > > +
> > > +                       genpd_unlock(genpd);
> > > +               }
> > > +       }
> > > +       mutex_unlock(&gpd_list_lock);
> >
> > I think I understand the intent of this function, but haven't dug into
> > genpd code enough to comment on this yet. I'll come back to this
> > later.
> >
> > > +
> > > +       return should_wait;
> > > +}
> > > +
> > > +static void genpd_parse_for_consumer(struct device_node *sup,
> > > +                                    struct device_node *con)
> > > +{
> > > +       struct generic_pm_domain *genpd;
> > > +
> > > +       for (unsigned int i =3D 0; ; i++) {
> > > +               struct of_phandle_args pd_args;
> > > +
> > > +               if (of_parse_phandle_with_args(con, "power-domains",
> > > +                                              "#power-domain-cells",
> > > +                                              i, &pd_args))
> > > +                       break;
> >
> > Why not use a while or a do while() instead of this infinite for loop
> > with a break?
>
> I guess it's a matter of personal preference. I'm not sure the code
> gets any nicer with a do/while, but if you really insist I can change
> it.
>
> >
> > > +
> > > +               /*
> > > +                * The phandle must correspond to the supplier's genp=
d provider
> > > +                * to be relevant else let's move to the next index.
> > > +                */
> > > +               if (sup !=3D pd_args.np) {
> > > +                       of_node_put(pd_args.np);
> > > +                       continue;
> > > +               }
> > > +
> > > +               mutex_lock(&gpd_list_lock);
> > > +               genpd =3D genpd_get_from_provider(&pd_args);
> > > +               if (!IS_ERR(genpd)) {
> > > +                       genpd_lock(genpd);
> > > +                       genpd->wait_for_consumer =3D true;
> > > +                       genpd_unlock(genpd);
> > > +               }
> > > +               mutex_unlock(&gpd_list_lock);
> > > +
> > > +               of_node_put(pd_args.np);
> > > +       }
> > > +}
> > > +
> > > +static void _genpd_queue_sync_state(struct device_node *np)
> > > +{
> > > +       struct generic_pm_domain *genpd;
> > > +
> > > +       mutex_lock(&gpd_list_lock);
> > > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> > > +                       genpd_lock(genpd);
> > > +                       if (genpd->stay_on && !genpd->wait_for_consum=
er) {
> > > +                               genpd->stay_on =3D false;
> > > +                               genpd_queue_power_off_work(genpd);
> > > +                       }
> > > +                       genpd_unlock(genpd);
> > > +               }
> > > +       }
> > > +       mutex_unlock(&gpd_list_lock);
> > > +}
> > > +
> > > +static void genpd_queue_sync_state(struct device *dev)
> > > +{
> > > +       struct device_node *np =3D dev->of_node;
> > > +       struct device_link *link;
> > > +
> > > +       if (!genpd_should_wait_for_consumer(np))
> > > +               return;
> > > +
> > > +       list_for_each_entry(link, &dev->links.consumers, s_node) {
> >
> > Couple of issues:
> > 1. I don't want the frameworks to be so deeply aware of driver core
> > internals. I want the driver core maintainers to be able to change the
> > devlink implementation without having to worry about going and fixing
> > all the frameworks. So, please add a for_each_consumer_dev(supplier,
> > callback) and for_each_supplier_dev(consumer, callback) helper
> > functions.
>
> I understand your concern and I like the idea. However, maybe it's
> better to get this landed (the series is complicated as is) first and
> then can continue to improve the code on top, with helper functions
> etc.

That patch should be pretty simple, so let's just do it? You are
literally just moving the code to another file and massaging it a bit.
I can send one out if you want/

> >
> > 2. This doesn't ignore "SYNC_STATE_ONLY" links and that's going to
> > confuse the consumer count/check you might do or at the least waste
> > parsing those.
>
> I am not sure I understand how I should take SYNC_STATE_ONLY links
> into account here.
>
> At each call to the genpd_queue_sync_state(), we walk through all the
> provided genpds for the provider. No previous state is cached to track
> consumer counts.

Ok, correct me if I'm wrong here, but it looks like you are looking at
all the consumers, finding the ones that haven't probed yet and then
trying to see which specific genpd provider each one of them is using
by parsing their dt properties and then keep those ON.

If my understanding above is wrong then, please help me understand
what the code is trying to do.

If it's right, then here's the issue:

fw_devlink relies on device links and fwnode links to keep track of
consumers. fwnode links get created first and then get converted to
device links when both the supplier AND consumer devices are created.

Consider a case when the supplier S is created and the consumer device
C is several levels deep inside a parent device A.
S { #power-domain-cells =3D <1>; }
A { B { C { power-domains =3D <&S MY_DOMAIN>; } } }

fw_devlink can't just go "oh there's no consumer device that hasn't
probed yet, let me call sync_state()". It needs to wait for C. But
there's no way to create a device link to C. So, here's the sequence
that happens:

1. When device A gets added, it creates a "proxy" SYNC_STATE_ONLY link
between S and A.
2. When A probes, it adds device B.
3. The SYNC_STATE_ONLY link between S to B is created.
4. The SYNC_STATE_ONLY link between S to A is deleted.
5. When B probes, it adds device C.
6. The actual device link between S and C is created.
7. The SYNC_STATE_ONLY link between S to B is deleted.
8. Device C probes, the device links get updated, sync_state() gets called.

So, if your code doesn't account for SYNC_STATE_ONLY links, you are
going to check device "A" to see which providers are used. You'll
think that MY_DOMAIN isn't used by any unprobed consumer and turn it
off.

>
> >
> > 3. **Device** links are not the complete list of consumers because
> > they can only link consumer **devices** once the consumer **device**
> > is created.
> >
> > 4. What you really need is a for_each_consumer_fwnode(supplier,
> > callback) that first loops through all the consumer device links and
> > calls the callback() on their fwnode and then the same function needs
> > to loop through all the fwnode links and then pass those consumer
> > fwnodes to the callback. And inside that callback you can do whatever
> > you want.
>
> The ->queue_sync_state() callback is invoked *after*
> __device_links_queue_sync_state() has been called for the device,
> which is also when the conditions for calling ->sync_state() is
> checked.

I'm not sure what you are trying to say here. Yes, what you are saying
is true. But at the point the current code returns before calling
sync_state(), your patch 2/13 ends up calling the "consumer_probed()"
callback.

If you see the example I gave above, there is a SYNC_STATE_ONLY link
all the way up to step 7 that'll prevent sync_state() from being
called. And until step 5, there is no device link between S and C and
you'll have to go look at S's fwnode links to find C.

> If there are problems with not yet registered consumer device links,
> why isn't that as problem for regular ->sync_state() in
> __device_links_queue_sync_state()?

Does my explanation above make sense?

Welcome to the annoying worlds of fw_devlink corner cases/nuances.
There's a case where the child is the supplier of the
parent/grandparent. There's a comment for that in the fw_devlink code.

Thanks,
Saravana

> >
> > 5. You might want to add a for_each_inactive_consumer(supplier,
> > callback) too to simplify your need for checking if a fwnode has a
> > device and then checking if it's probed.
> >
> > Thanks,
> > Saravana
> >
> >
> > > +               struct device *consumer =3D link->consumer;
> > > +
> > > +               if (!device_link_test(link, DL_FLAG_MANAGED))
> > > +                       continue;
> > > +
> > > +               if (link->status =3D=3D DL_STATE_ACTIVE)
> > > +                       continue;
> > > +
> > > +               if (!consumer->of_node)
> > > +                       continue;
> > > +
> > > +               /*
> > > +                * A consumer device has not been probed yet. Let's p=
arse its
> > > +                * device node for the power-domains property, to fin=
d out the
> > > +                * genpds it may belong to and then prevent sync stat=
e for them.
> > > +                */
> > > +               genpd_parse_for_consumer(np, consumer->of_node);
> > > +       }
> > > +
> > > +       _genpd_queue_sync_state(np);
> > > +}
> > > +
>
> [...]
>
> Kind regards
> Uffe
