Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995659;
	b=lLKoaW+3nSFGE901oAiIkOVaF5TyiieIj71fWcLVwhXoav7yC9iUbXKfABGO7Ahbes8T
	 QIby64wStgS3f5nkWVvjo3/MYKerjGltk14b4ugf7lHd3tf1YaUikutC3uSiEOw2mP9mi
	 mAuRvNWZHCK1K9Mxfb76hKK4K4r0S4Q2rA7lyevBK2qEHhG/moXRA72bUl5TEaLaoQdlo
	 DgyAWmsz3WMoyYqrjyhjFc/v9caiEBqxMr/7+dF1ehSxEhygDws9M/HZQFmCpAPhBDLI+
	 NOV8wG/9myOrL+QP9YVlieAFEBoNADO0pZamUJKL6c1SXVnvo6+n6nP/WZCbnnpMc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995659;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HBSrhZLBuL5ksZaPW5BKifL2afrXK2hzhDX1MeTPVeY=;
	b=q6atDORPI4Z+Ip9lLPecfGCPBnFh4U1PbhPf8F40UzO6t0mUpEahRgnmOC56yLBuCxLA
	 UxALWO+mq1mKMkN5etqml/gWOxDv+FOASbWVUZPvicLOQ+3b49nIE88v7oIKQsf64nMZv
	 vGM/2vfTQLllLdnJgHOhCJ2zDaXE5g/3m76O9ERq4/VzsxnoMGKqXb3+8ltj+l/is+fho
	 wJYBgiqhgPybTpni5o/s0Zyw2JXRUJ8vlhqFjsoHYL894Rliiy/VXl5/YhyNDrogzg52M
	 L9iz8gFpzECk270JFKolVg2mQyPa7xrW44WosvLRbTjJ2s8v9ItCkWEO6JwJ4BTrKnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="atd1/6+T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DE606A326;
	Fri,  6 Nov 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atd1/6+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7931F1F0089F;
	Fri,  6 Nov 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793995658;
	bh=HBSrhZLBuL5ksZaPW5BKifL2afrXK2hzhDX1MeTPVeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=atd1/6+TQFYXu9NqQyPVYqzNfp0yf1ut30x2evBUUBQJ9xLMVa7cbMisY0jv/geuL
	 EovDVVhB/Bwp3LmRkm9cMvKDb7X30GuXI2LICRGsWx2zqCoLw0ktCFY/3uL9+JaS6s
	 2AWHIWInlzNnw+v7VbKL7ukofT7W4gWuLs9Hh7G4og+elaBvtKCVcE26Y63RytqhBc
	 EGlL/uq0A50SXdHM1ujr9bhUiSHgUywX1iJf+0lEZDyUsUqOPqYhVkI4sV3YLy9m5G
	 4iGutn2iSJJRqIwDS3hok9Hq21zL1Pg8lBoCDDFgPOuU/TCPjpasyuH2mAtlpalkoD
	 uTmgSOJlg40nQ==
Date: Fri, 6 Nov 2026 14:07:35 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: Use signed integers for
 coefficients
Message-ID: <20261106200735.GA1172491-robh@kernel.org>
References: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
 <20261106-portable-alluring-hedgehog-9e2aed@quoll>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-portable-alluring-hedgehog-9e2aed@quoll>

On Fri, Nov 06, 2026 at 02:03:24PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 03, 2026 at 10:43:57PM +0100, Daniel Lezcano wrote:
> > The coefficients property describes the coefficients of a linear
> > equation used to derive a thermal zone temperature. Both the slope
> > and the constant offset can be negative, and the thermal core stores
> > them as signed integers.
> > 
> > Existing Device Trees already rely on signed values. OMAP4460 uses
> > an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
> > Broadcom platforms also use negative slopes. Declaring the property
> > as uint32-array does not represent these values correctly.
> > 
> > Change the property type to int32-array so schema validation decodes
> > the cells as signed 32-bit integers, matching their intended meaning
> > and the thermal implementation. The cell width and binary encoding
> > remain unchanged, preserving compatibility with existing Device
> > Trees.
> > 
> > Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> drivers/thermal/thermal_of.c still uses u32. Maybe we should have
> of_property_read_s32_array() wrapper so the binding can match the ABI
> code exactly?
> 
> Rob?

Yes, please. I did a pass fixing type mismatches so it would be good to 
not add new ones.

Rob
