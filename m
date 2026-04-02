Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C26BFCE;
	Thu,  2 Apr 2026 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120516; cv=none; b=H/8q2DzY1TC3dbXepMUtLBksDgXMcGe2bV+hca4pOiLiJ6WDjiuIusGmipFLfxQ8deFFw4XQnErU8kYiqMAQZ07r/wJ2lAvSQFVTmL82UDhp4baIrdAF/VRjqUhAsMDEGPK8Cx1Ant9RcLDC30v1Mcl3DVihHAD4PB2xoQDqYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120516; c=relaxed/simple;
	bh=rnDFMjW2LikpIjnAgS0GzyLCoWAhm9wTUO9CHW9Jd24=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r0IYTmazk1aPQuOO1qL2OoLQbBme56Wxviy0MYgRjKRuGP5tOGclIldA9KAiick7lC81IDCvhRmyGlXHvcSdVTOtbv9vBOK9eEOw1D5C1QMhevsbIJAAEEokhDEuS4syR4gyiAcpCzF+1R4rgCR6C6u7NOVWP3uD6ksy7Uw/s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R9wE6K25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0AeAtch; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R9wE6K25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0AeAtch"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE1B1EC0089;
	Thu,  2 Apr 2026 05:01:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775120513;
	 x=1775206913; bh=5rKGrYROyjxnFXk5wlj6qjWWm4QwbXPT4lY95Tppe/A=; b=
	R9wE6K25MtqjnOImpaYsaXBGK0ewSA9fc4kVCfDkO0JazLH6nSaR1j7UfHps7bCH
	E0BaadTTeK9/DRKbV6H9iY8qQdGjQqsYY5g50978fKSBhdj/2LIhHYIkSY1L9qni
	0Z+ly3+Ht3ypz0UBm3M81kvwm1zK0m7RKqLPFWI3mSmdMO6T4Jbz4eXDG4b7Xxnq
	TCN70kMUEykwq+VRnhrBSYNUjS5TszhHg2HKxCkIuWJgX8kkjqk+6Xk1CshbSFYp
	YF+MFJrN+oQrmkCCsZEl3kTE80pZubD1ZRAQQRNumVXj8GHI/zZjzsniQk3g/SPt
	QeuHu0MmPLvzhMm4Z8qr8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775120513; x=
	1775206913; bh=5rKGrYROyjxnFXk5wlj6qjWWm4QwbXPT4lY95Tppe/A=; b=H
	0AeAtche/BKgmujVR0jRzyHO4g6/t3qjbO9u9REnhJOTphvDm/AhK88zR3bfdOXH
	5ikKhlEE+r3ebyDXZs+L7SZtheGvm4jpfaUJh+jgubt14AFmby3CtVj26j0RBVtZ
	zRp5keiotuQRMpzL+66V4Q+MpzA9sbcipGBDbZBeCf98Y+lH6J2tQvN3wrhbu1X/
	/XZAcmZh1aUNQ5Z9K+BJjBSfsYGUhPbkbX/Z46ylJj6IjsqGm9IICAgNa5OyThwi
	59JLnAav3R4jrpN35//k5mGRSbcQARBtge/XHxburbySqIUzXodGACG66Ywg89nG
	HKwAhYmK/rGmXXrczzU1A==
X-ME-Sender: <xms:gTDOafLsA6JBZAPokg6vEEw5UUo8CKoo-w5frkCkVkPGn-m1aLWE1A>
    <xme:gTDOad8iNKn5r3MKzK0McbZFYgb7Nl6KJliALFuiUjCHh4I5BS7gmVuoEwLaq3I8P
    dWgiVpSxRvYDtynvhkoEzKdgfnw8u54f6vFkDLWhWXPGDCqpqu7Hj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhglheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhope
    hmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehoshhsrdhquhgrlhgtohhmmhdr
    tghomhdprhgtphhtthhopehmrdifihhltgiihihnshhkihesshgrmhhsuhhnghdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gTDOaV5jo_IZPeZi9Ghe2V69nwKHcK7jCTWj64EEEHxcreWUOjEFbw>
    <xmx:gTDOaVejM2x8zdBsIe4HkVMRX7QUZ9LraQZApZ3hrrPjRzjolOjMqg>
    <xmx:gTDOaQGLDgTNKQl2JZPA7qbrlYxKzHrf9rU2K8kIjGW0yTonL4aHSA>
    <xmx:gTDOaeTKjNspW-ebluwI2f43J-FvPbxxv0RidceBlrI3Ag8CiLJctA>
    <xmx:gTDOafzTMfymF0NNPKl7zGQUYStokVwEsddFa3F8HNnDcYGvwhZ95QgG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59387700065; Thu,  2 Apr 2026 05:01:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGRhLEiVqBvR
Date: Thu, 02 Apr 2026 11:01:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>, "Rob Herring" <robh@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <b8842982-0492-47ba-a904-df38d0b3bec6@app.fastmail.com>
In-Reply-To: 
 <CAMRc=McYdb-R6QpEKn+VoB4KNKLUJzT82BVzBUYdX+HEqhyB1w@mail.gmail.com>
References: <20260401091847.305294-1-arnd@kernel.org>
 <CAMRc=McYdb-R6QpEKn+VoB4KNKLUJzT82BVzBUYdX+HEqhyB1w@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: enforce PCI and OF dependencies
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026, at 10:39, Bartosz Golaszewski wrote:
> On Wed, Apr 1, 2026 at 11:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
> Hi Arnd,
>
> Mani posted the following series[1]. It seems to me it fixes at least
> some of the build issues.

I don't think that covers the case of CONFIG_SERIAL_DEV_BUS=3Dm
with POWER_SEQUENCING_PCIE_M2. Trying to make this work with
compile testing adds a lot of complexity for little benefit,
so I think my second patch is better there. SERIAL_DEV_BUS
is visible on all architectures, so compile-testing works
fine on allmodconfig and randconfig builds either way.

For PCI it's similar: while you can't build test this on
architectures without PCI (m68k, hexagon, ...), nobody
cares, and you just make the driver uglier, though there is
less risk of introducing additional regressions here.

Obviously the m2 pwrseq driver has a real dependency on pcie,
so there is no point trying to make it build with PCI=3Dn,
the same way we don't allow building normal PCI device drivers
without PCI support.

> I would really prefer to keep the COMPILE_TEST option here. I'm seeing
> that only some of the symbols depending on OF_DYNAMIC are stubbed out.
> Rob: is there any reason for that? Would you be willing to Ack a patch
> adding stubs for the remainder and me taking it along with the pwrseq
> changes?

The idea with OF_DYNAMIC is that any driver that uses it should
'select' that symbol, so there is no need for stubs.

More generally: I think the stub helpers in headers are useful
for features that are truly optional, e.g. a driver may be
able to light LEDs if they are enabled but still work fine without
that. COMPILE_TEST in turn is nice when it enables building
platform specific drivers on other platforms. The combination of
the two causes more problems than it helps: if a driver has
a clear dependency on a particular subsystem, we should just
enforce that in Kconfig and not artificially allow compile
testing a configuration that is neither useful in practice
nor hard to build test already.

      Arnd
