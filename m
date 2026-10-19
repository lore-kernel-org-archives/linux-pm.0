Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6C4A3F1E;
	Mon, 19 Oct 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399922; cv=none; b=aqkH6GrCz4VXzPuWILjgqYpe2zKutPoeeNdKfg8rMrahM0ziwoGWUt0W8JWCJpKa9gx9s5i2qDmflql7ngO8DNl4TVqy7AwpeC9saMPfHwBelbb1YQpgsEtD2XbHXqhIJJGYKMyIu7YO5KQrlu05q9Q4gRvCq9Bo9kcPtT5bukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399922; c=relaxed/simple;
	bh=DA4DlnYJiBv1rP3tuR5PuSaqJFiopm/harezIr7sSwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZR9S738nLSoBdsj1lByJWhwDCmUFwyyC4MfmNnRyEezucRT5ZBhFceBx6HZl5nlI+ZBvRYDY40NhwivPH1Ukm12hVw4sYGm6EhjFUKtwnO7e8HtVVtSXRBxfX3xh9IE01YblnUEd762q3D0FHwQ4L49Ugfkmv4T662Ddl9Gw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=A8CAOMqU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A8CAOMqU"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j7Tn2150rzMlLL;
	Mon, 19 Oct 2026 10:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792399910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA4DlnYJiBv1rP3tuR5PuSaqJFiopm/harezIr7sSwY=;
	b=A8CAOMqUteu36VGV4F0ICc2ZqS6ScxITNc+ytRBRlcMMes8EiAB5BX8YIrqBH2N+M0j17R
	4EnHlQDUdfSvK7QK44nAqGMEee6vGM15YWrYaTbwJIlTjYPlQGlbbdDPQj+9+IeRmkaIzR
	AGCUjXeyF+6y6ZYMu8u3aSz/7l06mXZDrxP9lo5gCFkyea5aYYOZ4qBi2VOa76Mu3nds1P
	LN4U0GspJjj/k+JlLL1X73IeBSC3uba8mGWPjbE8G8gaYPmeTV4p3Y0v5m5H9j/Tu0bUqT
	Eve1UYNeMym1XB5vF1nPi/U5geC35mrfvWQaOj8c6sq1F4ZcmdskVpdPBNcsCw==
Message-ID: <c635054081da35e61ccc25cf356f6356ca8580ba.camel@mailbox.org>
Subject: Re: [PATCH] cpufreq: longrun: fix typo in kernel-doc
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki"
	 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 10:51:46 +0200
In-Reply-To: <9c312de6-7c73-465f-93da-d7a75cf3be8c@oss.qualcomm.com>
References: <20261017071434.1250140-2-manuelebnerli@mailbox.org>
	 <9c312de6-7c73-465f-93da-d7a75cf3be8c@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: jrn8qitrc5ruhwnznws3i467q8wkknbe
X-MBO-RS-ID: cde46030cab00897271

On Mon, 2026-10-19 at 11:37 +0800, Zhongqiu Han wrote:
> Hi Manuel,
>=20
> Thanks for the patch.
>=20
> On 10/17/2026 3:14 PM, Manuel Ebner wrote:
> > Fix typo to fix:
> >=20
> > =C2=A0=C2=A0 $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
> > =C2=A0=C2=A0 Warning: drivers/cpufreq/longrun.c:126 expecting prototype=
 for longrun_verify_poliy(). Prototype was for longrun_verify_policy() inst=
ead
>=20
> ./scripts/checkpatch.pl reports a warning which should be acceptable to
> keep unwrapped as it is tool output.
>=20
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
> description?)
> #9:
> =C2=A0=C2=A0 Warning: drivers/cpufreq/longrun.c:126 expecting prototype f=
or=20
> longrun_verify_poliy(). Prototype was for longrun_verify_policy() instead
>=20
> total: 0 errors, 1 warnings, 8 lines checked
>=20
>=20
>=20
> Also, while reproducing this issue, I noticed another problem,
>=20
> ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
> Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**',=20
> but isn't a kernel-doc comment. Refer to=20
> Documentation/doc-guide/kernel-doc.rst
> =C2=A0 * longrun_{low,high}_freq is needed for the conversion of cpufreq =
kHz
>=20
> It should use /* instead of /** and may be worth a separate patch.=C2=A0

Will do.

> But
> since this patch is only intended to fix the typo, the patch itself
> looks fine to me.
>=20
> >=20
> > Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>=20
> Small nit: please consider to add the Fixes tag:
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Well, thats the init commit, should it still be added in=20
future patches?
Can pre-git history be referenced?

>=20
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>=20

Thanks=20
 Manuel

> ...
