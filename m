Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D731F1513
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731367; cv=none; b=d9SfgoCHo+D3EKyBkljWTYL3cDwfv52GuyDQOyhKQEtFPhEEgM5fKiBSmd/IcD0V0p81NyyouUg99F3kriJCEV7hn7tjdpJi7v3pQg8kq8bd2HEGERUizkOXG86O0jDBTvRZ4zsbBeKuTXrliZXT11+PAudqtqbPPvzMctk1+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731367; c=relaxed/simple;
	bh=tGoKoocLWMEpIHHp0Hn7XhBgRZl4XoI/VXMo8hYyFUg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=DP7kHttUPValwD4hnCXphJMVPG3MJHh8qeBv8q6yLfoc7ZrbtWrlkmGBzV4SGOd3EOlEymCIgzILYDj7b2tj97zt9Y9vBW0DIEBgsmWKMG1uJ5soZ0sC4MZ0KT3Rdk7vgA+1kBk9bNNHkP4OpNHpJyBkxyuT/iTqCWWjBIEhnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=GosmovSW; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="GosmovSW"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=55500749e8=ms@dev.tdt.de>)
	id 1w2OIY-00EI7p-2C; Tue, 17 Mar 2026 07:53:02 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w2OIX-00FObU-I1; Tue, 17 Mar 2026 07:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773730381;
	bh=tGoKoocLWMEpIHHp0Hn7XhBgRZl4XoI/VXMo8hYyFUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GosmovSWUd8k8899cf6i/S1ISxLLsNsu6vjYbCHnXwOE47cDrwsRP+9T8TY026u8q
	 5wymbg63WRBoqYZKeQqK7vcANYgJEHQ+k/lCcBvp+BoKEvC68qqdrtxosuw9ycTkh9
	 JJrEk2+gr3tMuI5lFSCAMnrLKPnUWLUcEDgqmFl2OeFMEhcp35rpXn0piM5B/C4qlN
	 Y/pLqn1a2KjdLUF3XicVGsqcZGnY4OWjZ2mnpQXHeGrW6oRXRdT1UFY/XXNW6jDfIW
	 0QMSRdQeaMPG90g8EEzT4Xk/r0VizIQZ1cECKfnKM3zGhbY07XwJXcReK3ilKxE7Sz
	 202WnYvV9Vqrg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 31FFB240041;
	Tue, 17 Mar 2026 07:53:01 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 20B37240036;
	Tue, 17 Mar 2026 07:53:01 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 6E63C2379F;
	Tue, 17 Mar 2026 07:53:00 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 17 Mar 2026 07:53:00 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH 0/2] x86/cpu: P-state support for Lightning Mountain
Organization: TDT AG
In-Reply-To: <42e71412208dcb6fc75bf5b606bd2ec0f0eaa21e.camel@linux.intel.com>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
 <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
 <3e828b47bacf84ca8d19a024ac71778c@dev.tdt.de>
 <42e71412208dcb6fc75bf5b606bd2ec0f0eaa21e.camel@linux.intel.com>
Message-ID: <ca1c83f9bf245e1c931f013b814690c1@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1773730381-08E315F5-DE929F70/0/0
X-purgate: clean

On 2026-03-09 16:57, srinivas pandruvada wrote:
> On Mon, 2026-03-09 at 07:53 +0100, Martin Schiller wrote:
>> On 2026-03-06 18:59, Rafael J. Wysocki wrote:
>> > On Fri, Mar 6, 2026 at 9:27=E2=80=AFAM Martin Schiller <ms@dev.tdt.d=
e>
>> > wrote:
>> > >
>> > > This patch set contains 2 commits to get P-state support for
>> > > Intel /
>> > > MaxLinear Lightning Mountain. The first adds the needed code to
>> > > the
>> > > intel_pstate driver. The second adds a workaround to the x86/cpu
>> > > subsystem to enable EIST on all cpus.
>> >
>> > Can you please combine the patches?
>> >
>> > Or does the first one work just fine without the second one?
>>=20
>> Well, the first patch can basically be applied without the second
>> one,
>> but then frequency stepping will only work on the first cpu core.
>>=20
>> I split the two changes because they apply to different parts of the
>> kernel sources.
>>=20
>> But you're probably right, and it makes sense to combine the two
>> patches.
>>=20
>>=20
>> BTW: The original code from the MaxLinear SDK enables EIST in the
>> intel_pstate driver, but I don't think that's the right place for it.
>=20
> This is a special case. But intel_pstate driver can be disabled from
> kernel command line to use acpi cpufreq driver. So in that case
> enabling in intel_pstate will not help.

You're basically right, but the MaxLinear Lightning Mountain doesn't
support ACPI either, so the acpi cpufreq driver wouldn't work anyway.

So perhaps it would be best after all if I integrated this routine
into the intel_pstate driver.

Regards,
Martin
