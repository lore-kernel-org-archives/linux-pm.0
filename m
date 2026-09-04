Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F5175A6B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517861; cv=none; b=gdyUZHLZQB78r4UzxVc9lXSsIin61PNXxVUAH9sgLGUuF0fey12gKFUvF5YW2mJ8TzxdSTxzqxwvNLsAWtFsyROo74u/jUaGRoTlpwS1pa88iQfHvrUuDOhsFmfxdUIpE572tJ4xBZet0ImaMI7Nq6punvwHjGH1TEZQfRrRaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517861; c=relaxed/simple;
	bh=HSgeBQ0mHDQt1Sq43MY0o4wxhgcEwOVxtMn54CsehgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLQwrDi86FCsF0Q3jyWZKSq7fkjXxiaiG1ODmszbEV4kE2Pqzs4qJqHM9bk4fcyYP7cbYbPdP48WovJR2O8tLaMNL5QaWigIKNqznZFAymUdPzHSVXudqzUDD+YJMn1aoVJ6nRlyX+CC3o0/DU67KM/Mi8zTcrFWxJjZ87Ib/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUbo86UX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUbo86UX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC791F0155F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517858;
	bh=Ak3IEV5EuNPQAh0ybs3J8IV2WjKmGgfXZ4hNk/xxyjM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=mUbo86UXxBWE6CTcj70Nt+yzfQL8JPBmPwGRVX2JHufpjDw8QX02IMe5OhvQgptjM
	 SwShFyYg4okprAeRMJouUbFefoRObxsWzgcKk46mZOJNjgBCYSn0Thhoyva09oRCGZ
	 oJwnkhQ1qzXwGqTSwBzA8Zr1LzAlg3Ybw+HJcn/+FdH8RxXotFSyH3GhWmE7XVhdF3
	 JgWIV77yI16EZy6cPlqHQauKysmSHQ1IetZ1LGwnDZT6EhBp/NMi9ozCI/ik2cD8eY
	 o1uJOoRRgYULksn1fhY/vdzg+SEiuLW/Q8EnU9yO3lbMUIeTE9T0rZ6HCMPZFagkxR
	 4T+Ka5P7ZGClQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a151eda82dso8376371fa.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 03:30:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxWKG1aFkJv0uK/B6aNRisT+5rghgiwqI3O4jyVxnVuvH40JqVgvVfJSfgX74A1v9sMvqifpg5Jdw==@vger.kernel.org
X-Gm-Message-State: AFuF++m/O22qydNzsCNUhvt/OCoFRQpy6Y65ECOvmBEGZty0Kk61JoY1
	ELiXOcTV4RJ8JVzMsmdddq98B5E0OQ99z9uFqq9hYYHxcgChZEto9f3SRK94Kmski7iSDbWaZsR
	QPLAVYpUovx2TBV58WgsmSYLBq5+wmbc=
X-Received: by 2002:a2e:a7ca:0:b0:3a3:34:865 with SMTP id 38308e7fff4ca-3a371b6dd76mr9445761fa.5.1788517856421;
 Fri, 04 Sep 2026 03:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-7-wenst@chromium.org>
 <c6526ba0-be08-46c6-a501-1b161939657c@oss.qualcomm.com>
In-Reply-To: <c6526ba0-be08-46c6-a501-1b161939657c@oss.qualcomm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 4 Sep 2026 18:30:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v66c8L20yNNmvj6TaQbS7LnqAyuv0tMQfj+0PSjMUcSByA@mail.gmail.com>
X-Gm-Features: AcwNN1Xat96btOTDTzU9PGXAhyQrjVXT5ZP9qiHi9N7dj1ScKDZ_5SK_K-nNAtc
Message-ID: <CAGb2v66c8L20yNNmvj6TaQbS7LnqAyuv0tMQfj+0PSjMUcSByA@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] usb: hub: Associate port@ fwnode with USB port device
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(dug this out of my kernel.org email)

On Fri, Jul 31, 2026 at 10:44=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/21/26 8:54 AM, Chen-Yu Tsai wrote:
> > When a USB hub port is connected to a connector in a firmware node
> > graph, the port itself has a node in the graph.
> >
> > Associate the port's firmware node with the USB port's device,
> > usb_port::dev. This is used in later changes for the M.2 slot power
> > sequencing provider to match against the requesting port.
> >
> > To avoid potential conflicts with ACPI firmware nodes and then causing
> > power management issues, only assign the firmware node if the hub's
> > firmware node is not an ACPI firmware node.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
>
> [...]
>
> > +     /*
> > +      * ACPI FW nodes are associated later when device_register() happ=
ens.
> > +      * Skip assigning one here to avoid potential conflicts.
> > +      */
> > +     if (!is_acpi_node(fwnode)) {
> > +             struct fwnode_handle *port;
> > +
> > +             /*
> > +              * fwnode_graph_get_port_by_id() returns either a valid f=
wnode handle
> > +              * or NULL. Passing NULL to device_set_node() clears any =
associated
> > +              * fwnode. It is effectively a no-op here, since no fwnod=
e has been
> > +              * assigned to the newly created device yet.
> > +              */
> > +             port =3D fwnode_graph_get_port_by_id(fwnode, port1, FWNOD=
E_GRAPH_DEVICE_DISABLED);
>
> This works if the node at the other end of the graph is a
> USB hub, e.g. from qcom/lemans-evk.dts:
>
> usb_hub_3_x: hub@2 {
>         compatible =3D "usb5e3,625";
>         reg =3D <2>;
>
>         peer-hub =3D <&usb_hub_2_x>;
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>                 port@1 {
>                         reg =3D <1>;
>
>                         usb_hub_3_1: endpoint {
>                                 remote-endpoint =3D <&hd3ss3220_1_out_ep>=
;
>                         };
>                 };
>
>                 port@4 {
>                         reg =3D <4>;
>
>                         usb_hub_3_4: endpoint {
>                         };
>                 };
>         };
> };
>
> But something I faced when I was poking at USB4 was that dt-bindings
> currently assume every controller is effectively single-port and the
> of_graph ports under it represent HS/SS lanes, i.e. the entire
> "ports" subnode represents a single USB port

Which controller is this? AFAIK for xHCI hosts there currently is no
"ports" node specified in the common usb-hcd.yaml binding. I plan to
add this separately, as it can already be used for USB A connectors.

The kernel maps every downstream port of the root hub to a separate
node. On the XHCI it is more complicated because it has two root hubs,
one for HS and one for SS. I'm not familiar with the hardware specifics
but they seem to map into one common namespace, so you probably get
ports 1~8 for HS and then 9~12 for SS. Note the number of ports is
different. This is just an example from my x86 workstation. And on
x86 each port is mapped to a different ACPI node.

> I think the solution here would be to do ports {} under the controller
> and have every one of them have 2 endpoints (for HS and SS
> respectively) - then, each DT-port would correspond to a USB port
> (sorta like in the hub case, minus the hubs are split for HS/SS so
> they have just a single endpoint under each port)

But the hardware descriptors actually give two ports, one for HS and one
for SS. And in the case of dwc3, I suspect that they always come with
one downstream HS port and (optionally) one downstream SS port. So the
binding is actually correct, except for the numbering.

I'm looking into the dwc3 case. Changing the numbering might actually
not break anything. Linux seems to just need one *a* graph connection,
but doesn't care about the number. I looked through some other projects:

- FreeBSD doesn't use the OF graph for anything
- U-boot doesn't use the OF graph for USB
- OpenBSD doesn't support dwc3, only the XHCI in dwc3, and doesn't use the
  OF graph for USB
- coreboot doesn't use the OF graph for anything
- Zephyr doesn't support dwc3
- TF-A doesn't use the OF graph for anything
- EDK2 doesn't support dwc3 and doesn't support OF graph
- OP-TEE doesn't support dwc3 and doesn't support OF graph

> But that comes with a big breakage, as always..

As I mentioned, it probably isn't as large of a breakage.


ChenYu
