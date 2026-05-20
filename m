Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AD372B4B
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309529; cv=none; b=lqsUKkaXzYV6F3JeYUTalKV4l/M0qsHnXqmg7Ku07a41ljkp6Y+AsBcgjEHf+bt1Zdy9prThtMMkn5dBE65MgFjgFnxR8b1sFtHp/jU+qV1ReTjrnT+PkfKurUYDnReaA/vJAsPD+JVLcRODmULueTBEO+MgdbCEQpdzTNk7Bls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309529; c=relaxed/simple;
	bh=mjc9BKSzcqA4odKa6iBUHm5H25UrsICDs2JtLhu4giU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rst7P/NjwpWTYEMz+NgTLYmQrPoM00GjFOegXfx3LPz9qdzIklrx+HhChLaiRI/M2CFUG9IMFVv48crETuI6iTj8899m1RJhVs+SkBdRpzmB+d6gIC1hBwIawv3+/qN4vsJtrPWnLtrsE8crlD8KbHeuGLO041lQsLy48FXj92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtxShjzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtxShjzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116851F00A3A
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779309528;
	bh=lopEzg6fVxPqxOBEJbFnNrXn2r7gNpTUWBG4jtzlAK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DtxShjzVf0ulEC6SBvnqmmIC9Y/r+q7JHbsN2Vvw4Jdi0tU2mp89dFeDK/Qkt8urR
	 Dn2nz2B7hAqqkMKupMRSEYVJS85vw7OBhByuHRC1C2fWOx0E+bG8Ik9jmaRJnrAoai
	 M5+a2aaXpHfrExxnL3Cw2vPDJWIJJbE9shWiTIdvL656vg3iIQSoXzWuygDlPJjYBL
	 1xESXQkKILpLb6zdwbJasjKINOsqage/pAFWnzCVslIAHywKUqwkpxZpn6uTBlOlez
	 jrkSWkFB+MGja8OCjJxiZAZMSHf5C4hST+tMI1d1qgm9dgMOiHCdwecosbLQF+EjdQ
	 fBAgvWg9moxEQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so9525310e87.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 13:38:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9lRo39XXy7Iljc0asHG1GCmcixDtTzAs4ccv/2qyQDb4RY5Jn3xaFGzTy67UnNH+tndZHL58fk5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpa6xE+cpBb/l89uvLe9tUbU7W295mw2/nnUxJdlwaAmIM3iX
	yiuGhkrBluNoSV6G8M6F8JyyiwKC6Gf+3fdfq4RdeItuIYSOJseRWPFZ1XxuKLsklReswm7+VYa
	VRsE3L/i+zUA6Y0cQVt5cXk+svrIDs0Q=
X-Received: by 2002:a05:6512:448c:b0:5aa:b6b:a3f0 with SMTP id
 2adb3069b0e04-5aa2ba9b499mr8304e87.44.1779309526559; Wed, 20 May 2026
 13:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425072532.358365-1-dedekind1@gmail.com>
In-Reply-To: <20260425072532.358365-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 22:38:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_0pwTWnAVBuaHbWvC1NvOJ0Em3NUrcH0Ce7khm-_pUQ@mail.gmail.com>
X-Gm-Features: AVHnY4LNiUyio5s1SUtShz7O7NCs09Pk1npW598YkuCz3clkUZa0Jqr4nNzYDZg
Message-ID: <CAJZ5v0g_0pwTWnAVBuaHbWvC1NvOJ0Em3NUrcH0Ce7khm-_pUQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] intel_idle: Drop C-states redundant when PC6 is disabled
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 9:25=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> This patch series drops redundant requestable C-states when PC6 is disabl=
ed in
> BIOS. For example, Granite Rapids Xeon has two C6 flavors: C6 and C6P. C6
> allows only core C6 (CC6), while C6P allows both CC6 and package C6 (PC6)=
.
> When PC6 is disabled, C6P becomes identical to C6 and is therefore redund=
ant.
> Refer to patch 3 for the full rationale and details.
>
> Patches 1 and 2 prepare the code for patch 3. They introduce no functiona=
l
> changes, only restructure it to improve readability and maintainability.
>
> For more information about Granite Rapids C6 vs C6P, refer to this articl=
e:
> https://github.com/intel/pepc/blob/main/docs/misc-c6p-c6sp.md
>
> Thanks, Artem.
>
> Artem Bityutskiy (3):
>   intel_idle: Add constants for MSR_PKG_CST_CONFIG_CONTROL
>   intel_idle: Introduce a helper for checking PC6
>   intel_idle: Drop C-states redundant when PC6 is disabled
>
>  drivers/idle/intel_idle.c | 104 +++++++++++++++++++++++++++++---------
>  1 file changed, 81 insertions(+), 23 deletions(-)
>
> --

Whole series applied as 7.2 material, thanks!
