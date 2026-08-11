Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86842A792
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469140; cv=none; b=jV08rBuOOsJojA6aJQhOUPhy9Alwadxy71rtjjdTJlMpMRCpL9a3MUt9Dnz1XPJUnJaM7CDMDvMT42efut0QtHtgTT7IQHIP9io2N8hqLtRsoBcBX+wacw+J7fXLE/GBi1m2w6vySIy6ejq1c8jdQFpJ7FR5Id6EmsbFOXKX2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469140; c=relaxed/simple;
	bh=j9xuvDkjhkF7rs02mEs/P4EHZ8kZ6D31eE96ugnCGo8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rV7HIs16ig9xAjl+OBsg7z8ayL//dxFf5V6ZwHAQoTRfxt/wOZxE65xx3069O8CESYncIuscIQ9g6zTH52nu2C7RXdao6ze1ZYJDHJ33xdxhkMJtSDPv6js8eQPlyjg8StW2FJQSk4MA1jQ8PLotQnhRGs5zt8ttfloVNBNyoEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebPryeX3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebPryeX3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so6697f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469137; x=1787073937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T42Ar1lFV3Ht11LsBsPmcUqkhywRfx/FzW0kv5ycwfw=;
        b=ebPryeX3wNj3WKyAybwCiMmZetdFN2Zwb6rtdOSLMHMMdbIRV65TUNPA7S6JTpA80A
         v3l8GbmyuB65MniK8OR/e6tO/RyyiKF6TtdVeNqVE4408dGsWy+XRvDzGDjGWLdfna6h
         7OK2Nr9xTSwBi0CXaZtIWHNa3ofvtoyNVtPi2nQ8QU+Hk59Fi4ggsqFwAf0ZAi4Bmfie
         uV0d/5cDmSpt5JerjU40V5JKPjZwrVEFjaLZVZBq+aESzztaG8PSxK5ChtmDS8BmWLq5
         HzVjYmHiFkNDZhGYy1PmSh7jcSLbvKtE+SsfKcInd5BNX4bWYReW9OSeUW99/GUO05tY
         1eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469137; x=1787073937;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T42Ar1lFV3Ht11LsBsPmcUqkhywRfx/FzW0kv5ycwfw=;
        b=hVYniKweyd9M36uVM+QzF6q44FqcC0CwOUxWgLDk8rge96uBKkztV/U4+9uXXdo7io
         i99r/29+hi1dQoWanzFzCpwndh+b9AADKP19ChAa2H67q2DJntl64SaXeHH9EHD7CZu0
         JRuMcMyIkq4cLLOkU2uPlJjFPAb7p9re2lUhdoop3giEvpbmtx3lzYfoAxCOPIyLYlaQ
         WQHaDy+5lXa4gAmwquNharXz2NIz63YMZ3lIxJQBUIdKN0EhkFQMwa9bzWKPe5DjQ/O+
         Lh0NmAKn/9ncR7u9xWbb30Ii3eaA5SclWoGpixolAfr2gF+ZXSoHY7roNyxa3JFM/Pip
         +PZA==
X-Gm-Message-State: AOJu0Yx8Q10bXHJjYDa4Ryurd4HvK+Ip06n1xZpAwsI0e/Cd3+tBQ2Z/
	BdiT1tCRHlSMuoskk3DiAFgKOmWtnk9suU6wQWZJsu5eIa5pC+1T2r51
X-Gm-Gg: AR+sD13nX1hCxcLjFQwA8L9rRZ8smG3L5tfEGt5GMdmuXuIO2DR2hbi/g5BOPBXLYzi
	u2MtTCjgNeuHRNLPgfY7PUV8EKW0DPt5a7qmibrMpjGD0hrzH6uNySElcl3jhXcQ+GNbTxxhQVA
	U03RkHMNLaYzgjjzVQ0vp+xPsC5VCVobmB8ryGaodBE7VGnZDPwpj4LrzPHt+WZUjFdwXJHiEla
	YWOJKg7qcb7L3pLF+nXghq7fh7qxJiPqNfjPWMElm5ALyp6zWlWBSINHunl1EVPGHAqwTZSHnMb
	vj9EeA1bUZJQJFtlfbU630NVx1QUXNI+SIE3gz5ht4I/6UdLKl3EWasymngKc0V3rzy46+Sp16R
	yIDF0FcEPdScneK5pjED29sA3QxwaCJ+mqWkJa77AUVzJGbM8Z2SXS7kzUFGGTIRIWsbqfPLW3k
	K1hamGyEbwPtVuHywC0nXIXMrFqo7aSZz3OUOgF+QjDQwjHqPzA4ph47obHaBR+g==
X-Received: by 2002:adf:e012:0:10b0:47f:6981:a043 with SMTP id ffacd0b85a97d-4814add668fmr6557849f8f.26.1786469137057;
        Tue, 11 Aug 2026 10:25:37 -0700 (PDT)
Received: from [10.245.245.29] ([134.191.227.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72ce1esm6565288f8f.34.2026.08.11.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:25:36 -0700 (PDT)
Message-ID: <8cdc18896a03d13ebea065ab27991a71e460069b.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, "rafael@kernel.org"
	 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Tue, 11 Aug 2026 20:25:34 +0300
In-Reply-To: <LV3PR11MB87680CA8F9B3172110B7EBD0F5DD2@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
	 <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
	 <LV3PR11MB87680CA8F9B3172110B7EBD0F5DD2@LV3PR11MB8768.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 10:36 +0000, Kumar, Kaushlendra wrote:
> On Tue, 2026-08-11 at 13:47 +0530, <reviewer> wrote:
> > The current values are based on what I measured using wult/pbe tool.
> >=20
> > I think it will be better to explain the problem and how this patch
> > fixes it, give some details about workload. And ideally, also provided
> > turbostat output when it runs in parallel with the workload before and
> > after this patch.
>=20
> Thank you for the feedback.
>=20
> Looking at other platforms in intel_idle, C-state latency values are
> generally sourced from BIOS ACPI _CST characterization data. For
> example, MTL-L C6 (exit_latency=3D140, target_residency=3D420) and ADL-L
> C6 (exit_latency=3D170, target_residency=3D500) match their respective
> ACPI _CST tables.

So there are platforms that have intel_idle table and that do not have
it.

> For PTL, I observed a discrepancy. The ACPI _CST on a Pantherlake-L
> device  reports:
>=20
>   C6S: latency=3D127us, residency=3D381us
>   C10: latency=3D1048us, residency=3D3144us

Discrepancy -> difference.

> Could you clarify which reference was used for other platforms =E2=80=94 =
ACPI
> _CST or wult =E2=80=94 so we can apply a consistent methodology for PTL?

Platforms that do not have intel_idle custom table, use latency from
ACPI _CST table. It only provides latency. Target residency is
calculated as 3x latency.

I do not know about _CST numbers. I only know that in many cases they
are not what I can observe using wult tool.

Panther Lake is the only client platform that I measured with the tools
I developed, and submitted the numbers based on wult and pbe data that
I got.

Artem.
