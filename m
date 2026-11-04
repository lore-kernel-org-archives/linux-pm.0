Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762017;
	b=UpX3JqgHnUTayUYzxhBb2/IG7klHvHUzgmB/igRbiU5aD/plLbD+t3Z7BIbQ16Y5lBeG
	 x7AUmqLyMRRqhsn2gAO1FhBlCHIavwGMUeFMVI8sILF0SsECT5TFYQGu1ZpSbBmf9x5Hq
	 NgD1NBFP+fKUeV1eX4hHp5203ehPG/GUpeYbVu6zeV3M6KNtxUGKB7myYLL0i7/7DvZdB
	 /W6O5Hyx51xwC8yBzg6XWyXAnXiJ9jZFscLavmiL1M0Z7A5oEXrofo4jeZaSAA6yDqbgj
	 Gqn+sbMVzpsAvP+UgPGXyO1V3Ee3V7on+FdydSB0rJbJS0rcjuu29rDHAMb63XGe0Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762017;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=tDlhVDgB6V0I6/7xMSC9MOYxVyqYla/KoIEJreU7nUo=;
	b=MlvyUn7o+vye42icpHOHC64V3Nwbw8VVJGYx8AafCOWZopcdj0tV9J7adC4Brr44AQnY
	 AV4TzylrCYCCcTPZzEzYO6BGy1pVpXyD1eliTRLNt2YAjPMfa/BNReJjTnj7jiHFJZSi+
	 DpwsuFxVswOSBNw5NSFm7omA+XPUthrS3X7Rfrbkzd3PZXZrFMmj+JzcJurQEjoEyAWlQ
	 omuthFoRvm/GC5CNSzC4Psj/OZvOlgFc0kOELWdumiu6XHML4Tfeyvw0mYitroj+pln8L
	 P+2IXPopIM1IGXL5D28LgeVi2iaTWzqQ0cvNwgI8Gqx85eykRPtx7QOUvQfd5pND5xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=efault@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="O2WMP/kk";
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD5606A31B;
	Wed,  4 Nov 2026 03:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDD5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=efault@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=O2WMP/kk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793762013; x=1794366813; i=efault@gmx.de;
	bh=tDlhVDgB6V0I6/7xMSC9MOYxVyqYla/KoIEJreU7nUo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O2WMP/kkyTpV9a8Vi5/iq75KiCi6uAEznbBIqiD6heuvOrlTvJW7qHnQCGarioFb
	 JUOMLqA9VUfwJBMdDI4Xf0rxelXKXvtvNn++Fa1xheznczCWIZaH0TnZ5hjXgOJ/z
	 Vg77DrLFshpBGfj7ZwXkvPCBj9nxqDuTXLrl+izWVnfkDLje0pomwPR788trnZLo0
	 jjMBRianOkT8YGMHvucDjKhu2S0GLtAqNPAIpvWGFOThieINVX0hVPlvSOJAQ1/zD
	 fm9eAwZ9v4xllWCqDdhRwWXUt/kjF8DEh0z+5w776vPn+hhXmufKTqmkbRDzReXpN
	 IpetDrn6xVGNHpqAZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1x1gQa1cOT-00NVNj; Wed, 04
 Nov 2026 04:13:33 +0100
Message-ID: <32db09358aecb92c55c8c1295fa71b6a73306999.camel@gmx.de>
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
From: Mike Galbraith <efault@gmx.de>
To: Francesco Nigro <nigro.fra@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Valentin Schneider	 <vschneid@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
 linux-kernel@vger.kernel.org, 	linux-pm@vger.kernel.org
Date: Wed, 04 Nov 2026 04:13:31 +0100
In-Reply-To: <20261103233352.2282883-1-nigro.fra@gmail.com>
References: <20261103154603.1893325-1-nigro.fra@gmail.com>
		 <25edb6cd36cb77b82b40826b97232438f1443516.camel@gmx.de>
	 <20261103233352.2282883-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Provags-ID: V03:K1:vtIIbU2jIIdROEFDURy70l9QvWDdwRw2tvSq01eGNRTohQi6ZKZ
 C7X4uDcPwS33H5LuzWKCg5EfeB4QW73fSkvBctx6xXhR37R9VP/wKH3I14iF+xXgV/lCfz7
 iz3E1iV1zz4RDntdRt7b960juFImzrRJ/or86/v8lkym8xbmV+HGcyq/5InKMPNYHCc6Y90
 mmFMawk/pGM5jbeci4Q5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KcAmL5sPIcA=;U89bk7orG7go+s1sz6MHeCDRO8k
 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

On Wed, 2026-11-04 at 00:33 +0100, Francesco Nigro wrote:
>=20
> Is it expected that ITMT keeps two busy threads on the same two
> top-ranked CPUs, sometimes on the same one, while the other allowed
> CPUs are idle?

In your specific case, dunno.  In general, absolutely.

	-Mike
