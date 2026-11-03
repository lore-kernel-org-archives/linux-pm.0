Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671600;
	b=Qrn0ApCmUSMNiNJbADCN54pA/DUgpanRCujhuKV5DG5xQVD5QXI3mFiwSearAf3SIgUt
	 FJw/1WlZgkSv6p9Vsn7HOjMewCT3UrhUtwKgMbmjdoeOpMqMB2/axYQgdK05IJi4cBCy9
	 XdT9gNk6i0iryd55kwSkvO/CvPHrZ3tu1ZxNjSX3VMUmw1SevP5T2lu2m5W4hB/iohLkb
	 vYQxXTednK5MzGaRGB9vTEzNm2Xo14aP1f/XLgjKV1j0WS3j7VoMCCcuGro90tb3GfQoq
	 XHbEovuL8yWq5Q3X/4qCRgQEcDsFT27XHCD6P/inqcIk93vJv93KwJWjyS2leQCI/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7edVmlDXqBmOKChW+ZBxMZA1iVKu3C6UNjM+2ZNf5wM=;
	b=2QgzbhhmtP4DJ+i8QIeaRFl6AFQsfQ8Kw8c6zaBEzVCVdnjRHPD7ktlqolm3boSzjNQs
	 fzI1EhKVXrJtRknYZExpn3eWQPeLqQE5ah2vDdKHywipUOyx8zCR7+Eox9WksTnZrh/0Q
	 elwBHjf0xqABACotTZYUKLbVSGVw3FkgDvbOnAhQ7Z1vsOJZRInpQQ34ubrDMG8bO6uy0
	 fyq07KFvon4opuDG6nUpwFtYxiUwiN9YLNCYG6lLdab2HjwqOYuiOsQML/ahEZ/H6whg7
	 RokFSvt2nscRH0eNoxWsb2CbeT9VApL9IzWZQk2OQ+zsk4jsOU+gTiwHrbQ3h/zntUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mAQ0+p5l;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD7606D802
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 02:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DD7606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mAQ0+p5l
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a3c08d6928so4485138c88.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 18:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793671599; x=1794276399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7edVmlDXqBmOKChW+ZBxMZA1iVKu3C6UNjM+2ZNf5wM=;
        b=mAQ0+p5lGe83v747xCyqCS4N8Akjbdkj3F4Iz2/8iImspy/v52+UuU1pE1/Bf6MR50
         E2qDfWgV7bzTU9JYVsGuVRf/bSzdw7SGqRzm0piGjvkzs5eN3BDwZTqZ3vUQsCyWwqzT
         eKkyuVd25qAhw0WgVLwLZD9VIBXnP3Zi75qdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671599; x=1794276399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7edVmlDXqBmOKChW+ZBxMZA1iVKu3C6UNjM+2ZNf5wM=;
        b=nlSj+cWD0iXM56uRZeQdIZ/PU8HuGRqs8jR9RCFuEb47fbhW/9NcalwsQFO2p0/6Om
         LuboxJVIKQvUCJnlx0WhxRR2Q2uCFurckXKzVAhaoW26tLDnix9zG91lKRQLsSyzSPcB
         KghW1qgtb59KEACWtQHROQMZ+YIa48lAJnmPIE9OHlVvrlYVCpKa+PakDjrbXupBR6xR
         M4qCXUvKXk0jKfQZuMHHClXNzyvR/Eh97UafGEbwNuK1N7HcniFTltb3uBkwAVJZ/BAG
         F458qoQN53wwIx/ZeU+pEHVfk4dRrZsNnZ75PoA3P4FTuNDrQIW6jF/cOfk3aFWNoyOx
         dmPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxx+q6oNC+lmkc6C3Efz/2Q9ic6pphe00H0bw3xZnlGIi6yNz49SjHboOPYJkvdpV56TNr+bjeICA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPSSJNMSXY7Uz3qc5VjNRw1uuhMCxEoMPYsQrLD1VDLNQr9gU7
	BIg2mtsp/RNiO3Vw5kGEP/pdJPJq5zcDHq9halca/u0n0nnPX17GkQ9O6AMXOHHH7g==
X-Gm-Gg: AYBFou2Yl/PJmnBByFrLxDXbDpUmR1kj/Vhau7aEjFdsC5Xi/c8f3w7RPUIxbfB7dWy
	yLsSx2QpLP9RSM7Ga8hqs1X4RKyMCwe9JViNL7SYbUNreqBcYdxKNV+88XPAXRXML5vS0MD7TSR
	mb9lYtAGcY5DJDDd79+YVU2VWdzp5boKie0ZbHZRhxsAzzAEff+htPFIDCtd86CA5l3rn80A9PU
	ShJBOSSCDHzEyNf8w6JxWAGrM6TMTp+Bs4CPIIRxkh2ET5KzZ0iG8LL8C645bJU8nj693VQfc6r
	AFTn+EJonKwJpuO2Hj8CPowd4j5UMkS2XgFkbQ7If8m4ClRkx/RYUmDn+35XcJDwuNbqWZBubCW
	ZFPa726JdjKwltb+aUD3cTAxaUZpglUgs+iuQEUgD1BESemLbfMWbrszbUm4gEk/scpvOg/Immk
	f/TDhQus4HI8MW0ecmg4CbL6fMZULJCYnUtAYW+xy/7+hs9cUKYTULB8mHIBBigXDVNT863neew
	BjJbIwq5DK8gNpETJUSIKnnl8Mez0FBYJycwKWRBccEVTbIAwmP7Uy2H/eAcy7Do+Kc+59ZOSd0
	kvpm6wLxlBH2tcByhO8IMHnod7rqkn1fiUEhGOjrLFoweFjSnD7JQes11FtHrY/TVNM=
X-Received: by 2002:a05:7023:a56:20b0:1b2:3742:828e with SMTP id a92af1059eb24-1b23742830emr3971156c88.3.1793671599060;
        Mon, 02 Nov 2026 18:06:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:c57d:c93d:3543:aab5])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1ac19f4a04esm37837284c88.15.2026.11.02.18.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 18:06:38 -0800 (PST)
Date: Mon, 2 Nov 2026 18:06:36 -0800
From: Brian Norris <briannorris@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 0/9] google: Add support for Laguna CPM
Message-ID: <aulBrFWi54E6a7Br@google.com>
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261028-armored-glistening-cheetah-6f3070@quoll>
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
In-Reply-To: <20261028-armored-glistening-cheetah-6f3070@quoll>

On Wed, Oct 28, 2026 at 02:24:35PM +0100, Krzysztof Kozlowski wrote:
> Either you expect review or not. RFC means no.

OK, PATCH.

> If that's patch, then at
> the top level of cover letter, as the most important thing, you explain
> the dependency and merging proposal of this.

OK, I'll try to move it up. To be fair though, every change that has any
dependency is clearly noted in its below-the-fold notes.

> You combined here like 5
> different subsystens...

What do you recommend here? I believe the general principles of DT
binding development suggest there should be a single binding doc for
describing the "Central Power Manager" (and the services it supports).
CPM supports functionality covered by many subsystems.

While in theory, bindings can be written without corresponding software
support (drivers), in practice it usually works out better to develop
them together, to prove that the binding describes the hardware/firmware
sufficiently.

And even if the binding goes separately, I don't think I can 100% split
the driver support by subsystem, as they all require the same underlying
CPM helpers, and those helpers don't have much meaning without their
clients. So some multi-subsystem work is still necessary IMO.

So I don't really see how I can address your complaint. But I'm open to
your ideas.

Brian
