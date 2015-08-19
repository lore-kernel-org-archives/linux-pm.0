From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 0/6] ARM: berlin: add cpufreq support
Date: Wed, 19 Aug 2015 10:17:57 +0200
Message-ID: <20150819081757.GA1089@kwain>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
 <20150818143911.GB12017@kwain>
 <20150818145925.GF31148@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47758 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752405AbbHSISB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 04:18:01 -0400
Content-Disposition: inline
In-Reply-To: <20150818145925.GF31148@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 18, 2015 at 08:29:25PM +0530, Viresh Kumar wrote:
> On 18-08-15, 16:39, Antoine Tenart wrote:
> > However, it seems the OPP-v2 table takes precedence over the old on=
e.
> > When a default OPP-v2 table is supplied in the device tree, if the
> > bootloader supplies an OPP table the old way it won't be taken into
> > account.
> >=20
> > So if I understood correctly, this won't work here for the BG2Q.
>=20
> Didn't understood it completely. Are you saying that your dtb will
> have two operating-points tables ?

Yes. If the device tree has an OPP-v2 table and the bootloader modify i=
t
to add an old OPP table at boot, the one added by the bootloader won't
be taken into account by the kernel.

> The deal is that for any device, parsing of opp-v2 will be attempted
> first. If its not available, then opp-v1 will be tried. But this is
> per-device. So, one device can have opp-v2 tables and other one can d=
o
> v1 type.

Sure. OPP-v2 tables can be used for devices having an up-to-date
bootloader or if the bootloader do not modify the device tree at boot
time to add an (old) OPP table.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
