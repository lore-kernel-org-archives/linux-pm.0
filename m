Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128523EAB4
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718447; cv=none; b=ic+EG3Vq4U+PQBjpiZQsu+dzQO+HuWGSA5+wqjrsB9oK+9RIpDODkVyQnBbizc+GaKrxyndA1fuIRl6pS8RG+Dsvge8HMC5iwtjyN5icX6WL+YIJzRVlEApN4qwIMpH11uJCIZg6QopBAsJjlpJOr2AgPWANNjGu6UwUDIj8fVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718447; c=relaxed/simple;
	bh=9CnkQ2eQSgYNEiAXmddD5ZKdJNApuoRzdjkAI/93S+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPjo2UqB+FJfpOfvg7x+G1W5HQCuNjU6EZpNt+C/CCdu70SS2qmFbvC4CSdkDFneumHvECkfiM7Hjmyyivd3fgwVJ3mP0Kg/+zpiVXyfB/8UHAKlhTAu0jBmxtFyu31aEE15oOj0zh8Jm127U9VeW1b/0+SiYVbZCvBxJDTfHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGxZPMeU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGxZPMeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6E7C2BCF7
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778718447;
	bh=9CnkQ2eQSgYNEiAXmddD5ZKdJNApuoRzdjkAI/93S+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JGxZPMeU/bJRlCjbF3Db5EtDIuKIUld7GdizUYStLcSrK+20TLn/EBl5dXk6uFwxv
	 GIpgQbf461a9iGpSBGXKjNPW4p+wn23EgoYgxhTFT4Zmhyhi0grQLko1FaOe50BlMm
	 68VJAwRTu1KH8uvUlbghbiQkESzTUGB1YFbsSriunzueRfrNPJW3RFP/IrHa96zaVL
	 UkAiLcMZeJKyi9W3ZV0Nk1xbtXQ+PfOmQkyT/3UjUpz2cgP4Q+W6ifoWH2dmewmQ+m
	 XIufpfAd1ghQiFO74ZL4HmbkJjhnDJ1zCQk/g8lF731f/JyuBNStPPtB0vQPYitny1
	 y1O1n+cPhZrOQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso14524509a12.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:27:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Bd4x0Ku30JNpTgLTzk3Ak4h8UJQ5mEFSWTTIGEIBKzDFlIjE9yaxr8CgnfKGCE9MH+wrMbfh6Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7wVmXw8sL9veGYhPqFOn/dINGLDkdXYIyRdW4nHuB56OMNLt
	xmiqfNxKlGH2iq1FBRvbwRlsNkw2r/wT6UgQMdxvvKsN0HEquJaBBzJmRE+sdWPZc1DIUAyKuC5
	xAoi9GohXbqxldJ1tN3UESttbndvE9gI=
X-Received: by 2002:a05:6402:428e:b0:65f:71ed:7ab9 with SMTP id
 4fb4d7f45d1cf-682a78152fbmr2904077a12.22.1778718445647; Wed, 13 May 2026
 17:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-7-ulf.hansson@linaro.org> <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
 <CAPDyKFoxJ8AOyqzbEQc8x-e5fRf0p3faE23PRNcbA4aPSY_cdg@mail.gmail.com>
 <CACRMN=cyMjHtW1xjoYPWa8_TjmQEoJBvKtMo-UgP5yZJ=zDh2Q@mail.gmail.com> <CAPDyKFo4yoxGtvKNzCfTY0tOwPPxo+Ub7=VvCKtVPr3M31o=YA@mail.gmail.com>
In-Reply-To: <CAPDyKFo4yoxGtvKNzCfTY0tOwPPxo+Ub7=VvCKtVPr3M31o=YA@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Wed, 13 May 2026 17:27:14 -0700
X-Gmail-Original-Message-ID: <CACRMN=cZKAPvbZTL3afJYfDJpK2SnaVP6mKjEjaTA8Tv3j-3-w@mail.gmail.com>
X-Gm-Features: AVHnY4Jr_Yv1XU1ejQGCAHmNdFwos_M-HbxW_VgoUYxvc0xtkVekoKwIu_nja8E
Message-ID: <CACRMN=cZKAPvbZTL3afJYfDJpK2SnaVP6mKjEjaTA8Tv3j-3-w@mail.gmail.com>
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

On Wed, May 13, 2026 at 2:36=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 13 May 2026 at 07:34, Saravana Kannan <saravanak@kernel.org> wrot=
e:
> >
> > On Mon, May 11, 2026 at 3:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> =
wrote:
> > > >
> > > > On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > > >
> > > > > A onecell (#power-domain-cells =3D <1 or 2>; in DT) power domain =
provider
> > > > > typically provides multiple independent power domains, each with =
their own
> > > > > corresponding consumers. In these cases we have to wait for all c=
onsumers
> > > > > for all the provided power domains before the ->sync_state() call=
back gets
> > > > > called for the supplier.
> > > > >
> > > > > In a first step to improve this, let's implement support for fine=
 grained
> > > > > sync_state support a per genpd basis by using the ->queue_sync_st=
ate()
> > > > > callback. To take step by step, let's initially limit the improve=
ment to
> > > > > the internal genpd provider driver and to its corresponding genpd=
 devices
> > > > > for onecell providers.
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > >         - Addressed some cosmetic comments from Geert.
> > > > >
> > > > > ---
> > > > >  drivers/pmdomain/core.c   | 124 ++++++++++++++++++++++++++++++++=
++++++
> > > > >  include/linux/pm_domain.h |   1 +
> > > > >  2 files changed, 125 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > > > index ad57846f02a3..c01a9a96e5c2 100644
> > > > > --- a/drivers/pmdomain/core.c
> > > > > +++ b/drivers/pmdomain/core.c
> > > > > @@ -2699,6 +2699,119 @@ static struct generic_pm_domain *genpd_ge=
t_from_provider(
> > > > >         return genpd;
> > > > >  }
> > > > >
> > > > > +static bool genpd_should_wait_for_consumer(struct device_node *n=
p)
> > > > > +{
> > > > > +       struct generic_pm_domain *genpd;
> > > > > +       bool should_wait =3D false;
> > > > > +
> > > > > +       mutex_lock(&gpd_list_lock);
> > > > > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > > > > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) =
{
> > > > > +                       genpd_lock(genpd);
> > > > > +
> > > > > +                       /* Clear the previous state before reeval=
uating. */
> > > > > +                       genpd->wait_for_consumer =3D false;
> > > > > +
> > > > > +                       /*
> > > > > +                        * Unless there is at least one genpd for=
 the provider
> > > > > +                        * that is being kept powered-on, we don'=
t have to care
> > > > > +                        * about waiting for consumers.
> > > > > +                        */
> > > > > +                       if (genpd->stay_on)
> > > > > +                               should_wait =3D true;
> > > > > +
> > > > > +                       genpd_unlock(genpd);
> > > > > +               }
> > > > > +       }
> > > > > +       mutex_unlock(&gpd_list_lock);
> > > >
> > > > I think I understand the intent of this function, but haven't dug i=
nto
> > > > genpd code enough to comment on this yet. I'll come back to this
> > > > later.
> > > >
> > > > > +
> > > > > +       return should_wait;
> > > > > +}
> > > > > +
> > > > > +static void genpd_parse_for_consumer(struct device_node *sup,
> > > > > +                                    struct device_node *con)
> > > > > +{
> > > > > +       struct generic_pm_domain *genpd;
> > > > > +
> > > > > +       for (unsigned int i =3D 0; ; i++) {
> > > > > +               struct of_phandle_args pd_args;
> > > > > +
> > > > > +               if (of_parse_phandle_with_args(con, "power-domain=
s",
> > > > > +                                              "#power-domain-cel=
ls",
> > > > > +                                              i, &pd_args))
> > > > > +                       break;
> > > >
> > > > Why not use a while or a do while() instead of this infinite for lo=
op
> > > > with a break?
> > >
> > > I guess it's a matter of personal preference. I'm not sure the code
> > > gets any nicer with a do/while, but if you really insist I can change
> > > it.
> > >
> > > >
> > > > > +
> > > > > +               /*
> > > > > +                * The phandle must correspond to the supplier's =
genpd provider
> > > > > +                * to be relevant else let's move to the next ind=
ex.
> > > > > +                */
> > > > > +               if (sup !=3D pd_args.np) {
> > > > > +                       of_node_put(pd_args.np);
> > > > > +                       continue;
> > > > > +               }
> > > > > +
> > > > > +               mutex_lock(&gpd_list_lock);
> > > > > +               genpd =3D genpd_get_from_provider(&pd_args);
> > > > > +               if (!IS_ERR(genpd)) {
> > > > > +                       genpd_lock(genpd);
> > > > > +                       genpd->wait_for_consumer =3D true;
> > > > > +                       genpd_unlock(genpd);
> > > > > +               }
> > > > > +               mutex_unlock(&gpd_list_lock);
> > > > > +
> > > > > +               of_node_put(pd_args.np);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static void _genpd_queue_sync_state(struct device_node *np)
> > > > > +{
> > > > > +       struct generic_pm_domain *genpd;
> > > > > +
> > > > > +       mutex_lock(&gpd_list_lock);
> > > > > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > > > > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) =
{
> > > > > +                       genpd_lock(genpd);
> > > > > +                       if (genpd->stay_on && !genpd->wait_for_co=
nsumer) {
> > > > > +                               genpd->stay_on =3D false;
> > > > > +                               genpd_queue_power_off_work(genpd)=
;
> > > > > +                       }
> > > > > +                       genpd_unlock(genpd);
> > > > > +               }
> > > > > +       }
> > > > > +       mutex_unlock(&gpd_list_lock);
> > > > > +}
> > > > > +
> > > > > +static void genpd_queue_sync_state(struct device *dev)
> > > > > +{
> > > > > +       struct device_node *np =3D dev->of_node;
> > > > > +       struct device_link *link;
> > > > > +
> > > > > +       if (!genpd_should_wait_for_consumer(np))
> > > > > +               return;
> > > > > +
> > > > > +       list_for_each_entry(link, &dev->links.consumers, s_node) =
{
> > > >
> > > > Couple of issues:
> > > > 1. I don't want the frameworks to be so deeply aware of driver core
> > > > internals. I want the driver core maintainers to be able to change =
the
> > > > devlink implementation without having to worry about going and fixi=
ng
> > > > all the frameworks. So, please add a for_each_consumer_dev(supplier=
,
> > > > callback) and for_each_supplier_dev(consumer, callback) helper
> > > > functions.
> > >
> > > I understand your concern and I like the idea. However, maybe it's
> > > better to get this landed (the series is complicated as is) first and
> > > then can continue to improve the code on top, with helper functions
> > > etc.
> >
> > That patch should be pretty simple, so let's just do it? You are
> > literally just moving the code to another file and massaging it a bit.
> > I can send one out if you want/
>
> Okay, I will fold in a patch into my series that adds the helper. No
> point you sending it as it needs to be apart of my series to have a
> user for it.

Ok, thanks.

>
> >
> > > >
> > > > 2. This doesn't ignore "SYNC_STATE_ONLY" links and that's going to
> > > > confuse the consumer count/check you might do or at the least waste
> > > > parsing those.
> > >
> > > I am not sure I understand how I should take SYNC_STATE_ONLY links
> > > into account here.
> > >
> > > At each call to the genpd_queue_sync_state(), we walk through all the
> > > provided genpds for the provider. No previous state is cached to trac=
k
> > > consumer counts.
> >
> > Ok, correct me if I'm wrong here, but it looks like you are looking at
> > all the consumers, finding the ones that haven't probed yet and then
> > trying to see which specific genpd provider each one of them is using
> > by parsing their dt properties and then keep those ON.
>
> The code cares only about the genpd OF provider that the supplier
> device belongs to, if any. Any other genpd OF providers and their
> genpds is untouched.
>
> The corresponding genpd OF provider may provide multiple genpds
> through the same fwnode.

Yeah, that's what I meant. Since I don't look at the genpd code often
I was conflating the "genpd OF provider" vs "genpd" terminology,

>
> >
> > If my understanding above is wrong then, please help me understand
> > what the code is trying to do.
> >
> > If it's right, then here's the issue:
> >
> > fw_devlink relies on device links and fwnode links to keep track of
> > consumers. fwnode links get created first and then get converted to
> > device links when both the supplier AND consumer devices are created.
> >
> > Consider a case when the supplier S is created and the consumer device
> > C is several levels deep inside a parent device A.
> > S { #power-domain-cells =3D <1>; }
> > A { B { C { power-domains =3D <&S MY_DOMAIN>; } } }
> >
> > fw_devlink can't just go "oh there's no consumer device that hasn't
> > probed yet, let me call sync_state()". It needs to wait for C. But
> > there's no way to create a device link to C. So, here's the sequence
> > that happens:
> >
> > 1. When device A gets added, it creates a "proxy" SYNC_STATE_ONLY link
> > between S and A.
> > 2. When A probes, it adds device B.
> > 3. The SYNC_STATE_ONLY link between S to B is created.
> > 4. The SYNC_STATE_ONLY link between S to A is deleted.
> > 5. When B probes, it adds device C.
> > 6. The actual device link between S and C is created.
> > 7. The SYNC_STATE_ONLY link between S to B is deleted.
> > 8. Device C probes, the device links get updated, sync_state() gets cal=
led.
> >
> > So, if your code doesn't account for SYNC_STATE_ONLY links, you are
> > going to check device "A" to see which providers are used. You'll
> > think that MY_DOMAIN isn't used by any unprobed consumer and turn it
> > off.
> >
> > >
> > > >
> > > > 3. **Device** links are not the complete list of consumers because
> > > > they can only link consumer **devices** once the consumer **device*=
*
> > > > is created.
> > > >
> > > > 4. What you really need is a for_each_consumer_fwnode(supplier,
> > > > callback) that first loops through all the consumer device links an=
d
> > > > calls the callback() on their fwnode and then the same function nee=
ds
> > > > to loop through all the fwnode links and then pass those consumer
> > > > fwnodes to the callback. And inside that callback you can do whatev=
er
> > > > you want.
> > >
> > > The ->queue_sync_state() callback is invoked *after*
> > > __device_links_queue_sync_state() has been called for the device,
> > > which is also when the conditions for calling ->sync_state() is
> > > checked.
> >
> > I'm not sure what you are trying to say here. Yes, what you are saying
> > is true. But at the point the current code returns before calling
> > sync_state(), your patch 2/13 ends up calling the "consumer_probed()"
> > callback.
> >
> > If you see the example I gave above, there is a SYNC_STATE_ONLY link
> > all the way up to step 7 that'll prevent sync_state() from being
> > called. And until step 5, there is no device link between S and C and
> > you'll have to go look at S's fwnode links to find C.
>
> Thanks for the details, but I don't think the code in genpd needs to
> take these details into account.  Or at least that is my goal, if
> possible.
>
> As I understand it, all of the above should already been taken care of
> when __device_links_queue_sync_state() is called, as it's at that
> point when we can validate whether all consumers for a supplier have
> been probed, right?

Not really, and I explained it in my earlier email.

Let me explain it in a different way. For now, forget what
sync_state() does or how it's called.

When you get your new callback:
1. You agree that you want to check the actual consumer DT nodes that
have the "power-domains" property?
2. You agree that if you miss checking a consumer node then you'll
incorrectly calculate wait_for_consumer for a genpd belonging to a
one-cell genpd OF provider?
3. You agree that if wait_for_consumer is set to false before all
consumers explicitly pointing to that specific genpd using the cell
number, then you'll turn off the genpd too early?

I'm pretty sure you'll agree to (1) (2) and (3).

I'm saying that since this new callback is called way more often than
sync_state() it will end up being called when some consumer struct
devices haven't been created yet (I explained why in my earlier email
-- I'm 100% certain this will happen). So, you'll also have to check
the fwnode link consumers too to make sure you don't set
wait_for_consumer =3D false too early.

The SYNC_STATE_ONLY link ignoring is just an optimization. If you
don't ignore those, you'll be parsing their DT nodes unnecessarily
because they are just proxy consumers (I explain this in my earlier
email too).

>
> >
> > > If there are problems with not yet registered consumer device links,
> > > why isn't that as problem for regular ->sync_state() in
> > > __device_links_queue_sync_state()?
> >
> > Does my explanation above make sense?
>
> I think you may have misunderstood how the code in $subject patch
> works. Let's try again.

I took a closer look today and I'm sure I understand this patch
correctly. There is a "turns off too early" bug.

Thanks,
Saravana

>
> >
> > Welcome to the annoying worlds of fw_devlink corner cases/nuances.
> > There's a case where the child is the supplier of the
> > parent/grandparent. There's a comment for that in the fw_devlink code.
>
> Yeah, I am fully aware of the high level of complexity and as I said,
> I don't want genpd to have to know about *all* of that.
>
> [...]
>
> Kind regards
> Uffe
