Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8543CF688
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705046; cv=none; b=gT+w+wkRzVDaIoiLz1lcp5tqmnVPtkzt8DeMTbGGBiNh1T4G7hVW3dTCH5SWrzzyrYtQiKA3FOnFQvaRaV9yD6bl9L3VjSc54Vj5PTq0veXwPPzbrSielWKN55qyrHoeA0qNLfstVZJgS66b7HoohX9gl0RKhWa4jz+pfrZyhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705046; c=relaxed/simple;
	bh=syaOp/uZj6dD0zmtNRzrmcNmXC+yLxR9bWC8W73sWP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwfQzcN+dmstOhKAuz+i7x4skfw4DBG0gEsxFmMKDH0GLh94uqPd1+dJDWAPWL8++AlsBW2NaUyjoTWUpWPa8G5EVWxyDmmbk2UfSF4AFgM7xJBtIaOiJoCigHem4j8CImWLZjr6Vzc9+8M2CajMzSg4rKkK7HjsrWbPcFm9bpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM1wU8S9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM1wU8S9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223D1F0089A
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790705044;
	bh=d05m2MxOZ724TTvpTaSVZeJxO3gGGW8/skvYmnq1Zxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jM1wU8S9A64dNBfDG1JblQPRmWlkt7AvTIGADeRJ+6a32kun9zazHzQReBAbdoHXM
	 Hgwt1K8/TwQUF6VBLkUB1HEgp6+VtYEnrPjn0f9Z6VGejo6QFG4UqPeFuTDa9O8e5a
	 1njyDTlvvtYPZ1r81fNYl4hdOzwf5k6Gi9Cx51JaVQQMzfn03FUsZr/CqIj9ma8ikW
	 7hNnHs/xA1pQFQuPkD4zDKb4mRXVO4m1ChXq0SZoUcOhDBxhCO5KAl4ddiOL++HGf8
	 tOcTY6IEMsIVKZLyaZTZfVxv/5hJfdCXE1GWH8INKSZW0Wgu79EvK65w9HFX/F1NvQ
	 xxirSOZA4+LKA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ede3ab7aso1353156e87.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwn8Den/hB2hn6QPvNMmHMjNB/8SbKrFj1vz0AHcdXb4eEj2w3c4dBWCzQmAaRRmc6o4DKcoQRoaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+3qU4AufrdiIpY/SZkNwJFGJevvb463nB8nkp6Il3ZeeG+hXu
	edSMxRUlSIv3FaFnFxykIuSQ1i+wGLUu3NPWwMiSFMe7jL545Tb0rQDGbM3siQiu/9Kuh5S+uK9
	b8MyvKrA/1Hjv7diFI0ISOK3789vROyw=
X-Received: by 2002:a05:6512:1182:b0:5b4:7d9d:16d7 with SMTP id
 2adb3069b0e04-5ba3bf66fabmr47894e87.11.1790705042253; Tue, 29 Sep 2026
 11:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com> <20260923143416.3713485-2-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260923143416.3713485-2-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 29 Sep 2026 20:02:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jikgt4wYS1MJqTBMKBaw=qeuGyD58ArQCoRpZNPZMSSQ@mail.gmail.com>
X-Gm-Features: AclHuK9auQ0-YfkZoG__v-DORNn7c5Io_cb3GYObcbokiAAF5oTC7SsrwH-lZ0g
Message-ID: <CAJZ5v0jikgt4wYS1MJqTBMKBaw=qeuGyD58ArQCoRpZNPZMSSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] powercap: Add generic zone hierarchy creation helpers
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:34=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Powercap controllers may need to create several powercap zones organized
> as a hierarchy. At present, each controller has to open-code the
> hierarchy traversal, parent lookup, error rollback and reverse-order
> destruction.
>
> Introduce struct powercap_hierarchy to describe a powercap
> hierarchy. Each node contains its name, parent, backend-specific data
> and the powercap zone created for it.
>
> For example, the following description:
>
>   static struct powercap_node nodes[] =3D {
>           { .name =3D "package" },
>           { .name =3D "cpu", .parent =3D &nodes[0] },
>           { .name =3D "gpu", .parent =3D &nodes[0] },
>   };
>
>   static struct powercap_hierarchy hierarchy =3D {
>           .nodes =3D nodes,
>           .nr_nodes =3D ARRAY_SIZE(nodes),
>   };
>
> creates the following hierarchy:
>
>   package
>   |-- cpu
>   `-- gpu

I gather that this works, but TBH it doesn't look particularly nice,
especially because of the way in which indices need to be used in it.

If a few extra bytes can be sacrificed for storing extra pointers,
something like this can be done instead:

struct powercap_node {
    const char *name;
    struct powercap_node *parent_node;
    struct powercap_zone *pcap_zone;
    void *data;
    unsigned int nr_subnodes;
    struct powercap_node *subnodes[];
};

struct powercap_node cpu_node =3D {
    .name =3D "cpu",
};

struct powercap_node gpu_node =3D {
    .name =3D "gpu",
};

struct powercap_node package_node =3D {
    .name =3D "package",
    .nr_subnodes =3D ARRAY_SIZE(package_node.subnodes),
    .subnodes[] =3D { &cpu_node, &gpu_node };
};

and then &package_node can be passed directly to
powercap_hierarchy_create() without a need to create an auxiliary
struct powercap_hierarchy.

The parent_node pointers can be populated during the creation of the hierar=
chy.

> Add powercap_hierarchy_dup() to create a runtime copy of a hierarchy
> description. Rebase the parent pointers so that the copy does not keep
> references to the original array, which may be stored in init memory.
>
> Add powercap_hierarchy_create() to walk the description in order
> and create each zone through a controller-provided callback. The parent
> zone is passed to the callback, keeping the node creation operation
> specific to the controller.
>
> The backend is responsible for allocating and registering each powercap
> zone from the creation callback. The powercap_zone object is expected to
> be embedded in a backend-specific structure, allowing the backend
> callbacks to retrieve their private data later using container_of().
>
> For example:
>
>   struct foo_powercap_zone {
>           struct powercap_zone zone;
>           struct foo_domain *domain;
>   };
>
>   foo_zone =3D kzalloc(sizeof(*foo_zone), GFP_KERNEL);
>   if (!foo_zone)
>           return ERR_PTR(-ENOMEM);
>
>   foo_zone->domain =3D domain;
>
>   pcz =3D powercap_register_zone(&foo_zone->zone, pct, name, parent,
>                                &foo_zone_ops, nr_constraints,
>                                &foo_constraint_ops);
>
> Its allocation, private state and lifetime remain under the control of
> the backend.
>
> The creation callback therefore returns the same powercap_zone pointer

Which creation callback?

> that was passed to powercap_register_zone(). The hierarchy helper stores
> this pointer to provide it as the parent of subsequent nodes and to pass
> it back to the backend during hierarchy destruction.
>
> Add powercap_hierarchy_destroy() to destroy the hierarchy in
> reverse order, ensuring that children are removed before their parents.
> Use the same mechanism to roll back previously created zones when the
> creation of a subsequent node fails.
>
> Serialize creation and destruction of each hierarchy to prevent
> concurrent updates of the powercap zone pointers stored in its runtime
> copy.
>
> This provides a common mechanism for creating controller-defined
> powercap hierarchies while keeping controller-specific operations
> outside the powercap core.
>
> Cc: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Link: https://patch.msgid.link/20260806110159.69690-2-daniel.lezcano@oss.=
qualcomm.com
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/powercap/powercap_sys.c | 148 ++++++++++++++++++++++++++
>  include/linux/powercap.h        | 178 ++++++++++++++++++++++++++++++++
>  2 files changed, 326 insertions(+)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 9197fa20d93f..fefb36c5bcd2 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -667,6 +667,154 @@ int powercap_unregister_control_type(struct powerca=
p_control_type *control_type)
>  }
>  EXPORT_SYMBOL_GPL(powercap_unregister_control_type);
>
> +struct powercap_hierarchy *
> +powercap_hierarchy_dup(const struct powercap_hierarchy *hierarchy)

This is sort of awkward even though I seem to understand its purpose.
The duplication is extra overhead that would be entirely avoidable by
creating the original structure in memory that is not __initdata.

> +{
> +       struct powercap_hierarchy *copy;
> +       size_t i;
> +
> +       if (!hierarchy || !hierarchy->nodes || !hierarchy->nr_nodes)
> +               return ERR_PTR(-EINVAL);
> +
> +       copy =3D kzalloc_obj(*copy);
> +       if (!copy)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /*
> +        * The source node array may live in init memory. A shallow copy =
would
> +        * leave parent pointers referencing that array after it has been=
 freed.
> +        * Copy the nodes now and rebase their parent pointers below. The=
 name
> +        * and data objects remain owned by the backend and are not dupli=
cated.
> +        */
> +       copy->nodes =3D kmemdup_array(hierarchy->nodes, hierarchy->nr_nod=
es,
> +                                   sizeof(*copy->nodes), GFP_KERNEL);
> +       if (!copy->nodes) {
> +               kfree(copy);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       copy->nr_nodes =3D hierarchy->nr_nodes;
> +       mutex_init(&copy->lock);
> +
> +       for (i =3D 0; i < copy->nr_nodes; i++) {
> +               const struct powercap_node *parent =3D hierarchy->nodes[i=
].parent;
> +               ptrdiff_t index;
> +
> +               copy->nodes[i].pcz =3D NULL;
> +
> +               if (!copy->nodes[i].name)
> +                       goto invalid;
> +
> +               if (!parent)
> +                       continue;
> +
> +               index =3D parent - hierarchy->nodes;
> +               if (index < 0 || index >=3D i)
> +                       goto invalid;
> +
> +               copy->nodes[i].parent =3D &copy->nodes[index];
> +       }
> +
> +       return copy;
> +
> +invalid:
> +       mutex_destroy(&copy->lock);
> +       kfree(copy->nodes);
> +       kfree(copy);
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(powercap_hierarchy_dup);
> +
> +void powercap_hierarchy_free(struct powercap_hierarchy *hierarchy)
> +{
> +       if (!hierarchy)
> +               return;
> +
> +       mutex_destroy(&hierarchy->lock);
> +       kfree(hierarchy->nodes);
> +       kfree(hierarchy);
> +}
> +EXPORT_SYMBOL_GPL(powercap_hierarchy_free);
> +
> +static void __powercap_hierarchy_destroy(struct powercap_control_type *p=
ct,
> +                                        struct powercap_hierarchy *hiera=
rchy,
> +                                        powercap_node_destroy_t powercap=
_node_destroy)
> +{
> +       size_t i;

ssize_t i;

would be more convenient.

> +
> +       for (i =3D hierarchy->nr_nodes; i-- > 0;) {

First, if you use for (), there is no need to combine the
decrementation of the index variable with the termination condition.

I'd do

      for (i =3D hierarchy->nr_nodes - 1; i >=3D 0; i--) {

Second, this seems to require a certain ordering of rows in the array
representing the hierarchy.  In particular, the index of a parent node
needs to be less than the indices of all of its child nodes AFAICS,
which makes it a bit fragile.  Note that my example arrangement
doesn't have this problem.

> +               if (!hierarchy->nodes[i].pcz)
> +                       continue;
> +
> +               powercap_node_destroy(pct, hierarchy->nodes[i].pcz,
> +                                     hierarchy->nodes[i].data);
> +
> +               hierarchy->nodes[i].pcz =3D NULL;
> +       }
> +}
> +
> +int powercap_hierarchy_destroy(struct powercap_control_type *pct,
> +                              struct powercap_hierarchy *hierarchy,
> +                              powercap_node_destroy_t powercap_node_dest=
roy)
> +{
> +       if (!pct || !hierarchy || !hierarchy->nodes ||
> +           !hierarchy->nr_nodes || !powercap_node_destroy)
> +               return -EINVAL;
> +
> +       guard(mutex)(&hierarchy->lock);
> +
> +       __powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destro=
y);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(powercap_hierarchy_destroy);
> +
> +int powercap_hierarchy_create(struct powercap_control_type *pct,
> +                             struct powercap_hierarchy *hierarchy,
> +                             powercap_node_create_t powercap_node_create=
,
> +                             powercap_node_destroy_t powercap_node_destr=
oy)
> +{
> +       struct powercap_zone *pcz;
> +       int ret;
> +       size_t i;
> +
> +       if (!pct || !hierarchy || !hierarchy->nodes || !hierarchy->nr_nod=
es ||
> +           !powercap_node_create || !powercap_node_destroy)
> +               return -EINVAL;
> +
> +       guard(mutex)(&hierarchy->lock);
> +
> +       for (i =3D 0; i < hierarchy->nr_nodes; i++) {
> +               struct powercap_zone *parent =3D NULL;
> +
> +               if (hierarchy->nodes[i].parent) {
> +                       parent =3D hierarchy->nodes[i].parent->pcz;
> +                       if (!parent) {
> +                               ret =3D -EINVAL;
> +                               goto rollback;
> +                       }
> +               }
> +
> +               pcz =3D powercap_node_create(pct, hierarchy->nodes[i].nam=
e,
> +                                          hierarchy->nodes[i].data, pare=
nt);
> +               if (IS_ERR_OR_NULL(pcz)) {
> +                       ret =3D pcz ? PTR_ERR(pcz) : -EINVAL;
> +                       goto rollback;
> +               }
> +
> +               hierarchy->nodes[i].pcz =3D pcz;
> +       }
> +
> +       return 0;
> +
> +rollback:
> +       __powercap_hierarchy_destroy(pct, hierarchy, powercap_node_destro=
y);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(powercap_hierarchy_create);
> +
>  static int __init powercap_init(void)
>  {
>         int result;
> diff --git a/include/linux/powercap.h b/include/linux/powercap.h
> index 603419db924c..939cd58dff4f 100644
> --- a/include/linux/powercap.h
> +++ b/include/linux/powercap.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/device.h>
>  #include <linux/idr.h>
> +#include <linux/mutex.h>
>
>  /*
>   * A power cap class device can contain multiple powercap control_types.
> @@ -309,4 +310,181 @@ struct powercap_zone *powercap_register_zone(
>  int powercap_unregister_zone(struct powercap_control_type *control_type,
>                                 struct powercap_zone *power_zone);
> +/**
> + * struct powercap_node - Description of a node in a powercap hierarchy
> + * @name: Name of the powercap zone.
> + * @parent: Parent node, or NULL if the node is a hierarchy root.
> + * @pcz: Powercap zone created for this node. This field is managed by t=
he
> + *      hierarchy creation and destruction helpers.
> + * @data: Private data passed unchanged to the creation and destruction
> + *       callbacks.
> + *
> + * This structure describes one node of a powercap hierarchy. The backen=
d
> + * supplies an array of nodes through &struct powercap_hierarchy.
> + *
> + * Nodes must be ordered so that a parent appears before all its childre=
n.
> + *
> + * The @name and @data objects must remain valid until the duplicated hi=
erarchy
> + * has been freed. The @parent pointer is rebased by powercap_hierarchy_=
dup(),
> + * allowing the original node array to be released after duplication.
> + *
> + * The @pcz field is runtime state managed by powercap_hierarchy_create(=
) and
> + * powercap_hierarchy_destroy(). It is cleared when a node is destroyed.
> + */
> +struct powercap_node {
> +       const char *name;
> +       struct powercap_node *parent;
> +       struct powercap_zone *pcz;

I'd call this "zone" or "pcap_zone" like in my example above.

> +       void *data;
> +};
> +
> +/**
> + * struct powercap_hierarchy - Powercap zone hierarchy
> + * @nodes: Array describing the hierarchy nodes.
> + * @nr_nodes: Number of entries in @nodes.
> + * @lock: Lock serializing hierarchy creation and destruction.
> + *
> + * A backend may place the initial description in init memory and duplic=
ate it
> + * with powercap_hierarchy_dup() before the init sections are released. =
The
> + * duplicated hierarchy owns the @nodes array, but not the objects refer=
enced
> + * by &struct powercap_node.name and &struct powercap_node.data.
> + */
> +struct powercap_hierarchy {
> +       struct powercap_node *nodes;
> +       size_t nr_nodes;
> +       struct mutex lock;
> +};
> +

I'd prefer the kerneldoc comments of new functions to go where the
function definitions are located.

> +/**
> + * powercap_hierarchy_dup - Duplicate a powercap hierarchy description
> + * @hierarchy: Hierarchy description to duplicate.
> + *
> + * Allocate a runtime hierarchy and copy the nodes from @hierarchy. Pare=
nt
> + * pointers are rebased to the duplicated node array and the runtime pcz=
 fields
> + * are initialized to NULL.
> + *
> + * Every parent must belong to the source node array and precede its chi=
ldren.
> + * The node names and private data are not duplicated and must remain va=
lid
> + * until powercap_hierarchy_free() is called.
> + *
> + * Context: Process context. May sleep.
> + *
> + * Return: A pointer to the duplicated hierarchy on success, or an ERR_P=
TR()
> + * encoded error otherwise.
> + */
> +struct powercap_hierarchy *powercap_hierarchy_dup(const struct powercap_=
hierarchy *hierarchy);
> +
> +/**
> + * powercap_hierarchy_free - Free a duplicated powercap hierarchy
> + * @hierarchy: Hierarchy to free, or NULL.
> + *
> + * Free the node array and hierarchy allocated by powercap_hierarchy_dup=
(). All
> + * registered zones must have been destroyed before calling this functio=
n.
> + */
> +void powercap_hierarchy_free(struct powercap_hierarchy *hierarchy);
> +
> +/**
> + * typedef powercap_node_create_t - Create a powercap hierarchy node
> + * @pct: Powercap control type owning the hierarchy.
> + * @name: Name of the powercap zone to create.
> + * @data: Private data associated with the hierarchy node.
> + * @parent: Parent powercap zone, or NULL for a root node.
> + *
> + * Callback invoked by powercap_hierarchy_create() for each node in the
> + * hierarchy. The callback must create and register a powercap zone belo=
w
> + * @parent. The backend is expected to embed struct powercap_zone in its=
 own
> + * object, pass the address of that member to powercap_register_zone(), =
and
> + * return the same address from this callback. This lets the backend rec=
over
> + * its object with container_of() from subsequent powercap callbacks.
> + *
> + * Context: Called with the powercap hierarchy mutex held. The callback =
may
> + * sleep, but must not call powercap_hierarchy_create() or
> + * powercap_hierarchy_destroy() for the same hierarchy.
> + *
> + * Return: A valid pointer to the created powercap zone on success, or a=
n
> + * ERR_PTR() encoded error on failure.
> + */
> +typedef struct powercap_zone *(*powercap_node_create_t)(struct powercap_=
control_type *pct,
> +                                                       const char *name,=
 void *data,
> +                                                       struct powercap_z=
one *parent);
> +/**
> + * typedef powercap_node_destroy_t - Destroy a powercap hierarchy node
> + * @pct: Powercap control type owning the hierarchy.
> + * @zone: Powercap zone to destroy.
> + * @data: Private data associated with the hierarchy node.
> + *
> + * Callback invoked when a hierarchy is destroyed or when its creation m=
ust
> + * be rolled back. The callback must unregister the powercap zone repres=
ented
> + * by @zone. The backend remains responsible for the lifetime of the enc=
losing
> + * object, including releasing it from the powercap zone release callbac=
k when
> + * necessary.
> + *
> + * Nodes are passed to this callback in reverse creation order, ensuring=
 that
> + * all children are destroyed before their parent.
> + *
> + * Context: Called with the powercap hierarchy mutex held. The callback =
may
> + * sleep, but must not call powercap_hierarchy_create() or
> + * powercap_hierarchy_destroy() for the same hierarchy.
> + */
> +typedef void (*powercap_node_destroy_t)(struct powercap_control_type *pc=
t,
> +                                       struct powercap_zone *zone,
> +                                       void *data);
> +
> +/**
> + * powercap_hierarchy_destroy - Destroy a powercap hierarchy
> + * @pct: Powercap control type owning the hierarchy.
> + * @hierarchy: Hierarchy to destroy.
> + * @powercap_node_destroy: Callback used to destroy each powercap zone.
> + *
> + * Destroy all powercap zones previously created for @hierarchy. Nodes a=
re
> + * destroyed in reverse array order so that children are removed before =
their
> + * parents.
> + *
> + * Entries whose &struct powercap_node.pcz field is NULL are ignored. Af=
ter
> + * a zone has been destroyed, its pcz field is cleared.
> + *
> + * The caller must ensure that no users of the hierarchy remain when thi=
s
> + * function is called.
> + *
> + * Context: Process context. May sleep.
> + *
> + * Return: 0 on success or -EINVAL if an argument is invalid.
> + */
> +int powercap_hierarchy_destroy(struct powercap_control_type *pct,
> +                              struct powercap_hierarchy *hierarchy,
> +                              powercap_node_destroy_t powercap_node_dest=
roy);
> +
> +/**
> + * powercap_hierarchy_create - Create a powercap hierarchy
> + * @pct: Powercap control type that will own the hierarchy.
> + * @hierarchy: Hierarchy to create.
> + * @powercap_node_create: Callback used to create each powercap zone.
> + * @powercap_node_destroy: Callback used to roll back an incomplete hier=
archy.
> + *
> + * Create the powercap zones described by @hierarchy in array order. For=
 each
> + * entry, @powercap_node_create is called with the powercap zone stored =
in its
> + * parent entry. Root nodes are created with a NULL parent.
> + *
> + * Each parent entry must precede all its children in the node array. Al=
l pcz
> + * fields must be NULL when this function is called.
> + *
> + * If a node cannot be created, all zones created by this invocation are
> + * destroyed in reverse order by calling @powercap_node_destroy. Therefo=
re,
> + * @powercap_node_destroy must be provided even when the caller does not
> + * expect to destroy the hierarchy explicitly.
> + *
> + * The hierarchy and the objects referenced by its name and data fields =
must
> + * remain valid until powercap_hierarchy_destroy() has completed.
> + *
> + * Context: Process context. May sleep.
> + *
> + * Return: 0 on success, -EINVAL if an argument or hierarchy entry is in=
valid,
> + * -EBUSY if the hierarchy already contains a created zone, or the error
> + * returned by @powercap_node_create.
> + */
> +int powercap_hierarchy_create(struct powercap_control_type *pct,
> +                             struct powercap_hierarchy *hierarchy,
> +                             powercap_node_create_t powercap_node_create=
,
> +                             powercap_node_destroy_t powercap_node_destr=
oy);
> +
>  #endif
> --
