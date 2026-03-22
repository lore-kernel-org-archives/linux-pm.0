Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1717A2FC;
	Sun, 22 Mar 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774172060; cv=none; b=R5C0KjDwvO84VYiXsMK9nbbbCpWsFw6yKtxTVh+Demr8bPqoBBM5n9jToHVO5f1U3OYIqG7BeZcudEDtNnOtnt/2rJNZ04pazTvWq/AzV4AC79LvEBKsQUuCH2tsyFVmMlozV103iXqccMSza8n76N4fQtBXdSoOXLbSTKQRA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774172060; c=relaxed/simple;
	bh=XmVY+rpxZXNIVhRHlLA6IEXDp424116VhrvgeA7jS78=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=U6GxUtkjY21vlalMSFBpqf6cDFeYgwqK8YZC901waAHtqjlFYNc4yNz/Y52Ee7g7+jrUzBPYoKhOWhjqAK6xbhqj9sGoSSsoSdcDjg9nNSL5k25KUJwJb4MXsWw5I+4mTbIPFthvUosalPX6Faxm+mq2Wm41/yVo7ojp1SGx6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VUtWYhYX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VUtWYhYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774172049; x=1774776849; i=markus.elfring@web.de;
	bh=O5w2MXvzSEgNJkLmCTNFabZqnFDLSSTz86WdrzJp8HY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VUtWYhYXhUbpdl8iNnFODrkeO6I4d853UfeUPgEraobNgGIr4jYLVySJgUCVOUwT
	 2P2a2o5T5P3n8CbwdhrnSz7lDCDj/3KIJZ8+1OT8rAZMzO/wv/QO8UMgCmod0zS6M
	 KfBKX0ekZ/3wpbAekFEWn2t8yPJlTS2YJfawzBdVl7xZVghGEFcjiaBa8MCSdEeLS
	 QMBXM1xmDw+7OZ5wvwHZJM9Ahjou8vtDNGeglylcisEpxTKCMC+NbKowjOuhe+7m6
	 3ECRnziq9qeyuHxyMOgTxOyC9r9qp/gu85GYGpZibNWmQ6ihcSCBRUD5cnLnG801P
	 tPp0Bna1uq7v2WVrBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1vp3qh3cyl-0016Nu; Sun, 22
 Mar 2026 10:34:08 +0100
Message-ID: <68f0613c-321a-45cd-abf7-76e59159d9c5@web.de>
Date: Sun, 22 Mar 2026 10:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gui-Dong Han <hanguidong02@gmail.com>, linux-pm@vger.kernel.org,
 Georgi Djakov <djakov@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Wang Jiayue <akaieurus@gmail.com>,
 Yao Zi <me@ziyao.cc>
References: <20260318024815.7655-1-hanguidong02@gmail.com>
Subject: Re: [PATCH] interconnect: debugfs: fix devm_kstrdup and kfree
 mismatch
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260318024815.7655-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dKIqzHTSkvGCT0ns6nuZUAeCN6k/p5fReQUk3IYI3kwdq3LJWEk
 3HxPR2J94qJJFv7bSpeNjDHdbQ8TUkDWOqHcql6KxuPsbDNLwsGgwZQT6hO/qD+crzNozik
 g0LlYhdnkML5L1XqaLiSwk2bhQjBpPWG2LCrpxTP482ZMEtx8MnHtOVmRYEZW790ChGHo+h
 AcwMjJQkmrsAGNVQdtMTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aWSsVJ/pi+k=;C7/nAL4AdCQemNKMEiAhSPi683e
 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
 hUyLPYVWX0p2NMTZbHcq

> debugfs_write_file_str() uses standard kfree() to release old strings.

Why would such information matter here?


> Initializing src_node and dst_node with devm_kstrdup() creates a memory
> management mismatch. If a user writes to these debugfs nodes, the
> devm-allocated memory is freed via kfree(), leaving a dangling pointer
> in the device resource list that can lead to a double free.

Would an other description approach be clearer for involved dependencies?


> Fix this by using standard kstrdup() instead.

Interesting =E2=80=A6

https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/interconnect/debu=
gfs-client.c#L139-L169


>                                               Since the interconnect
> subsystem is strictly built-in and cannot be unloaded as a module, there
> is no exit path requiring manual cleanup of these strings.

Should string lifetimes be reconsidered for the mentioned function impleme=
ntation?


>                                                            The error
> handling path is also simplified by taking advantage of the fact that
> kfree(NULL) is a safe no-op.

I tend to interpret source code simplifications in other directions.


See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.0-rc4#n34

Regards,
Markus
