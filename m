Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E83C555C;
	Thu, 16 Jul 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246081; cv=none; b=afcfS8W6Tfp870XzeDzS1jrz40L/fpAD07vk5JM8kCcJt+yZZzJOYq4zHJq50iZuWraXuy4HsJiuiQtFiRzX1RVPAiZ485Dw9xymT7fMy9rdUuKsvcOM8hR+0yEEA5QGcz+QoUrJ+fiCQcwyosXjOyGHeeI9P1u+wP+U2Kbxnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246081; c=relaxed/simple;
	bh=oKryMjn/Bv+TD3xDwZkSTjSU65baeeUI7G2vo+rGOnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni3YUyE3DB77WT2zJXq87hx9eMAnIuMp6n63GPWIeI+Vw/yy35/6uZ3YpU7yS9LAZxB4M0NZlPtCcKOi1yAdOHD5oNn7q6FNZjTJVNrggFj2WLpVzm9zluPdndHIhhgUesRWP735yzyOaBngqjWxKsi1+a3q2Gewo8aYzp5FvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpOU9k9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpOU9k9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D51F000E9;
	Thu, 16 Jul 2026 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784246080;
	bh=cAUYF08DgPZe/OGbTm1DR248/7tqQEZns4ftTrKyuZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MpOU9k9BSQXGN7h9Lx/uUKqj/mqtkGeXdQ2zVPjWFOG/iR0U/ZVUjJLYLgNr21tR+
	 s3Ar3dWEBKO3ZvUA2NHfPirwwem/eGz78eVL9jqjo1+6IgW+WKWxR1Q7fD5XU4AMKV
	 oePysyVI/S93r7TLe6Jhzz8wx7eRIL7oZAluTb5Qxn/R1L4OCCdDsvnjI0mE/4clYo
	 W+h9H1dh9DDSKXh5Cc1ju7ovFLAwC727u77GPN4iyuMW2pOxL1J5kA3cN7DAzk39St
	 zbBPoNWu+mRRQ+6vgv9KMichl7CXK742gTgp1smQcuhNpvO8EC+4fJ5VmBu52H6sqI
	 NunOzpvrQ5Ebg==
Date: Thu, 16 Jul 2026 18:54:36 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, jishnu.prakash@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com
Subject: Re: [PATCH 0/2] qcom_battmgr: Add batteryless DC-adapter MAINS
 support
Message-ID: <alltBcYWULOv7nEv@baldur>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
 <56a54a34-1040-44ae-92e2-ce65a3d3acb5@oss.qualcomm.com>
 <20260519065938.4i5wot72pfxy4m3d@hu-kotarake-hyd.qualcomm.com>
 <ag-NLvh4ROgTCs_L@baldur>
 <d4001407-cdb0-48ee-a138-87c94b5dab01@oss.qualcomm.com>
 <20260702111737.2qtjcfskulav4usd@hu-kotarake-hyd.qualcomm.com>
 <5d5c693b-bd07-40a4-aea5-d9e1884aac50@kernel.org>
 <20260703091319.5kcsqjtx4e4rshsy@hu-kotarake-hyd.qualcomm.com>
 <7c7ab43f-45c0-48bc-921a-8820408c88c9@kernel.org>
 <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716084850.gssw67izy6vq36tg@hu-kotarake-hyd.qualcomm.com>

On Thu, Jul 16, 2026 at 02:18:50PM +0530, Rakesh Kota wrote:
> On Fri, Jul 03, 2026 at 11:16:59AM +0200, Krzysztof Kozlowski wrote:
> > On 03/07/2026 11:13, Rakesh Kota wrote:
> > > On Thu, Jul 02, 2026 at 01:28:35PM +0200, Krzysztof Kozlowski wrote:
> > >> On 02/07/2026 13:17, Rakesh Kota wrote:
> > >>> On Tue, Jun 30, 2026 at 04:16:13PM +0200, Konrad Dybcio wrote:
> > >>>> On 5/22/26 12:56 AM, Bjorn Andersson wrote:
> > >>>>> On Tue, May 19, 2026 at 12:29:38PM +0530, Rakesh Kota wrote:
> > >>>>>> On Mon, May 18, 2026 at 04:36:32PM +0200, Konrad Dybcio wrote:
> > >>>>>>> On 5/18/26 3:49 PM, Rakesh Kota wrote:
> > >>>>>>>> On batteryless boards powered by 12V DC adapters, registering the
> > >>>>>>>> power supply as BATTERY causes userspace to incorrectly trigger
> > >>>>>>>> battery power-saving sequences.
> > >>>>>>>
> > >>>>>>> Does battman really offer no way of differentiating whether a battery
> > >>>>>>> is *actually* present in such cases?
> > >>>>>>>
> > >>>>>>> What boards are affected?
> > >>>>>>>
> > >>>>>> Currently, batteryless support is only implemented for the
> > >>>>>> qcs6490-rb3gen2(Kodiak) board.
> > >>>>>>
> > >>>>>
> > >>>>> What do you mean?
> > >>>>>
> > >>>>> Are you saying that the pmic_glink firmware in Kodiak has a one-off hack
> > >>>>> that no other implementation of this firmware has?
> > >>>>>
> > >>>>> My Lenovo IdeaCentre (hamoa) doesn't have battery, what should I do now?
> > >>>>
> > >>>> I was going through my inbox.
> > >>>> This remains unanswered, and I don't see the discussion progressing
> > >>>> without resolving this.
> > >>>>
> > >>> To clarify — there is no platform-side hack involved. The Kodiak board
> > >>> has a batteryless variant, but the pmic_glink firmware provides no way
> > >>> to distinguish whether a battery is physically present or not. Since
> > >>> this can't be determined from firmware, we introduced a DT-based
> > >>> property to describe the hardware configuration explicitly.
> > >>>
> > >>> This is not Kodiak-specific — any batteryless board, including hamoa,
> > >>> can use the same DT property to avoid incorrect BATTERY registration
> > >>
> > >> Unfortunately the answer might be: fix your firmware. Since your
> > >> firmware is the interface and we do not expose battery in DT, then you
> > >> do not get additional properties. You made conscious design choice of
> > >> abstracting some things in the firmware, so you do control that part of
> > >> the software stack. If you make one choice, it might lead to other, like
> > >> rejecting such properties.
> > >>
> > > 
> > > This is a hardware limitation — both the debug board and batteryless
> > > platform use the same Batt_ID resistor (10K), so the firmware has no way
> > > to distinguish between the two at runtime. There is nothing to fix on
> > > the firmware side.
> > > 
> > > Given this, would a new compatible string (e.g.,qcom,pmic-glink-batteryless)
> > > be preferred over a DT property, or do you have another suggestion?
> > 
> > Debug board is not a end device, thus you basically have only one real
> > use case: battery less. Treat everything that.
> 
> 
> can we have 2 supplies added - (fake) battery and mains?  if we detect 10K bat id?
> since mobile/production platforms share the same firmware and driver code,
> the debug board still requires a fake battery registration to keep the common
> code path functional. In that scenario, should we register both the main power
> supply (DC adapter) and a fake battery, so the shared code continues to work
> correctly without requiring platform-specific divergence?
> 

My Hamoa-based PC (desktop) currently reports: ac, battery, usb, and
wireless. I would expect that it reports on AC (or no battmgr
interfaces?).

If I understand what you're saying, the pmic-glink firmware is generic
across all Hamoa targets, so there is no configuration in that firmware
to differentiate between this and a laptop usecase?

Similarly, my Hamoa laptop doesn't have wireless charging, but you're
saying the pmic-glink firmware doesn't know about this - it just don't
get any input power on those pins?


I think this is similar to if we had a discrete charger block that we
describe in DeviceTree, we would somehow have to describe the
"configuration" of that component.

But I don't think you considered those other use cases. Perhaps this
should be an optional qcom,battmgr-interfaces = "ac", "usb" ...; taking
the list of interfaces that is actually implemented.

Regards,
Bjorn

> regards
> Rakesh Kota
