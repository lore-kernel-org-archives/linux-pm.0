Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81B318146;
	Thu,  2 Apr 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144558; cv=none; b=BjnongWdh3Q6mQuzVIG69cdEC0ZMSI5ldMBKisSG9aZuOm03wqI+jQ1s+UUfkkV/Z+NVgxjKzLYhRohglwAp6qr3eNOqSfdcsvKmkFKXtK/LT34M0u9xez5/+FB7vqyBWsgJOrQxs0jqGvloN2scv42CAGp5xtYqg2PWFWN9dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144558; c=relaxed/simple;
	bh=q2gMIosKfYqN5OWgkJ2zES0s/Vi1cDRBUifa796ASX8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rCAf/UUWnPQoo0P197qSmF4gE4mm/29zea1vka5Mopa8/ky1tJF55b1kYg09JxgKVUS26A4mrpHAc9gmcgFpdrMm+c8M+eFuzw2kMfnVKJGf8cJniYYIr6gKAVg2RKOzjqfdpi2HXrNNHtTzTv8GclVzReRJmTVxIA3H3bEbZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sWrd2yDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdkWkf7f; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sWrd2yDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdkWkf7f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 890837A0076;
	Thu,  2 Apr 2026 11:42:36 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775144556;
	 x=1775230956; bh=39+lUb8v10Q81OCIXut+z3qT12/7ok1KBnBtR2iFiSA=; b=
	sWrd2yDE8TB45AISiiErqsWcXhBQDcsEFoMnq2Eqv+5HkEqrwWb7bwfh48DyjkyL
	rWG0x1pdl6IFNxiJ0WReib1z0XCdixnT+kWYP52PCDioIw3POgDkCkdXXXjbsBBM
	2xhNwLPqIa4LZmAMJLZmcIwyjy7Gwk2ajO8B504WSoLl3vSSnl0qLmf5mruqg4aW
	WyHwDHCxCuxVMvxzdf7Samr2GgnhC4JGFucNHouutg6qOdf2VEHg7CjMR39T/VMN
	shDd2mczZ7O0iozJxZND6hTIFx4xFhO0tlfj4M5JyfNyAiTAa2M4ZfQdsSBa1/Xq
	E5k7VdpnMzW1MTknu6Eb+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775144556; x=
	1775230956; bh=39+lUb8v10Q81OCIXut+z3qT12/7ok1KBnBtR2iFiSA=; b=q
	dkWkf7fAtjaFSMeZjoEwaqXM8Zjbj5PrUrNgz7wXJwNGkzMyHbw0hHmHXGDpZaDR
	76sLlvlH4/QihAIJQmNJCWxNADBy8Za9fbChutwIeH0Gq9oucgFOkwmWUil9OwNK
	jwwCQsIDF/q5veQyolW6WAVybdMEtCRW0gDp1NmL7Ef2gKYKNXsMOMk2LVIGeaYc
	xc+cUCWkhLKCGWWc5oXS54PVX8063hnP3BBSWYbCoCur1g/8uLcGAQncbdMnCY/B
	/5Vr0MUKw/ooHVQdbL72IshERD0fCbx6OfHOQy4QEVwjfqAZ+EJSLmSqZYwqNwnJ
	I1/94Zs+so/YD2+AXPOPw==
X-ME-Sender: <xms:bI7OabIS_wmCPh10yaW87FwYq5TBu2cV7zc5scFi4xs5O2s2KiLtMg>
    <xme:bI7OaZ-1DeAcarWjeBgB-T2LH0Hdf4QRhWKvbeD6dHDIbGw6Dfvs-NeNIOPelcWu0
    sS7H8MO0291gMuD3UVeanyHYhNxL2NYlNwdd3bPZu6zeerdPlAtEf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffgnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghrghhlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghnih
    hvrghnnhgrnhdrshgrughhrghsihhvrghmsehoshhsrdhquhgrlhgtohhmmhdrtghomhdp
    rhgtphhtthhopehmrdifihhltgiihihnshhkihesshgrmhhsuhhnghdrtghomhdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bI7OaaNBArVXQkbbj6ZnorSatFUsutFOE8PRE98hjJjuOd6gc1cioA>
    <xmx:bI7OaYBfm4PbBwo__DintPX360Tij9AnSp8jqEUy48IA_5bLf9kJJg>
    <xmx:bI7OaXdngT6qJgc5oTVPzt-aKgE1b0TTrtzLMkEkzDmWMNuetLfn8Q>
    <xmx:bI7OaXMVq-iIG6XBhuqOmhkAuZAwTGi-f89lRtKiZeY-2GJRpG40UQ>
    <xmx:bI7OaXha8GFRDw6xOaTfgHcwO9y3eajWTtKXN5QQ8nr4S9lWL-Es9b9o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08AEF700065; Thu,  2 Apr 2026 11:42:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAU4EjFgTLs
Date: Thu, 02 Apr 2026 17:42:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <f402c8e8-cc71-4263-a51a-368a8a0e018f@app.fastmail.com>
In-Reply-To: 
 <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
References: <20260401191030.948046-1-arnd@kernel.org>
 <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026, at 17:38, Bartosz Golaszewski wrote:
> On Wed, Apr 1, 2026 at 9:10=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequenc=
ing/Kconfig
>> index 77c6d9227251..1c5f5820f5b7 100644
>> --- a/drivers/power/sequencing/Kconfig
>> +++ b/drivers/power/sequencing/Kconfig
>> @@ -39,6 +39,7 @@ config POWER_SEQUENCING_PCIE_M2
>>         tristate "PCIe M.2 connector power sequencing driver"
>>         depends on OF
>>         depends on PCI
>> +       depends on SERIAL_DEV_BUS
>>         select OF_DYNAMIC
>>         help
>>           Say Y here to enable the power sequencing driver for PCIe M=
.2
>> --
>> 2.39.5
>>
>
> I assume with this patch[1] from Mani, we no longer need this one?
>
> [1]=20
> https://lore.kernel.org/all/20260401070735.107162-2-manivannan.sadhasi=
vam@oss.qualcomm.com/

Depends on which one you mean with 'this one'.

My patch is needed with or without Mani's, while
his patch is harmless but does not fix the issue.

     Arnd
