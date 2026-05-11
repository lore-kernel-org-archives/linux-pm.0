Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D536DA1A
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476155; cv=none; b=IzYlG5388oaanRN/TEUIR7rSSKNr934bh2ciQaoVTz7n39xoeIx17ArrD6shExUZdW2fVkj3IB9UBHd8sCkuyU/OVi4J6ZDD6Dqj06tSVgwgQoAFYbpyoEoTC0KlUhzPAPz/YuJYDOCTdFcVfd1qeNLPl/gdPsImw20nGeGDYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476155; c=relaxed/simple;
	bh=v9n6ZxHo9EI7jUy6DgYTWEGFxkQN/a1zqND0vfE8zgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqitbXVl5oJmHzkoeyBgfRRSbYXz0qc44vlxga9DTGqsWjOARVwu3fxuxcTAXUbylDpHpqN8+bgDd/XiCKxIEabuFZ7AYZtfncHI/Ef1BKZLS8ihYH1H3w4jmP5KGvq+9YUSXGOe3ZAWI+Szts6eLAVniTtBZxHq9w10IoROiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC8RAPVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC8RAPVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CBAC4AF0F
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 05:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476155;
	bh=v9n6ZxHo9EI7jUy6DgYTWEGFxkQN/a1zqND0vfE8zgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iC8RAPVOZcjS6bhScxO6LC8p9fyey4YvPONMBsgmNiGHSgPZS586L4amn30qpP7nO
	 ByzwEJ3Js/IpEdgtqVXM/+azeWDmR5UjrLmGK2ilPfDXp9XhLT3yHqT7DfUN8qOI8+
	 hvLoT4THAurqtDkDODXvLdtBROzfd8tIy3MVILpbb4oKdMZHnU08DBj0IjKwUZR8BY
	 joq4nmFyySyJzwWUHFaLwOhahnKjNIbwFObwW01M1P6ZJyN2j6PiNM7oP5e2+XiIEa
	 vLNV4eg0uH0UdZnpm+izl7VLrcnA+oTChEfWT2r0uyoGMNiWKcDKnoraybZhYdW/Rq
	 ZSemTcXiE1J7g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so6248291a12.1
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 22:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9XBDXlbs7gjPZqn44oFIxDsYTRdVkoQEvfzQfgBd3wcf2WeEU535zymr/M7n0mkLB8PksE7sKjQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8Rrm2kSlOFY6g3NoyLdk/gFlRHiN9HqDCtbr3GCgeFRv3878
	AhRxRLyezx3YYllWNeXX//cZEQqv1KnxLUDFhsj4kcazvkmCAXw9j/2ooGSwEioQ0/I7gDm4RYd
	kj8D+8lxjN2y/hvo03uY0hkdcrM8/j08=
X-Received: by 2002:a17:907:3d10:b0:bcd:53e5:c8f1 with SMTP id
 a640c23a62f3a-bcd53e5deb7mr303817166b.13.1778476154357; Sun, 10 May 2026
 22:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org> <20260508123910.114273-7-ulf.hansson@linaro.org>
In-Reply-To: <20260508123910.114273-7-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 10 May 2026 22:09:03 -0700
X-Gmail-Original-Message-ID: <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
X-Gm-Features: AVHnY4LdEQ7p0ZMNChLV4ocQ5AW7kw67_dLw0n8cyZRtXPtwXXlKUiWHHIvLrUk
Message-ID: <CACRMN=cowCsGb3x=tPOWLYdittwLCsSb2N2SXVPyxBRHThGAVg@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] pmdomain: core: Add initial fine grained
 sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
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

On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> A onecell (#power-domain-cells =3D <1 or 2>; in DT) power domain provider
> typically provides multiple independent power domains, each with their ow=
n
> corresponding consumers. In these cases we have to wait for all consumers
> for all the provided power domains before the ->sync_state() callback get=
s
> called for the supplier.
>
> In a first step to improve this, let's implement support for fine grained
> sync_state support a per genpd basis by using the ->queue_sync_state()
> callback. To take step by step, let's initially limit the improvement to
> the internal genpd provider driver and to its corresponding genpd devices
> for onecell providers.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Addressed some cosmetic comments from Geert.
>
> ---
>  drivers/pmdomain/core.c   | 124 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h |   1 +
>  2 files changed, 125 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index ad57846f02a3..c01a9a96e5c2 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2699,6 +2699,119 @@ static struct generic_pm_domain *genpd_get_from_p=
rovider(
>         return genpd;
>  }
>
> +static bool genpd_should_wait_for_consumer(struct device_node *np)
> +{
> +       struct generic_pm_domain *genpd;
> +       bool should_wait =3D false;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> +                       genpd_lock(genpd);
> +
> +                       /* Clear the previous state before reevaluating. =
*/
> +                       genpd->wait_for_consumer =3D false;
> +
> +                       /*
> +                        * Unless there is at least one genpd for the pro=
vider
> +                        * that is being kept powered-on, we don't have t=
o care
> +                        * about waiting for consumers.
> +                        */
> +                       if (genpd->stay_on)
> +                               should_wait =3D true;
> +
> +                       genpd_unlock(genpd);
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);

I think I understand the intent of this function, but haven't dug into
genpd code enough to comment on this yet. I'll come back to this
later.

> +
> +       return should_wait;
> +}
> +
> +static void genpd_parse_for_consumer(struct device_node *sup,
> +                                    struct device_node *con)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       for (unsigned int i =3D 0; ; i++) {
> +               struct of_phandle_args pd_args;
> +
> +               if (of_parse_phandle_with_args(con, "power-domains",
> +                                              "#power-domain-cells",
> +                                              i, &pd_args))
> +                       break;

Why not use a while or a do while() instead of this infinite for loop
with a break?

> +
> +               /*
> +                * The phandle must correspond to the supplier's genpd pr=
ovider
> +                * to be relevant else let's move to the next index.
> +                */
> +               if (sup !=3D pd_args.np) {
> +                       of_node_put(pd_args.np);
> +                       continue;
> +               }
> +
> +               mutex_lock(&gpd_list_lock);
> +               genpd =3D genpd_get_from_provider(&pd_args);
> +               if (!IS_ERR(genpd)) {
> +                       genpd_lock(genpd);
> +                       genpd->wait_for_consumer =3D true;
> +                       genpd_unlock(genpd);
> +               }
> +               mutex_unlock(&gpd_list_lock);
> +
> +               of_node_put(pd_args.np);
> +       }
> +}
> +
> +static void _genpd_queue_sync_state(struct device_node *np)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +               if (genpd->provider =3D=3D of_fwnode_handle(np)) {
> +                       genpd_lock(genpd);
> +                       if (genpd->stay_on && !genpd->wait_for_consumer) =
{
> +                               genpd->stay_on =3D false;
> +                               genpd_queue_power_off_work(genpd);
> +                       }
> +                       genpd_unlock(genpd);
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +}
> +
> +static void genpd_queue_sync_state(struct device *dev)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       struct device_link *link;
> +
> +       if (!genpd_should_wait_for_consumer(np))
> +               return;
> +
> +       list_for_each_entry(link, &dev->links.consumers, s_node) {

Couple of issues:
1. I don't want the frameworks to be so deeply aware of driver core
internals. I want the driver core maintainers to be able to change the
devlink implementation without having to worry about going and fixing
all the frameworks. So, please add a for_each_consumer_dev(supplier,
callback) and for_each_supplier_dev(consumer, callback) helper
functions.

2. This doesn't ignore "SYNC_STATE_ONLY" links and that's going to
confuse the consumer count/check you might do or at the least waste
parsing those.

3. **Device** links are not the complete list of consumers because
they can only link consumer **devices** once the consumer **device**
is created.

4. What you really need is a for_each_consumer_fwnode(supplier,
callback) that first loops through all the consumer device links and
calls the callback() on their fwnode and then the same function needs
to loop through all the fwnode links and then pass those consumer
fwnodes to the callback. And inside that callback you can do whatever
you want.

5. You might want to add a for_each_inactive_consumer(supplier,
callback) too to simplify your need for checking if a fwnode has a
device and then checking if it's probed.

Thanks,
Saravana


> +               struct device *consumer =3D link->consumer;
> +
> +               if (!device_link_test(link, DL_FLAG_MANAGED))
> +                       continue;
> +
> +               if (link->status =3D=3D DL_STATE_ACTIVE)
> +                       continue;
> +
> +               if (!consumer->of_node)
> +                       continue;
> +
> +               /*
> +                * A consumer device has not been probed yet. Let's parse=
 its
> +                * device node for the power-domains property, to find ou=
t the
> +                * genpds it may belong to and then prevent sync state fo=
r them.
> +                */
> +               genpd_parse_for_consumer(np, consumer->of_node);
> +       }
> +
> +       _genpd_queue_sync_state(np);
> +}
> +
>  static void genpd_sync_state(struct device *dev)
>  {
>         return of_genpd_sync_state(dev->of_node);
> @@ -3531,6 +3644,16 @@ static int genpd_provider_probe(struct device *dev=
)
>         return 0;
>  }
>
> +static void genpd_provider_queue_sync_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd =3D container_of(dev, struct gene=
ric_pm_domain, dev);
> +
> +       if (genpd->sync_state !=3D GENPD_SYNC_STATE_ONECELL)
> +               return;
> +
> +       genpd_queue_sync_state(dev);
> +}
> +
>  static void genpd_provider_sync_state(struct device *dev)
>  {
>         struct generic_pm_domain *genpd =3D container_of(dev, struct gene=
ric_pm_domain, dev);
> @@ -3559,6 +3682,7 @@ static struct device_driver genpd_provider_drv =3D =
{
>         .name =3D "genpd_provider",
>         .bus =3D &genpd_provider_bus_type,
>         .probe =3D genpd_provider_probe,
> +       .queue_sync_state =3D genpd_provider_queue_sync_state,
>         .sync_state =3D genpd_provider_sync_state,
>         .suppress_bind_attrs =3D true,
>  };
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b299dc0128d6..7aa49721cde5 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -215,6 +215,7 @@ struct generic_pm_domain {
>         cpumask_var_t cpus;             /* A cpumask of the attached CPUs=
 */
>         bool synced_poweroff;           /* A consumer needs a synced powe=
roff */
>         bool stay_on;                   /* Stay powered-on during boot. *=
/
> +       bool wait_for_consumer;         /* Consumers awaits to be probed.=
 */
>         enum genpd_sync_state sync_state; /* How sync_state is managed. *=
/
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> --
> 2.43.0
>
