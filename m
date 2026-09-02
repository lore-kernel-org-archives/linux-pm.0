Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2099.outbound.protection.partner.outlook.cn [139.219.146.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDF47D926;
	Wed,  2 Sep 2026 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350926; cv=fail; b=PbEohzd4LqPHaxQ1nGEJ5hR2S7aPFJxgtHY/adWpB+iQQWLgpujt84uUUtPY91oPpjnaI9VWZsN6ni0PZSJ/N7ftoWtUts440rB1H5eRv+WDo7na4WSoF6w6gON0FjLUTW6pNqZUpZLxZsrNU95rfofCUMt4C4Nk9sU75p/Nw5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350926; c=relaxed/simple;
	bh=TfHQK2tgbZD8HzUXWvy9QZw+8mpztQfeF5YWMbjvyUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTd0TS5bfgbWEFOAmkkiJO/1xa0ssAnhPwc/x9TdPltsa0zhCOX8ObKX9lWVbCwjgcd8P304/tzYusqtn9/m+LW73Pc/3p7+F6ankS8OPaZi1xxcB5JYjbUKzpnzDuDh+8sdsXwXb2GD7+HchLwaoLRXAoDhWt6CRHf/zr3t2ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1fVXqMostIABZwr5b2qlqkiFRwylF/d3Hv38tH4z+tNDUCxd1as8NdjWWTYHT2wtqbQIyHceJhyhM6FBYvora63wRsGFCRQg791k7YZnuge1GFRlxqmW1Tv8UJDUXXE2z67glRmdLBD5yWxIbrn5DmO/KFD9mnF44BQ8TmjrJzYu3T5VxrJYIHUGhp3d1mJrXS+Xx+BBK7LidjFipF8B1f4gDk4eWNYBl25/YU3ZcB86y341st5CpI+Xueb4mK/95s0s1DHFUuD/G9auf1msQm0+VhfE3uFhYZnNkn40/EcEyW8HWY8INTGFlJlXMBIMle0r7nR5Iok+iNmxWC9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW6OzzBBnGjIZGkrF6zW/FhvS2LNPBiegEs7xUCT6RY=;
 b=PIHujyHWB3PGXcSKIMgifKjL81rXmDWdt79/PkNH8fMDdkGgYllU/VX3ckK8BjDl/51FH6LiaZJ3/yoV8zi6HZ8BLUH/mLuVhNrIIOv8HeHvbE1RqPqs+4dipdDRgU/j1vlwBcn8sVgpqsq9OL5S4xFqkr57BLBzMq8lrwqN2x1Dv/UA9BT9IGxJMLjG4i9fij8D1Qw6ZSXAXOHPgkiSRcTus/NNrczNXSOgYETBBz8jfJIaUxnFyOKU4+f6zgOFui3uLfjgwJ0mRPTqJZBz+YSn6rPrnVqUhZc4qouNTqRfos0JqBMzfCa1XMFDBLGtrdKe5s8kh3hdIhkMTdD66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0582.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 2 Sep
 2026 11:34:57 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Wed, 2 Sep 2026 11:34:57 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: "rahul@summations.net" <rahul@summations.net>, "anup@brainfault.org"
	<anup@brainfault.org>, "lftan.linux@gmail.com" <lftan.linux@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"ulfh@kernel.org" <ulfh@kernel.org>, "pjw@kernel.org" <pjw@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: power: Add RPMI device power service
 bindings
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add RPMI device power service
 bindings
Thread-Index: AQHdN/jbRNjpwP5Oc0WwRftWzMjA+ra4XzsAgALOUrA=
Date: Wed, 2 Sep 2026 11:34:57 +0000
Message-ID:
 <BJXPR01MB083898883431FD9ED79C1650F9B72@BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn>
References: <20260829205520.1691-1-joshua.yeong@starfivetech.com>
 <20260829205520.1691-2-joshua.yeong@starfivetech.com>
 <20260831-squeamish-pulverize-7e8334767707@spud>
In-Reply-To: <20260831-squeamish-pulverize-7e8334767707@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0838:EE_|BJXPR01MB0582:EE_
x-ms-office365-filtering-correlation-id: b3a968d3-8213-4e7e-ce54-08df08e63750
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|13003099007|38070700021|6133799003|56012099006|3023799007|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 cGAkw8asRgkrRM9SKZQQhHy5RcMwEIuJ1oRkNQHezmRvEprz/Pb14Qb7XoIxPiyGb3RH1ycPAnH1SuiXJ91u5rmLzsksJxzj5LqnBhwGYs3M/9IEbl8j+eqeuRz+5x3cRa1mKUlJggXfq4SSBZe+txcPmDjOwDFtO9kBQqiIRe47ZuhKN/uU+oYDVpoVfGjlMciFmTlNaKmla0gQHpTjxDbv5rRz4rZF0VlT68uqmyHSnQSq/8MjVAG37oli4TP5cg5gEHsgPRxADH8EDfS6XOzcCOsm+z+14hJ8LbjIcgm7+1X2gDpmfnGJ17jrVGSw+5ilewtspI5x940iEdETQT4jaLJZTIsyie4nC9/JSntMESQZxZwuVDGrgY7EGk6YKLPVV+vOYhoHMEW9pMimB4KBsOeHxj+DLGL7tl2VlSzx69BwQTgbtGPEhRrJpxjQwBTWaElazPao9/jw68Y3IGuZjP1hWHTTK3PW4IcoAIH8UmcN3OuYhk29GDEU4Bow/W8MCaIx2bYaalzkgYdZl4IgTrAQWe/LycxpMCxCz3ZaZuDbgXh4uO7siRsEGfHF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(13003099007)(38070700021)(6133799003)(56012099006)(3023799007)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?llJZwFK8uLYS41KJx/YXygo05IqtD25ms/cvT1hSSHBQKnb3vRgAwUq0N6aR?=
 =?us-ascii?Q?2cvw1fjzIPbUh7PiBjqUXdprzH+5HLZBwnT3JQwez2W9uhDdjRWlenwZDOvt?=
 =?us-ascii?Q?C6hqLN1zre01VKpuJjiCNKMCRqlcyePB5Q/Fxk5hX+pSJFUT8f1pZEnMxhR8?=
 =?us-ascii?Q?0z5kBf3lGeg1bZ/inwxaL96cnCI33OWZ8pC4xomqwUIOvG3Uvsvk/VSCKUR+?=
 =?us-ascii?Q?r1Hrc1GadLcoiSAus+0Ap2sFuslSGaJXnZc/i42Q6UvywgXXV9VsrlAsHvfr?=
 =?us-ascii?Q?R3YOh0NqI/moOJPfOTeE/UJssS+YW9dOadjkC6uStG3E9qAaLCpRoBe1VBEd?=
 =?us-ascii?Q?NHrCoO10tWpkVPawf439YfMmVIXqrhYQNRxnh2TWqQkQxgPSRuNQ6Imtw9vk?=
 =?us-ascii?Q?p7jto2HvHPceKNd0ZYoXde2CHWKg3wKz+qolM41Z21JPdQ7XYt0jXs4/1BEs?=
 =?us-ascii?Q?eotcqpUdJsCTeksKb1sC2Rj3UMIx0kzgvuFUFGU9SswEmqLCGUMaYtJYUL2k?=
 =?us-ascii?Q?c7r0yobZEgPxvVrD5bsfmn65ml2OucPjhX+pMi4HawwAFpLlG7iVPZ2wxHqM?=
 =?us-ascii?Q?dlC43X8xBCTzNAaMcAfAmUkbLWp0OpoiZ1+yHX/ryxnqF/CpBB2D75kpkmYu?=
 =?us-ascii?Q?CoI5kJYZsXiyI7tEC8ChLRGePXMYVOgo+z229c0G5r+oZDY9zBz8xZFfwyHU?=
 =?us-ascii?Q?sJc9wZ0eui8V3+2UDfNYHUz7O04RoZz94n/L08Y01lg2FP+Fl5lAFuMCULLw?=
 =?us-ascii?Q?pjy0S02FVhx0E15zVf37oi/YBdThYijM2zcBQvRB+jNxvLagt7tLwXNm9NRW?=
 =?us-ascii?Q?J1+eHMJGrNH9q5Yq3blJ2jrbLunTPuDBYcqL4Ji7e6x0jhFkUZeMkIexPcn1?=
 =?us-ascii?Q?kPNgnu6IlvJssXN0bd6zqfZyesGc82PqWOOhMDve6PUHxxYXNcDZ0MYmOS3K?=
 =?us-ascii?Q?hk4CWl/i6nWX74dkY/PrnzGnoOwJ8ILs1U1neGjtrLwCcPMTyyUIN5I9L6sA?=
 =?us-ascii?Q?uJxTkIz03Egq5WfctxI6vuMJXjY+08/UamOkV9nmNHAf1eecNtM+v9zMW/cf?=
 =?us-ascii?Q?t0+YcCtakOCxMlhv4LgzDCXStbp1daajgA7+jrUGc/SkdVu7M0jcJyu15s8V?=
 =?us-ascii?Q?gSs3e6+fFoqX/xZ32mLPhD/OI8oV+ZAOjNtg/AwT+i+Dz++f4b1uaJU6JfhG?=
 =?us-ascii?Q?0XbReTHceVxMApcdntCeqU8h3lZm9IKhH9LB5OiChyMWaAH4ekiXwo6vkjsZ?=
 =?us-ascii?Q?PP3M7R+Yf4Rgll1bXZ9RFk5J5g9FeXxQIhnDpsccFDRrPKUeLncaopbjgHnF?=
 =?us-ascii?Q?vH8tUf9yiMtIh4eA4lymRdtB0rdqWWYijfI30R3+gpO6WBnUGYj6g9+p+wFE?=
 =?us-ascii?Q?cdCM4IguVJb65iaMzKxoij9inR4/lOTbGP0pmhq4AKQo+ET8fBaNzZhn1hQB?=
 =?us-ascii?Q?GTq9gC1oGlvGOGbakKfA/kHUWNcHlOwfr7HHRS1uubq5M4PyLWzq3k2ZaVnH?=
 =?us-ascii?Q?evcKJSjX+cOHWFhyeS7pHyZsxCBOfTwZCfij4ZV4/x0jEyqh6hYHnWW3BaHo?=
 =?us-ascii?Q?3CR+GJkZmsuon1sH6N6GWkGRnfXtB+4ifaqfo6woutP0xAB+SuN1Cu6HwXjW?=
 =?us-ascii?Q?dkTo8GEqEqJD1s+0yi3BHaCekxHZK1G0qV++ireVLM2l1tEMBShqrZlOpPLj?=
 =?us-ascii?Q?uFdNFciHt+i7GpslsroV+DbwV2Ehr2SqOOJuTXKxx8ZSQC7/eWmat4pLuV4m?=
 =?us-ascii?Q?Mf7B7t9fA7tmFnbaMPbyiOc3qZemH6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a968d3-8213-4e7e-ce54-08df08e63750
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 11:34:57.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLP4E6q9zWEl0ul4pPgm7e5M/ySJvrPvePj4FG3aFAfmGqKAtiIfI/4cOYIn7DMIkLJVwQTv296qu1v4CAA+eZmWFN2AiMrAxIQ5u/0oATM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0582

On Mon, Aug 31, 2026 at 05:41:36PM +0100, Conor Dooley <conor@kernel.org> w=
rote:
> On Sun, Aug 30, 2026 at 04:55:18AM +0800, Joshua Yeong wrote:
> > Add device tree bindings for the RISC-V Platform Management=20
> > Interface
> > (RPMI) device power service group, both for the supervisor-facing=20
> > power domain controller and for the SBI MPXY channel which the SBI=20
> > implementation uses to expose the service group.
> >=20
> > Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
>
> Carbon copy of the clock bindings, right?
>
> This stuff is past the stage of being frozen I assume? Github is=20
> currently being slow as molasses for me and I cannot load the links.
>
> If so
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>
> Cheers,
> Conor.

Yes it is already ratified (past the stage of frozen). I will remove the re=
dundant 'bindings' keyword in v3.
https://lore.kernel.org/all/BJXPR01MB08380868E1DE7029DC52AB06F9B72@BJXPR01M=
B0838.CHNPR01.prod.partner.outlook.cn/
You can acked again in v3.=20

Thanks,
Joshua

>
> > ---
> >  .../power/riscv,rpmi-device-power.yaml        | 65 +++++++++++++++++++
> >  .../power/riscv,rpmi-mpxy-device-power.yaml   | 65 +++++++++++++++++++
> >  2 files changed, 130 insertions(+)
> >  create mode 100644=20
> > Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
> >  create mode 100644=20
> > Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power
> > .yaml
> >=20
> > diff --git=20
> > a/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.ya
> > ml=20
> > b/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.ya
> > ml
> > new file mode 100644
> > index 000000000000..5afdc40df7e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-device-powe
> > +++ r.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:=20
> > +http://devicetree.org/schemas/power/riscv,rpmi-device-power.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V RPMI device power service group based power domain=20
> > +controller
> > +
> > +maintainers:
> > +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> > +
> > +description: |
> > +  The RISC-V Platform Management Interface (RPMI) [1] defines a
> > +  messaging protocol which is modular and extensible. The=20
> > +supervisor
> > +  software can send/receive RPMI messages via SBI MPXY extension=20
> > +[2]
> > +  or some dedicated supervisor-mode RPMI transport.
> > +
> > +  The RPMI specification [1] defines device power service group for =20
> > + accessing and controlling the power state of platform devices=20
> > + managed  by a platform microcontroller. The supervisor software=20
> > + can access RPMI  device power service group via SBI MPXY channel=20
> > + or some dedicated  supervisor-mode RPMI transport.
> > +
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  References
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> > +
> > +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> > +
> > +properties:
> > +  compatible:
> > +    description:
> > +      Intended for use by the supervisor software.
> > +    const: riscv,rpmi-device-power
> > +
> > +  mboxes:
> > +    maxItems: 1
> > +    description:
> > +      Mailbox channel of the underlying RPMI transport or SBI message =
proxy channel.
> > +
> > +  "#power-domain-cells":
> > +    const: 1
> > +    description:
> > +      Platform specific DOMAIN_ID as defined by the RISC-V Platform Ma=
nagement
> > +      Interface (RPMI) specification.
> > +
> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - "#power-domain-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    power-controller {
> > +        compatible =3D "riscv,rpmi-device-power";
> > +        mboxes =3D <&mpxy_mbox 0x1002 0x0>;
> > +        #power-domain-cells =3D <1>;
> > +    };
> > +...
> > diff --git=20
> > a/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-pow
> > er.yaml=20
> > b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-pow
> > er.yaml
> > new file mode 100644
> > index 000000000000..2b7df66ba172
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device
> > +++ -power.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:=20
> > +http://devicetree.org/schemas/power/riscv,rpmi-mpxy-device-power.ya
> > +ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V RPMI device power service group based message proxy
> > +
> > +maintainers:
> > +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> > +
> > +description: |
> > +  The RISC-V Platform Management Interface (RPMI) [1] defines a
> > +  messaging protocol which is modular and extensible. The=20
> > +supervisor
> > +  software can send/receive RPMI messages via SBI MPXY extension=20
> > +[2]
> > +  or some dedicated supervisor-mode RPMI transport.
> > +
> > +  The RPMI specification [1] defines device power service group for =20
> > + accessing and controlling the power state of platform devices=20
> > + managed  by a platform microcontroller. The SBI implementation=20
> > + (machine mode  firmware or hypervisor) can implement an SBI MPXY=20
> > + channel to allow RPMI  device power service group access to the super=
visor software.
> > +
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  References
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> > +
> > +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> > +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> > +
> > +properties:
> > +  compatible:
> > +    description:
> > +      Intended for use by the SBI implementation.
> > +    const: riscv,rpmi-mpxy-device-power
> > +
> > +  mboxes:
> > +    maxItems: 1
> > +    description:
> > +      Mailbox channel of the underlying RPMI transport.
> > +
> > +  riscv,sbi-mpxy-channel-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The SBI MPXY channel id to be used for providing RPMI access to
> > +      the supervisor software.
> > +
> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - riscv,sbi-mpxy-channel-id
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    device-power-service {
> > +        compatible =3D "riscv,rpmi-mpxy-device-power";
> > +        mboxes =3D <&rpmi_shmem_mbox 0x9>;
> > +        riscv,sbi-mpxy-channel-id =3D <0x1002>;
> > +    };
> > +...
> > --
> > 2.43.0
> >=20
