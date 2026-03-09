Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A718DF9D
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040214; cv=none; b=NMt5GEDYJKoKJ05yO4C2HOrdoE6yORFATQsNkgfyZrRcJB2+QiOsxT2sWsfkeywv9LbWaqxn/cBN8go7PiRSKYJFuHNwsTrddP1o95cTCuCe6L2whNPyg97jh9HpZ24jYT6fu8mafkGFCW2jIZ5CXerbGMb6nU/iV+5rC/NsV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040214; c=relaxed/simple;
	bh=rXp1QS8moIqf607l9ilW8xjJYZWHhpzj0szdx0XiLqo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=mjNtS6wrGVhf6WHEcMUf4L96EhBjG/bsvt7W48/C0hmfqNoJFJ1xs7kpRhoN1X5muXb4ovscAbd/GSGZzrdbpfNW3L1x5YOCwlXVl8wuTGF4KFBu9YccID7Hb4suSE8MXZ5RklZJN8WqVh23kUjhdWsrUebE0jZxBlbCKjKgwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=tN9kpjlo; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="tN9kpjlo"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=5542c7fda1=ms@dev.tdt.de>)
	id 1vzUUv-007aoX-6C; Mon, 09 Mar 2026 07:53:49 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vzUUu-00GFJG-Ia; Mon, 09 Mar 2026 07:53:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1773039224;
	bh=rXp1QS8moIqf607l9ilW8xjJYZWHhpzj0szdx0XiLqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tN9kpjloDHZAc/5OxWBkcwGN6vBbOyZCNEonmfhGP6cNXxxE5eRXCTheinGrtRn/6
	 mMUrXnkShH7jvMtSk2Il9RX0QhCEBxzcYtvwbK8DqqwJ1YRHCAw8WlQblg9mAlmkgn
	 BQOjNRHqYlNQi44sBouI8GjIzj5FsnXLk2jDtsdwCbdTYviXRHgIrUTIg6O/upS11p
	 z58y3MhWk31GiIeweXahZAI+WUvGq8CWgPcuNsHpEDpnM2eKie9EQlNMuvco53NPNP
	 sWWOhcdQFRtBToY5oe+WD/3UR8xkMgJ1Ahyc/8Tcmi1dMLSqLnQ0xrfG7PIDGko38s
	 WQWRUMCwBKuyw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 7DBF4240041;
	Mon,  9 Mar 2026 07:53:44 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6495D240036;
	Mon,  9 Mar 2026 07:53:44 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 85AE423431;
	Mon,  9 Mar 2026 07:53:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 09 Mar 2026 07:53:40 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH 0/2] x86/cpu: P-state support for Lightning Mountain
Organization: TDT AG
In-Reply-To: <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
 <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
Message-ID: <3e828b47bacf84ca8d19a024ac71778c@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1773039228-E651E769-73B51FFA/0/0

On 2026-03-06 18:59, Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 9:27=E2=80=AFAM Martin Schiller <ms@dev.tdt.de> =
wrote:
>>=20
>> This patch set contains 2 commits to get P-state support for Intel /
>> MaxLinear Lightning Mountain. The first adds the needed code to the
>> intel_pstate driver. The second adds a workaround to the x86/cpu
>> subsystem to enable EIST on all cpus.
>=20
> Can you please combine the patches?
>=20
> Or does the first one work just fine without the second one?

Well, the first patch can basically be applied without the second one,
but then frequency stepping will only work on the first cpu core.

I split the two changes because they apply to different parts of the
kernel sources.

But you're probably right, and it makes sense to combine the two
patches.


BTW: The original code from the MaxLinear SDK enables EIST in the
intel_pstate driver, but I don't think that's the right place for it.
