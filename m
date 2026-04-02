Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F787362137;
	Thu,  2 Apr 2026 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149134; cv=none; b=IslgrNANwlyaPEK/shenxjz6pDPLbCYTzqbO5UKEosMaeXpWb0whsMU3Eg4dpzce185lxDhM9TOKU51cuMY2Q4+Ay/XJ7ytwKFvBvP4YNM03t1T8GSCNamOnv0NmByPUy9nq5Q9Mcevt2IW2UTRT7m+1IfBSHlMyXw2+mZGqKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149134; c=relaxed/simple;
	bh=yCHyC8tAscsGniexyDDHi62rR2sXVusuyLn2TrlmXjA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CTIFfCFrsT0YghtoLUThpp+B5wSBYcglM76vLZ/Z5d8SX30ZoIQTzEKD9fUtPUXp83i7weaHr8HZDaJkLi+5qYe8tDi5MnShGGuZDYNKvaNeX1oAdHlcmFIJyeea0+EP2rKsCs49jEkoLf3pfJI5Lkfu9lxtdHz9eS5nyMmmFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nKpZY5y5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU1AxJiR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nKpZY5y5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU1AxJiR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EABE7A016E;
	Thu,  2 Apr 2026 12:58:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 12:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775149121;
	 x=1775235521; bh=nBWlM70aWWpllp8dLyT/2JEEI3RzmM0moEP/FeQxR0A=; b=
	nKpZY5y5Vh8j4BmsEPw7lYjbh/q/aaWXq3/Qqcsqvt0pS0IVHMLd2cyhKJjw1tXv
	hMPEsT6OReM4hG8xTCzO9N3slrVKOAaZPG7dfMFSPtqjGINEm3Ku3hWfyeSK7Ytp
	x64vW0EkNsyJFMvXqOJlIjbdP/BsudR9aDByckyed5liBHcpVyVG4csqSGMYFyWW
	v4s/fAnTveVoGwVliOWuILufeIvbYpPpu+LqdSs9qZiljj+s/puLgV6RiFP+dQSl
	fh/HmxIUYT7f/RZEMmdTUzP+MC6I2yq2tu7JiwkxTWk6+PlMXbEHm90xR7mWtGDg
	SkvZBxmg1hlSL47ZAEwKkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775149121; x=
	1775235521; bh=nBWlM70aWWpllp8dLyT/2JEEI3RzmM0moEP/FeQxR0A=; b=a
	U1AxJiRmIm70KPNh2ea69jNOddoEe7uhefxoHtBkn2qDvuF4AjL/zgtfmZTFdi/U
	ZQ0VkcPuV0Lm3b5/b77q6/cRKtjiXesIcdEoEHSZg1Zb38k3PC++EMYV+uRFm0DG
	3BMMeqCkMT8DME+oaLBr7ok30JwN5yvWynmYf0TbsR+nbdY1gf667f0+PMcjILuu
	mBKn4HC7WSb9tIzfZY/TKjukCzRJuDzE6hoAdisELjZ2U/pbe3AlOzEk5nMbAyoW
	idLzaAe5bwmd4eLPOsBDyXgyWnNCQARDt6aGv/3AkSGZqEzLtzZysBFToLKklHlG
	6Fplo+kH77u5o26ErcS0w==
X-ME-Sender: <xms:QKDOaQms_h_mJEm94pwgfFnLW0G1JxGImjHwNGkNyU1bp95gpp2y9w>
    <xme:QKDOaaop2q8kxsQ-UtJsNDG0gXXt5TEOhIZKorhLhwZWH4jlmnXp0pn-z0BIMHPSk
    0Fz46seLsYlZpzRw4QDxT_14OLtMIjN1kWDxPkSBBEFqcdmlmproZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhglheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmhesoh
    hsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepmhdrfihilhgtiiihnhhskhhi
    sehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QKDOaZJ5L8UaKH9Y8MImnOiCZBLsalUJGw8Eda6CNvXytO8efWps6A>
    <xmx:QKDOaUPqcNkrk83YgdwJg2EKFGt0Wsj10rk8S1hRtIpfbgoNz4-gUQ>
    <xmx:QKDOaX6u3KrhgbQIZAj8-CTpvZPRmMI495rAnP0ofVL5rD1hdLtS4A>
    <xmx:QKDOaW6dzJnqRyr4nDG-IJoK9AnNa6djZ1ZX0q6hOwrtkqXj-YgGSQ>
    <xmx:QaDOaXl9lKPRbOA4tGj_c67JHrSQnQPAkoiGZDU2ra8l5czFYpNc-1Dh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96D52700065; Thu,  2 Apr 2026 12:58:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAU4EjFgTLs
Date: Thu, 02 Apr 2026 18:58:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <46769524-cbaf-4eb5-a27b-d2c710914226@app.fastmail.com>
In-Reply-To: 
 <CAMRc=MfHsKk7zb6E7MC2WT-dANQrnC7B2eX1dJb=__2=NnEGRg@mail.gmail.com>
References: <20260401191030.948046-1-arnd@kernel.org>
 <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
 <f402c8e8-cc71-4263-a51a-368a8a0e018f@app.fastmail.com>
 <CAMRc=MfHsKk7zb6E7MC2WT-dANQrnC7B2eX1dJb=__2=NnEGRg@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026, at 18:36, Bartosz Golaszewski wrote:
> On Thu, Apr 2, 2026 at 5:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>
> Mani's patch adds stubs for the symbols that the linker couldn't find
> in the build error you posted above. I thought this would fix the
> issue?

No, when you have POWER_SEQUENCING_PCIE_M2=3Dy and
CONFIG_SERIAL_DEV_BUS=3Dm, you still get the same build failure.

    Arnd
