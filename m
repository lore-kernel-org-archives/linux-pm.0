Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA2433059
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534148; cv=none; b=nyAPX0ptHRMF1YUMNG6YfInl/32ChF2uDPMeUBc0lN04uLFsmpR4hK7EY2+gG8HMr7dL3fENJHEvO8wAp2uvX3KAw+/3XKuVOQYV43ePndVzPYYfBPdRzDCBiOfNhDKZYVCCKDCf+Gl7VaDD1OHHN58KrY2mzlWZiYxv3rLAqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534148; c=relaxed/simple;
	bh=0nY9fKoJJBS9kQQL2Pz4lkzIHWLG89ECleCOdO02RIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI8cEg73vXqC3GjDDWZ3zea5B0umXMILVY30fLTykfsJvMQsiBfz/GCuwq1nbppYZ1zwnbEiFToCydUnxNt3Ao0SUZAshvcM8spmdw58lxbSUvzHWUr8SG2alu/wCGrwizRWym7MQwW7v63xNxwEMQThbIp4PEoP0V+cgPsougc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blvoe04O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blvoe04O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3C71F00ADE
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786534147;
	bh=0nY9fKoJJBS9kQQL2Pz4lkzIHWLG89ECleCOdO02RIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Blvoe04OuGAWkJng8xtrxKqFwBdA1ijFBbxsbG9Wj7GfSqwfEULav3lxZhD+3l28W
	 3EsIcJpMZ36VU/KQUQwUk6CqexR5G4FW7V2H9AamJJa3T51KClaOrubn3F3bXwtGnK
	 XlKALaO3MDPKPqpzrrQuGA4qmM58aPJF9GubFSm1GePTQhjDuGuCZfrvwzAdVFNO2A
	 V5C1pMe3nhhWdj/PxYSmFgVY10bSxR0Pn0wi0+EYdw4ctxepwMvg2EAIHlT0j7y5mk
	 WL7GsVUVTAyceLePjz/qLpqbDq2IoMiPPPWG70QlrQFamHJd2sXqULt1FnM4YvNas9
	 wITuiSNCh0VaQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so779122e87.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:29:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RprskbUW7Oi74Ot0sNJH6bEcXO/n4E/ypptiwnpRaQ3V0Fi4pji9jHuMRcNe91FyOGZepQQu8GAdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JXX3oInQfhuHyjMd2Z61ZtqdV0ziy2MvI+AJzxImBVSJtdz/
	dwbk5TrPtDCIVYhWKFkrQNUasRgL3Y4GesycEFxK3mTmyCWF2oEp20NCUdVM5ImJJV6AS6BrAc7
	5ybdGDxs5iyNiTyzcf7aPRgUNrKWlfqo=
X-Received: by 2002:a05:6512:ac7:b0:5b1:5829:b8ca with SMTP id
 2adb3069b0e04-5b44e31111fmr672726e87.26.1786534145527; Wed, 12 Aug 2026
 04:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com> <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com>
In-Reply-To: <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 13:28:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
X-Gm-Features: AUfX_mx-NiwaEAY5gqdgMY-_MQY4Ck0H309u0v1skT_yvAzOEmcWtMIEI-f1QEU
Message-ID: <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, "Bryan B. Lima" <bblima@usp.br>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Aug 11, 2026 at 4:48=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> please ignore this PR because there is a missing SoB.
>
> I'll fix it and meanwhile update the linux-next branch so it will fix
> the build issue.

Well, the build issue is still there in my thermal branch though.

I've now remerged my linux-next branch to avoid exposing the thermal
drivers merge I did previously and I'll wait for another PR from you.
Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
thermal PR.

Thanks!
