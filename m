Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78647F2C8;
	Fri,  4 Sep 2026 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521749; cv=none; b=QK4q/fBLRVbBIMsMLtfLhUuVb9+Nij5TPmsTb9MqMNK6hAFMpH/q9bwI93zvs55gw2SkgDUIwRu7oHISdxI71IMfFDKafTaLsrVM0LV5OlBb7pHyiO7PxJwIJb7TQojsG3sg/ejFy9MFafnkdyrE1cvtQP0ZaWg21wqNSzN1ptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521749; c=relaxed/simple;
	bh=3Apwi0JO/T2M8I3B+7lZezuRmBHeQ3e3soUlh1srZ0Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pw76bZsKm3g2Y68I/bspoc0ecQXlDy/GQBhYZZaEad/eO/11dvGMNId7UtxLzSKp+9Zy4BcqXAKN2RZI9cZbeuOfbmHIiag1TowcH/RgqntkZyk71nM+87KogltNtzgB7QJUW8Ybc1AosTXLqSY59Uaen/c4kCnTFB2n6pk7ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GPA4NUE1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GPA4NUE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788521744; x=1789126544; i=markus.elfring@web.de;
	bh=WRmkMe8rBm8qpMLsLLbbDwWqoo2tbt1tI8LPEXvGDMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GPA4NUE1Lch0uLsnfX+OEvTtRBfJRuxVd+OrtFyliqVjA3XMTml8g04J1UEhByll
	 gqjiH7pwhsbvFEFSA121D83dScRl6obN6wOUOj55zxFAuTeR8BxCOdEHOIfWEXHHI
	 J7wqhAbYbQiCVVaPN+TNWv+zBIFdthDAr3XgToKO/NQ6540o/ElWuLy4TuB+gqFIa
	 xQYllKWwJdpHgAnWu2LRunnKICnWdzb3+he9rIncjAqXd6Y9E3tBL8pv45a6ROHRP
	 yqckbAvCkqKNVqFSB9/e2vvofUBL/oSJIqhmRHhiwm1ceoxTh4Arp2CHEbo4gKB9n
	 YGOQOESprp1KoEZimQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1x6YbJ2C4R-008GU9; Fri, 04
 Sep 2026 13:30:10 +0200
Message-ID: <af60808b-d178-4bc1-a9f2-61ce3ed3e43a@web.de>
Date: Fri, 4 Sep 2026 13:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <0f12d097f5874242b8d3cc98b441c4fefd626aee.1788369428.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] thermal: intel: Slighly simplify duration_set()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0f12d097f5874242b8d3cc98b441c4fefd626aee.1788369428.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FqirDlLL19+7nqpEfPvVVgoztC0LbevoyJ60cmuOj9xUc3AWj2b
 6kH4Mflct2Gy0Mjb/b9A3ZIekJxviKelkaA8faSEhjhDTirNrDxW3xHXcx/BOAdu1818EcF
 ROxNKtmhLfik4YScltxiDWWXSyLo8u8YeFLJnEi6FJ6pZnc8eZnr9ejk4ccJSsI4NzHTNnl
 agA7g0io2H6OFgPaKsYLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fIYadMSdHaE=;hbT0ynGW6dA+kxdLh0my+PQ9v01
 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

=E2=80=A6
> While at it, also remove an un-needed initialization of 'ret'.
                              unneeded?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.3-rc1#n111


> ---
> Based on my testing, gcc is not smart enough to get rid of the redundnat
=E2=80=A6
                                                                 redundant=
?

How do you think about to avoid another typo in the summary phrase?


> ---
>  drivers/thermal/intel/intel_powerclamp.c | 4 ++--


Regards,
Markus
