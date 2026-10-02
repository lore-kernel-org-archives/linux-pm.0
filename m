Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9173AE1A9
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973682; cv=none; b=uHPADVLd20Msi/zlYkHy1ie7fBElojm5B+Rq2I9BlVfasePvdhxwnmlf6z8xCW1oMYydfE7pVsmnkO9tytYE3QF+q06FMISgrrBamoBrAPjRg994mr+DV5O4+t0SOYCxHl9KlwPB7H1kUYnf+QJ3c9arXDVMq/z/hFw4aWhr86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973682; c=relaxed/simple;
	bh=lzoWbtWW+VKDmdzsP1mjP0RlphD3zZGcBTaQZ9a5WyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaAUPXzW91m4udHLYLoy/zfhHjhElWC77Qe3/b8oDALorxdZ7VYxLk/1SoNhwbi4UsbhSf5yuJ8D4iWBQN0nDKPN5XTxGewiZF9XXc3leDSK3QfX0FaY/uruvLGMAuoY8ITwiCY+n5/s9D4cLbBvuM1tTMW1kWMPobtl7s8I7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktHf1MOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktHf1MOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823181F000FF
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790973680;
	bh=YPp5XsZUxeTkoIGLl1+hiRHnon+gOyq+V0ABnGAaCNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ktHf1MOTKIfomjtZ6pJH9R2nIqOOScnwwSYukc3PT5q3uDCBvjb810PDmHdPhyzua
	 2gV3qBuVNBFVKLFAetOglZ0WFU6H3QXLEWS7D9smCuibKEDoJArbQ+pfnzgXIbAxp7
	 ckH9PV/D21kIJ5IHymrXn60rrxBXV+ocGQpoRuK7xCdZ142qRQ4YoXdwdwen2GBitp
	 Zs/vjWIjnfHu0Ox2H/aGvbTGrAv0sBjmCpINfrrA93te69WYvc8Sd9rj0C5Al2F7s1
	 966HTa7qjOWFCQ2/iYxzNR3u1BnEZTHL9KjOrndmVuXf5wQz3PCh6rA9uHpowAOz9T
	 ZXQQa04oJWXFQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so3452612a12.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 13:41:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJiqDK1gJ0y5GLYNz4lnASB3y/dzvhu8mtWdnZfqk+U2Evuw+CGQ1hZr1b2yuDSEqyUS6hlby5SQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIT6PfttjF+JqwfQswA45kAbqSkVUPys+93UsPHpMguABXLHnjG
	7Ez1XzPKmyVl2tb0zSZZNM7dOQNjM0oGIqfKQijo18OpRHw0uR9PEMwSd6J9DJtCmhMw/Tk8AhL
	SE+yY5lwaiXGQZXEJAT8mmW80BWh65P0=
X-Received: by 2002:a05:6402:52d2:b0:6aa:ee54:9724 with SMTP id
 4fb4d7f45d1cf-6afad8eed6fmr529119a12.16.1790973679455; Fri, 02 Oct 2026
 13:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
 <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
 <LV3PR11MB87680CA8F9B3172110B7EBD0F5DD2@LV3PR11MB8768.namprd11.prod.outlook.com>
 <8cdc18896a03d13ebea065ab27991a71e460069b.camel@gmail.com> <LV3PR11MB8768D2570DBFB916C237F3BAF5DB2@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB8768D2570DBFB916C237F3BAF5DB2@LV3PR11MB8768.namprd11.prod.outlook.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 2 Oct 2026 16:41:06 -0400
X-Gmail-Original-Message-ID: <CAJvTdKnKN1jbnpPCavu9yLjnRENY+DtLOy8iYJR3z4-4-WQciQ@mail.gmail.com>
X-Gm-Features: AclHuK_AA95BBA2RDaGjGkwZM_vhG-E539BvBQqsjrmP9O3Rss1SGnhc3NyCQrw
Message-ID: <CAJvTdKnKN1jbnpPCavu9yLjnRENY+DtLOy8iYJR3z4-4-WQciQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Fix C6S and C10 latency values for Pantherlake
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kaushlendra,
The intel_idle numbers are measured by Intel's upstream Linux team on
real hardware --
both for max latency and average residency targets.

ACPI _CST numbers are not the result of any known hardware test
and not validated by any known test on any operating system.
Our experience with them is that often they are random,
which is why the native intel_idle driver was created in the first place.

ACPI _CST lacks any concept of the residency target required
by Linux cpuidle.  To fill this void, Linux invents
a residency number in ACPI mode by multiplying the _CST max latency by 3.
ISTR that at one time we multiplied it by 2.  It is not science, it is a ha=
ck.
(We are hoping to see this gap filled in the future by ACPI _LPI, BTW)

And thus the max latency and average residency numbers you see in ACPI
_CST mode are
not something to aspire to.  More often they are something to run away from=
.

> Below is turbostat data from a 10-minute idle run on Pantherlake-L
> with the current values and with the proposed values:
>
>   Metric      Base    with Patch
>   --------  --------  -------
>   C6S%          0.29     0.60
>   C10%         99.34    99.00
>
> C6S usage doubles and package idle improves with the proposed values.
> C10 remains dominant for long idle periods =E2=80=94 no regression.

The rows above are software requested C-states, not the hardware
C-states achieved.
It is actually worse, not better, that C6S is requested more in deep idle,
and it is worse, not better, that C10% is requested less in deep idle.
This can be due to a number of things -- most likely background OS noise.
You'd need to include the Busy% to understand if these columns
are even a valid comparison.

>   Pkg%pc6   87.84    89.48

This is an actual hardware package state, and more is better.
More important, however, is Pkg%PC10.   Achieving PC10
is worth more than a couple of % +/- on Pkg%pc6, and I'm
guessing that on the s

> Would it be possible to re-run the wult/pbe measurements on PTL?

Go ahead and run them and let us know if you see different results on
your system.

thanks,
Len Brown, Intel Open Source Technology Center
