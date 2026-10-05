Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9C313E2C
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175509; cv=none; b=F0AH0tQZgqN401mDsDvao8oocEN0JENIf/BEpngWKdhR7Ek1afwoCUE4FozNZ2L9A8CfJptRyWnC4gwvNSZeLHga6rZeWPhhpOWCzrbUK/aM7L6PbslyO14f2A1Z/KvBBTB7qVTSZMP6ETIcssWkclvQbMrh+pLdeiWjnCGsLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175509; c=relaxed/simple;
	bh=KCoGmQb88q+Knp6pMuvy5UuU8Flj/RHwhMfh34hgdWw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h4GQjvBCWVd7G5/PG4634BXReEOJ3QWyYaLwTZF4fyW7Wez8aHxlanW7rZZ7fmrqlJqCddDsYcr2/ii5HnLGv3JPHjlkKkW7ZQcWr1SQfckb3Ws080Hod5F2IUr0DsjJEb30JZq64oLGJrlHUFrvAMGK5wtXbcStPYT7cdoQ/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com; spf=pass smtp.mailfrom=fastmailteam.com; dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b=AKj8kKJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaOD1A44; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmailteam.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmailteam.com header.i=@fastmailteam.com header.b="AKj8kKJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaOD1A44"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8606D7A01F4
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 00:45:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 05 Oct 2026 00:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	fastmailteam.com; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1791175506; x=1791261906; bh=qglmIri7xdlBWCLzpwS5X
	EsTcXNBXH4avwhR/k0igSA=; b=AKj8kKJBc4R2ufcbBHn/j4DUz8X9/eUB3BLig
	Qd4nd5BijW8nPH494p9YtnvNR36ZXMHwSp7BdiO7QvMLIWUJ38XnCf0twN39t2OU
	lwkKPS+Wsyc1WBKfv2YgEOI64Vt0KTbQFIOqYD7th4sy57+bKMbygZaDBqmwiMI5
	u+enr93xtZRSIrzNr1+4QsCNd3l1z0hKPEhF9pOmBUOLsiYKzLqyzznpss3n8qV3
	5IqUxWAqGkdtXTvtWDsRnb+UBJhHQ7Xgr0V1G0uHZ/OPttAGrWAgTM4zOA2IgGer
	P2sjIv3oeM+j+itCVcp7IggHcb4+L0uhOUsKy4JzdY/MgGwNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791175506; x=
	1791261906; bh=qglmIri7xdlBWCLzpwS5XEsTcXNBXH4avwhR/k0igSA=; b=k
	aOD1A44Yhn5Z+BoVemFcD9v1qnQEuCFhZlKTboKJ4SasPCWnKcdPHZU78iI9E1Ez
	dRD2+a6t/H5pIjLe8GKSYyTI6KNSd73RMog+NrjlXoGp2bFfnpnUNzpgXhY9KH5h
	0bHGA9ke9dgCHASpYxiIO5VB1nsytWZYuzZy22OYunbC2Pdy7olvB9w7CXWS88se
	tSAS2MmMwhALFLpMgYtcFCgfN4Kkagb+XZnqIdAnJ2XIzgEgiV9xcRRAlYESZi1/
	zA59QHLagWUvXx4Q+PxH5uO65CVdBEeF9b5z2JPe1cvsZMxTGR3sno9oBFDdX8gd
	37My9Tgma3G6Vr+kK/YmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmailteam.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791175506; d=fastmailteam.com;
	mf=PGFuZHJld0BmYXN0bWFpbHRlYW0uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:bFZv5dkBV+bVoNb4dLBYLSoqxB0Zp/o7NZfXMFx7aCJaKis
	gtDuhhHiKga+oG0ZLVY48+e2ew8SwT/p8JFIHBwaFMi5GCd51A5f/55cM5aiDkQf
	iE9cvjYCSd7wHo76Bt8FzJdCulipYYln7o+E4HN1G30dIy7no/h8Lv+Uj73AmVhM
	USoiuQ4iAp8krkHEALxuMIypb6BC5aTh1RYTtnO+gSLqeMddnwY+fP4U+l/JRwXa
	2L+nRvK4Fn4vdJQ8RHjVivmhTefI5F6VYfbf8d2QdhYGLp7+wZPE6bD4BJmlgGFd
	MPfM2dfO2vujDGQ6c8DWZv2dmnpjxrExzkTFfCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UcZLLDJ9VPM0fdfHMdip830I4beEgd5Z372OiUFPA7M=:KCoGmQb88q+Knp6pMuvy5UuU8Flj/RHwhMfh34hgdWw=;
X-ME-Sender: <xms:UivDajljkA17WJbfOkdLGx5ORjZz3LUdxt6lOwJPzbXSW5wUdHU1gQ>
    <xme:UivDahpJukGse_HYofJRx6lfgkOm5rYIDNiFRA1mRT2kJzWVpRdwCjNZG-a8WczYc
    yE95CuPetexipVTPy_trYpXgHWcrNYl9oUbhjHN1kexMmGfeL8>
X-ME-Proxy-Cause: dmFkZTFhD78CMu6lFaDtX4rWOfXbZEYEDYkeVMB2OuZ4D5BxJ6aRcsCqidyphgtTA39+jf
    IfK481qN28UnkSzQ/tkG2UHu8d+7+MFDM+/OcMAFY+auFYPEYI9uEDWMfmpHBffN6JRdtK
    qkyz8r8OeKdIHSZHvoFG7BwjRo95PMIJFv4LXIC86tNWvsXLf3mz+/g81om38rc8bgh0yT
    zaYVLEbKmSg74NfMcqRXopkiZ1xgVoNrX814KCVdin0yqTlfL9BBAUN+SmfoAL4pUK5zTm
    I3pTJqb2O5tpAjqW+xVhMEp+9aHnaSxSXnZPU7eXCcE2AWldU6kojjyAD2onLfznnaBkgz
    HfEick9dyEpUttXLXcxi1qsIms/mh0ZyPoqD3KrjZaOUg4n52fxirz3uDwZO3jPGscPOFI
    2lzPAihQofsw0294YA99Ig62xSQ3jgS18wyqJ2KSaCngI9c6ccxdI0lmc+rUNDRCB/8iBa
    2l4QA5V/3QfjL57yUw7s/rnkDQhcrGX0zpMI+/Y+58xJivNh93+/ktoZZQIlvghYlRuVmb
    OlWlX/tnJkazVxHP3XbKcCYOqQJ+DzCk9L/oj0ANXSfISgNwgkYus15kZMlXhsdglVjHqy
    LA4PbUYg2s4KZ7aseRQAOtdluy2/Xs1AxjlVRBP+hsL5u3zz9LKpk38NH+4A
X-ME-Proxy: <xmx:UivDaslo1KB07tkLjYXza_iq47jUkKBsGjkDvHgkc5oGAbtVTepmvA>
    <xmx:UivDaoYara_uGuyOarUzQCdOoH53DstThDefZQrqS4R1lHd751pLww>
    <xmx:UivDavHntm3uJApYGu73hUGiSaiB7IcdU-JMHfEGl-7IG4Q_bXW4hw>
    <xmx:UivDavZI5AuozkbFCHeUip66yfBxo9jMTluBbrlJzcUoDpB5dpOIPg>
    <xmx:UivDambX9B72rBK20tnRWilXvs8p7YWvbG1KymgsaF9ud6SSgufYxIin>
Feedback-ID: ib8be4bd5:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0BAB0780070; Mon,  5 Oct 2026 00:45:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 15:44:45 +1100
From: "Andrew Pam" <andrew@fastmailteam.com>
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Sebastian Reichel" <sre@kernel.org>, "Benson Leung" <bleung@chromium.org>,
 "Guenter Roeck" <groeck@chromium.org>,
 "Matt DeVillier" <matt.devillier@gmail.com>, chrome-platform@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8fa29694-88cb-41b7-95d6-4d2cf9647d4a@app.fastmail.com>
In-Reply-To: <asMlkcx5P3Qgolgh@google.com>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
 <asMlkcx5P3Qgolgh@google.com>
Subject: Re: [PATCH] power: supply: cros_charge-control: restore EC state on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026, at 15:20, Tzung-Bi Shih wrote:
> On Mon, Oct 05, 2026 at 09:56:06AM +1100, Andrew Pam wrote:
> > Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
> > cros_charge-control: adopt EC charge state on probe") made the driver
> 
> The commit 4fc88ba435da doesn't exist.

Thanks for the review. The patch is against Sebastian's power-supply for-next, where that is Matt's patch you reviewed, applied on 10 September:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=4fc88ba435da

It isn't in mainline or chrome-platform yet, so I have made that explicit in the v2 commit message.

> > initialise its cached state from the EC, but it does so only on probe,
>                               ^^^^
> To be precise, this should be "to".

Reworded in v2 as "made the driver adopt the EC's charge state, but only at probe".

I have also taken your other three suggestions: dev_set_drvdata(), a dev_err() when reprogramming fails, and the nested .driver initialiser. v2 also fixes the resume hook's comment, which still said the driver never reads the state back from the EC. That hasn't been true since 4fc88ba435da. And v2 adds Fixes: and Cc: stable: the driver has had no resume handling since it was added in 6.11, so stable kernels lose the charge limit across hibernation too. v2 follows shortly.

Thanks,
Andrew
