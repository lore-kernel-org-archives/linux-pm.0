Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07538F638
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093516; cv=none; b=Uixb+BiXCGr9zaJRPhKdwWN2cDJmP+3szwDdKBnjSkNFW3eeev6s4F+zyHlB/I7XG390BqlV856eE6aEX0gCIbTOe48ykspUVEolaDxkKTcfVSjSlI/5lFSok7iW+Fu1RrxBGl84n+0DeD93NpCq68Ui86FqASmfCYzDXIwQ5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093516; c=relaxed/simple;
	bh=UCsbin/pFsg6epHjqanzY7KLyNc5wHkyyq/xoasDCeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGm/nGMYNsW//m6pusl/rzPOwlJOi90aFqBl4XQBrBQCH0zW2HJFFwWqbLRtYzdvnrsPBn/SxhwNW0kbT1aYR1DVBxcxiCxpKZWApzHe/vwzl42xc8D8Jo++c6AuvPrJp4fOtz9XfyiBb56YYisVu0Y43UslSB2GLQxM17epBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYdzf/Sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYdzf/Sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69611F000C4
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093514;
	bh=jPqNuN2Z0AIiYY2QJZCKm2gajozrt7uKbLSbohwiQAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iYdzf/SqZpJEkV0OSw8d1cvFBRGK97VCaR0UP2KaiLsefXFoDX0PTb8axZkKNpK1f
	 XU236+nmid2LrheRnPKSREV0wMYHuN/5c9FvcZuly2kY4lbkKQKwDPgowUKtTDM9UR
	 /7+cEKqic/+klAILGdO9BzAq/meY/wra7vBiTiKjneiTVhxRBUWPh1ixtGDBYtHTRw
	 Y6phISR7FcbSUguQLqA73aCk+tRXcWCHCHKGeu8fqP/Qf+8yBgUMigbM1z9tIUDzcU
	 IT0ZwxKFt0PicWNroirP0uw3icq1ObB8WEbOQEiALf3cMpzvr8/IjYCFPjyt4cfNj4
	 UAMkT8JxaSzig==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so5915859e87.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCfmz662sznrWWnr0RA7IVdvcSdQ3b9Q9eAZUzJcFuhJczDL/vZMlqaOgX+QoMRUFN6JSEqMohtA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJZLjZ/W9XAhUz1OLNL5GMUvrwgSMo7F8UhLDce3AiPYdHlqMZ/
	nFN28uAhgHJ55cN2AYq5xrlIiLaNmPg5XnDsTZypqPwom+pu90UDec8Bhry2Mn8Km/+ldtCdWKO
	7yM6wgO+LIns9fNZ4NIVahP+R9NPnyCk=
X-Received: by 2002:a05:6512:a83:b0:5ba:430f:bf61 with SMTP id
 2adb3069b0e04-5bcde6bcb11mr8490115e87.61.1792093513018; Thu, 15 Oct 2026
 12:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
 <20260923143416.3713485-2-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0jikgt4wYS1MJqTBMKBaw=qeuGyD58ArQCoRpZNPZMSSQ@mail.gmail.com> <8e6ddfa3-d94a-4449-b2de-032ca8677d1f@oss.qualcomm.com>
In-Reply-To: <8e6ddfa3-d94a-4449-b2de-032ca8677d1f@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 21:43:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ5C-tGFutEF=JiJActEPNM4oxmwYGDw7-LgP4SmucCQ@mail.gmail.com>
X-Gm-Features: AclHuK-Xfdd_tNa2sV1pf5KMpKFLvRW3bp_sNNr233TdQ9NRCqNFsDEit7WlDFE
Message-ID: <CAJZ5v0iJ5C-tGFutEF=JiJActEPNM4oxmwYGDw7-LgP4SmucCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] powercap: Add generic zone hierarchy creation helpers
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-pm@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sat, Oct 10, 2026 at 4:57=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> On 9/29/26 20:02, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Sep 23, 2026 at 4:34=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> Powercap controllers may need to create several powercap zones organiz=
ed
> >> as a hierarchy. At present, each controller has to open-code the
> >> hierarchy traversal, parent lookup, error rollback and reverse-order
> >> destruction.
> >>
> >> Introduce struct powercap_hierarchy to describe a powercap
> >> hierarchy. Each node contains its name, parent, backend-specific data
> >> and the powercap zone created for it.
> >>
> >> For example, the following description:
> >>
> >>    static struct powercap_node nodes[] =3D {
> >>            { .name =3D "package" },
> >>            { .name =3D "cpu", .parent =3D &nodes[0] },
> >>            { .name =3D "gpu", .parent =3D &nodes[0] },
> >>    };
> >>
> >>    static struct powercap_hierarchy hierarchy =3D {
> >>            .nodes =3D nodes,
> >>            .nr_nodes =3D ARRAY_SIZE(nodes),
> >>    };
> >>
> >> creates the following hierarchy:
> >>
> >>    package
> >>    |-- cpu
> >>    `-- gpu
> >
> > I gather that this works, but TBH it doesn't look particularly nice,
> > especially because of the way in which indices need to be used in it.
> >
> > If a few extra bytes can be sacrificed for storing extra pointers,
> > something like this can be done instead:
> >
> > struct powercap_node {
> >      const char *name;
> >      struct powercap_node *parent_node;
> >      struct powercap_zone *pcap_zone;
> >      void *data;
> >      unsigned int nr_subnodes;
> >      struct powercap_node *subnodes[];
> > };
> >
> > struct powercap_node cpu_node =3D {
> >      .name =3D "cpu",
> > };
>  >
> > struct powercap_node gpu_node =3D {
> >      .name =3D "gpu",
> > };
> >
> > struct powercap_node package_node =3D {
> >      .name =3D "package",
> >      .nr_subnodes =3D ARRAY_SIZE(package_node.subnodes),
> >      .subnodes[] =3D { &cpu_node, &gpu_node };
> > };
>
>
> There is another aspect worth considering: the symmetry with the
> existing powercap zone API.
>
> powercap_register_zone() expresses the hierarchy through a parent
> pointer rather than an explicit list of children. The proposed flat
> representation follows the same model, where each node references its
> parent. This is consistent with how powercap zones are registered: a
> zone is attached to an existing parent, without requiring the parent to
> know about its children.
>
> Your suggestion reverses that relationship in the hierarchy description,
> requiring the creation helper to reconstruct the parent pointers during
> traversal. While this works, it introduces a different representation of
> the same hierarchy and makes the description less closely aligned with
> the underlying powercap API.

That's because parents are registered before their children and from
the perspective of the code parsing the hierarchy description it would
be quite natural to get a list of child descriptions from the parent
one, so the hierarchy can be parsed recursively.  Populating the
parent pointers while doing that would be trivial and the main benefit
is that the registration ordering would always be right.

> The parent-based approach also has the advantage that each node can be
> described independently of its siblings. Adding or removing a node only
> requires changing its own entry, without updating the parent's list of
> children or child count.

But of course you need to add it to the array after the parent and use
the correct parent index in the child entry.

> This becomes particularly useful for drivers
> supporting multiple platforms with different topologies, where a single
> array per platform keeps the descriptions compact and easy to maintain.

I'm not sure about this last piece TBH.

> Moreover, the parent pointer directly represents the relationship needed
> by the registration callback. The hierarchy helper only needs to resolve
> the parent's registered zone and pass it to the callback, without
> maintaining an explicit child list.
>
> I agree that referencing parents through array indices is not
> particularly elegant and that the ordering constraint is a limitation of
> the current implementation. However, these are traversal and
> representation details that could be improved independently, without
> necessarily changing the parent-based model.
>
> For these reasons, I think preserving the symmetry with the existing
> powercap API, along with the simplicity and scalability of platform
> descriptions, is worth considering.

Well, personally, I'd do it differently, but then I guess it may not
matter that much.

However, Sashiko has quite a bit of feedback on this series:

https://sashiko.dev/#/patchset/20260923143416.3713485-1-daniel.lezcano%40os=
s.qualcomm.com

which would be good to address.
