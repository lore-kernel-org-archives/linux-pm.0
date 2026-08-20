Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53633F6C3B;
	Thu, 20 Aug 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223322; cv=none; b=Eb4an8ux/jnF+xZj/JGdKkYc51VmDr0W8k5lF7AUFYDmRV48pVlVwyT3SZTkCbWQ6ecmO29OPWsEHRVuCISFbQ5ECXgpkIVJEHfdm2B+UeXVx7W2UmhV3Z5l6YG5f5UOW86rqM1bijeTJwzplMoEcOMmickk8OEmhJg3SgSdurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223322; c=relaxed/simple;
	bh=/djQJ1RRVbyrMfFajMU/PdnPIbQ2x/Yq2aRokGFcZHE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ijfCoGNgnJFifcN36GjkryOiA/vo7LPDW9DWwP2lABXP2IFsldT/Vt4CIxe6AVBAkuHLgK001aGDvDaEHkBu2m90bz6al0+EkiwrwtqXlvoNxFnaJWoH4T6vypwOx0sg+GliD9iJIJeNjAxSaCYkSKm6yqgjM4y1Z6zLmiy0JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X/SEpk2Y; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X/SEpk2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787223306; x=1787828106; i=markus.elfring@web.de;
	bh=/djQJ1RRVbyrMfFajMU/PdnPIbQ2x/Yq2aRokGFcZHE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X/SEpk2Y31nHhtfwl968RcIA06hnPDEUKNs6CYdwboK4+YwCcjwg3gztQL5YjZ7I
	 DCMZ9OxKmQlUVs4TSIyCPpznZV1H7k0wmAA4C3ggPnUr7becS8qwyJX0kntAd8Kjr
	 e2BDice3j3zv5OnXzbAJ+IdcXY3jCM47j7JM+VV6XoS3tuF+HIuNHnmY15wuBfTeO
	 NdD7Z1nGV+xyP5OsfqgQtAEnYDIUxdWTolxNrfEMQ8g6cRK+9k5vsQZVrbliuVSNV
	 R1sw69tut1xRsouxLL92oxfoe23japSqHNIv5707vlbTq/r70DDj6fMEiE4o7DBed
	 KCEFw/duP2zWeokdnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1wYhEY2JMO-00hAo7; Thu, 20
 Aug 2026 12:55:06 +0200
Message-ID: <53fb9fa9-9663-425a-93fb-7771cb1e8905@web.de>
Date: Thu, 20 Aug 2026 12:55:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Alim Akhtar <alim.akhtar@samsung.com>
References: <tencent_405FF24AB67AAAA26BC85ADD092710C0BB07@qq.com>
Subject: Re: [PATCH] memory: exynos5422-dmc: handle clock enable failures
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_405FF24AB67AAAA26BC85ADD092710C0BB07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wzi/Ywv0RunCgHfky2+t9AirgzefZDuQZ8vu9krudYnB78sFzvE
 p2sw9UN7K9NBbgSbGV8QGheOq7FNTZkcKjCx6kzJuF5dbGBy+F6Rk+eVZkgGAeZXXFZayjg
 5huV5n381CPdU/IZ+ANC384nKOJp6+vfNBOwmwMMSMX6TQBQKyQTdfvwdB39noblfCZFlzz
 f+r2yV1F8hX32O2EZ+HFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cN31PgPvfqg=;ae8ZNHaR0XpTIHXmLmZIMkbK/CU
 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
 =

> Check clock-enable failures during probe.
>=20
> If a later clock cannot be enabled, unwind clocks already enabled on
> that path before returning the error.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n792

Regards,
Markus
