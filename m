Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D43D523E
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495134; cv=pass; b=A30taAu9NiMx+tpSwfTHI6dUu61U22C1H7Tryw7PZQLFjgLzAkjkarzw0fbY+ZJpzgDYf0cTrWA2sNPaVvw8A+jfex5SOMoWQOjplGa3J2HabNkFT0nJZbb/GG4yT9354C8nEMSHUZA4gdTmSWXvG/V5yNd5etL2IuhS7JD+44o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495134; c=relaxed/simple;
	bh=QaiOtwTHgPwAS4MTEKlsWHGSO02A2jICVaQP2YkoUas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SseNQf6NXirlRUhU7gYgq1igQf3pUutUmRq6twWbwr3eXVnrDTlFQ5t3lZrSk7Yc+xlVlQJN/PJM8Zw47RuvG9wDYtZEEN10pK9h3urW6ju36t7DfneTIqSXr1UqQXb0mdtI8D4ILhpp1jhtnhqvvdgVFNpzzm0woAk7FkOgx0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQisbdH2; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQisbdH2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393da8f389bso39987691fa.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 03:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778495130; cv=none;
        d=google.com; s=arc-20240605;
        b=PH2ny8lr3fATxvcyy+R339Mwe8YojUpTFFk4Ka45ycER/jLOsYkfPhjP4RIVIQsROy
         YAPBknv4gtncTh28JqMX0QOTaultWRqc6U6B3JnNRK+5ECCkrSabipxPMj/hvXlmeYh0
         Weyn290iDXKjEN0nGmKhvOlsXm9GLf9ZytAXUmH+TTCh+fN4VewWtdvsZfe5z6EdlEUe
         2NPykafb788K/XsDXFL3wGyTtgV2GroEb9vDNDwuOGGKOfUoruxjMXrdP5Fdb67j9O0e
         vUmOQuS4xLX6yDwyd/tY//+5IUP7QkIkR7ebUlFycsNI5k6R35SXbmqxTIECjgN/k251
         t73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26pw5p2O4LfysMDPKO5lKRzkgvnLvc1tiwrtVXQtYAc=;
        fh=HO9NYLSeAFRLDfEMUw2ZhAajcTOhSBwtrjT5m1iJohk=;
        b=FOz3mEIml6MZSmZZ2aw65pAGJ9qovNJKW/07WunWezcAcJff1FTNvp8+sLhkc3R/K4
         xp74qOWnr7HCUt78pU2qNbrIlVzJO36lptY0jYyLM0AnlpACU3ie+0l6MHpku8Xq3W6a
         U15+K7JcrVKdLBmJYTnLKwWZ3BS08OPsoVMMzM4KHA5pVST0E6Dy1Z08tLcgfpd01Buq
         2/ZAqh0K6ekpm2zSU1EzXdhtqwTXkBVlc4UCsnCkQGXDEHJT1ANku1lYDViHGQIYEgVe
         2fi9X5Xx48PHMNfaI4D8Fr4Q/658IyzUY3Uuoq5harqXXVOEeUCtmvFJOwYWXouPJtt0
         y2GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778495130; x=1779099930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26pw5p2O4LfysMDPKO5lKRzkgvnLvc1tiwrtVXQtYAc=;
        b=EQisbdH294+EJYRMEVWtqqsq0iyPVYoWfqsLU1N9Z/8Ja1SxbBL4ipVq/m7ZfLn7VV
         6PPsZYGaHxyHYywpshCPBAD2YRydiOfPIa8Ar5i0vLtfVwXUsyxXTEQR+52x7tNOgawR
         OzwhDlwqOuuk81lyizLzfwCjyFQHuNjudrh/zTE4KmlVEBzhFjr2Fo9prQvbdpelzgQj
         eWqJAxEwwOZ3u/QGjr1+rlODE0oVgLL9W75sNLGDVMpYhwUAtoIT9wd2+4ne6S3cHh+/
         wor5X8Myu/5Q/Tb4oaOUjphsJjReQleqvjfscN4wUABo8/gG6jY4FtYErkHNuKVmEuz0
         e4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495130; x=1779099930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26pw5p2O4LfysMDPKO5lKRzkgvnLvc1tiwrtVXQtYAc=;
        b=VMpiNJaDCeUKiasJpM7FBD6yfu+r2T8iO97/uNFTDuJudWmkXjzMrEInzf2sJAvCAd
         5VxTNdDgJre359MzRndlv3HVzpwkoWu6beUhXftRJyF3w50R2+F4tVmVScmb+b/NnTLV
         nQlZI1aJEXA6Js+kqVtpw8ycpA7aBZSMJx3YCgin+NgaxPIM9ctG6SoSdMQxABWcEena
         QdJIHN3EcENh9SqKFs0hMW4pL49Wci0yfkMY5zmb9olVHyqHdoS0lW5I7wgYg9siQDZ+
         c9c5FgeZBilcSFvPiR3o+JtV+PhqMd9WebzFBIR0FafDOnBTV4c4TiVxwBiRLVpj7dGq
         TJAA==
X-Forwarded-Encrypted: i=1; AFNElJ9ooU+eJbMsate6Fl7ytJ0qfHvwvN2kp+TUAcxZSMMQigEp00QiZwtidloytohp0vOZPKJVUgG5Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QnMrbSxDSz2C0lvfPt0SbxtGQpaJuAnoMwbjBudIV1UEoouY
	eqVCS6ZOUcKAqx+n98SmqvIBqlwTRHqJzd98v9Sh/2U2tQm5kjoBzYHfTwGHFbUze1mAJmxiRDK
	uvqkFRYePkas0LnnECR8Pevv/guYycQSQKyL84Agckw==
X-Gm-Gg: Acq92OEhJ/K35uhm90PBHws1t0dsqJUjmfhaNO9DHkDLMCiZNK+/UzmktuRPFqCbJYj
	/7FSMNrtGz4Mj/zPS9GpaYso8yLQsA3XddiPlPt7ZXbJ1F4AXE6IuGjm66mNBBxHR1bcNlsVUrT
	tQN7ehYH2ty4AoBvsKxY/AJ9ZAQVX2JdFRIntmvwrArnDiGvKYAgtqhFDG3sUDxn01wyV87cZ/E
	NStnBLR1+84565KzPIIrhkHUa89p50adKBn5zIkYjZMeMCqZqYbunxrI9iwh4ilNiEaii0XrMEa
	+lwUiW0J
X-Received: by 2002:a05:6512:3c97:b0:5a8:750c:2f79 with SMTP id
 2adb3069b0e04-5a8b6c9d7f4mr2454726e87.3.1778495130112; Mon, 11 May 2026
 03:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-7-ulf.hansson@linaro.org> <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
In-Reply-To: <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 12:24:52 +0200
X-Gm-Features: AVHnY4KccwKVfW4opInH2wvv6H4LV9YYk-FND-WFVqnl0G_Vxtf7tdTrxriZmx0
Message-ID: <CAPDyKFoxJ8AOyqzbEQc8x-e5fRf0p3faE23PRNcbA4aPSY_cdg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] pmdomain: core: Add initial fine grained
 sync_state support
To: Saravana Kannan <saravanak@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> wrote:
>
> On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > A onecell (#power-domain-cells =3D <1 or 2>; in DT) power domain provid=
er
> > typically provides multiple independent power domains, each with their =
own
> > corresponding consumers. In these cases we have to wait for all consume=
rs
> > for all the provided power domains before the ->sync_state() callback g=
ets
> > called for the supplier.
> >
> > In a first step to improve this, let's implement support for fine grain=
ed
> > sync_state support a per genpd basis by using the ->queue_sync_state()
> > callback. To take step by step, let's initially limit the improvement t=
o
> > the internal genpd provider driver and to its corresponding genpd devic=
es
> > for onecell providers.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >         - Addressed some cosmetic comments from Geert.
> >
> > ---
> >  drivers/pmdomain/core.c   | 124 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h |   1 +
> >  2 files changed, 125 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index ad57846f02a3..c01a9a96e5c2 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2699,6 +2699,119 @@ static struct generic_pm_domain *genpd_get_from=
_provider(
> >         return genpd;
> >  }
> >
> > +static bool genpd_should_wait_for_consumer(struct device_node *np)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +       bool should_wait =3D false;
> > +
> > +       mutex_lock(&gpd_list_lock);
> > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> > +                       genpd_lock(genpd);
> > +
> > +                       /* Clear the previous state before reevaluating=
. */
> > +                       genpd->wait_for_consumer =3D false;
> > +
> > +                       /*
> > +                        * Unless there is at least one genpd for the p=
rovider
> > +                        * that is being kept powered-on, we don't have=
 to care
> > +                        * about waiting for consumers.
> > +                        */
> > +                       if (genpd->stay_on)
> > +                               should_wait =3D true;
> > +
> > +                       genpd_unlock(genpd);
> > +               }
> > +       }
> > +       mutex_unlock(&gpd_list_lock);
>
> I think I understand the intent of this function, but haven't dug into
> genpd code enough to comment on this yet. I'll come back to this
> later.
>
> > +
> > +       return should_wait;
> > +}
> > +
> > +static void genpd_parse_for_consumer(struct device_node *sup,
> > +                                    struct device_node *con)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +
> > +       for (unsigned int i =3D 0; ; i++) {
> > +               struct of_phandle_args pd_args;
> > +
> > +               if (of_parse_phandle_with_args(con, "power-domains",
> > +                                              "#power-domain-cells",
> > +                                              i, &pd_args))
> > +                       break;
>
> Why not use a while or a do while() instead of this infinite for loop
> with a break?

I guess it's a matter of personal preference. I'm not sure the code
gets any nicer with a do/while, but if you really insist I can change
it.

>
> > +
> > +               /*
> > +                * The phandle must correspond to the supplier's genpd =
provider
> > +                * to be relevant else let's move to the next index.
> > +                */
> > +               if (sup !=3D pd_args.np) {
> > +                       of_node_put(pd_args.np);
> > +                       continue;
> > +               }
> > +
> > +               mutex_lock(&gpd_list_lock);
> > +               genpd =3D genpd_get_from_provider(&pd_args);
> > +               if (!IS_ERR(genpd)) {
> > +                       genpd_lock(genpd);
> > +                       genpd->wait_for_consumer =3D true;
> > +                       genpd_unlock(genpd);
> > +               }
> > +               mutex_unlock(&gpd_list_lock);
> > +
> > +               of_node_put(pd_args.np);
> > +       }
> > +}
> > +
> > +static void _genpd_queue_sync_state(struct device_node *np)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +
> > +       mutex_lock(&gpd_list_lock);
> > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> > +                       genpd_lock(genpd);
> > +                       if (genpd->stay_on && !genpd->wait_for_consumer=
) {
> > +                               genpd->stay_on =3D false;
> > +                               genpd_queue_power_off_work(genpd);
> > +                       }
> > +                       genpd_unlock(genpd);
> > +               }
> > +       }
> > +       mutex_unlock(&gpd_list_lock);
> > +}
> > +
> > +static void genpd_queue_sync_state(struct device *dev)
> > +{
> > +       struct device_node *np =3D dev->of_node;
> > +       struct device_link *link;
> > +
> > +       if (!genpd_should_wait_for_consumer(np))
> > +               return;
> > +
> > +       list_for_each_entry(link, &dev->links.consumers, s_node) {
>
> Couple of issues:
> 1. I don't want the frameworks to be so deeply aware of driver core
> internals. I want the driver core maintainers to be able to change the
> devlink implementation without having to worry about going and fixing
> all the frameworks. So, please add a for_each_consumer_dev(supplier,
> callback) and for_each_supplier_dev(consumer, callback) helper
> functions.

I understand your concern and I like the idea. However, maybe it's
better to get this landed (the series is complicated as is) first and
then can continue to improve the code on top, with helper functions
etc.

>
> 2. This doesn't ignore "SYNC_STATE_ONLY" links and that's going to
> confuse the consumer count/check you might do or at the least waste
> parsing those.

I am not sure I understand how I should take SYNC_STATE_ONLY links
into account here.

At each call to the genpd_queue_sync_state(), we walk through all the
provided genpds for the provider. No previous state is cached to track
consumer counts.

>
> 3. **Device** links are not the complete list of consumers because
> they can only link consumer **devices** once the consumer **device**
> is created.
>
> 4. What you really need is a for_each_consumer_fwnode(supplier,
> callback) that first loops through all the consumer device links and
> calls the callback() on their fwnode and then the same function needs
> to loop through all the fwnode links and then pass those consumer
> fwnodes to the callback. And inside that callback you can do whatever
> you want.

The ->queue_sync_state() callback is invoked *after*
__device_links_queue_sync_state() has been called for the device,
which is also when the conditions for calling ->sync_state() is
checked.

If there are problems with not yet registered consumer device links,
why isn't that as problem for regular ->sync_state() in
__device_links_queue_sync_state()?

>
> 5. You might want to add a for_each_inactive_consumer(supplier,
> callback) too to simplify your need for checking if a fwnode has a
> device and then checking if it's probed.
>
> Thanks,
> Saravana
>
>
> > +               struct device *consumer =3D link->consumer;
> > +
> > +               if (!device_link_test(link, DL_FLAG_MANAGED))
> > +                       continue;
> > +
> > +               if (link->status =3D=3D DL_STATE_ACTIVE)
> > +                       continue;
> > +
> > +               if (!consumer->of_node)
> > +                       continue;
> > +
> > +               /*
> > +                * A consumer device has not been probed yet. Let's par=
se its
> > +                * device node for the power-domains property, to find =
out the
> > +                * genpds it may belong to and then prevent sync state =
for them.
> > +                */
> > +               genpd_parse_for_consumer(np, consumer->of_node);
> > +       }
> > +
> > +       _genpd_queue_sync_state(np);
> > +}
> > +

[...]

Kind regards
Uffe
