Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5483F1AB9
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563764; cv=none; b=BIr2cZYOHtHN0Kn5bk5U06658RodvcVzwDCCP1SWQibhDUMUc6grUGMof3ZSJ5W6EUShX7T1ErHgCK/eDq6/Q0d2xsVtS3dsreQ0vihpWTQ11zDxjJOlDikSJChqj2PYdfk1i+ZPpyNSsu/xfkjSHTPA2cEvepfoNNqqXlcqJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563764; c=relaxed/simple;
	bh=SaJrbGxwzSHJgMPk0NkIgSbglqsEiWC7+eg/xh/RPV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpAEkWD/WuavrEry2viOQFgT016p1WNRQ6XHqpZo4vH2emzIcVIv2+53MBQ8a/XreTMddI7HuClNSD30VQvYKygIFd07Mh0s/00TUW9VPbeShbJVxcLJGQw5sRloT9H24DTT7jr/opgBWu62iPCXeDr/zg/ng13/8NriqiRqdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK34VmRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK34VmRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CB61F000E9
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563762;
	bh=cs8Z/DCd0467Xo4N9XjqKyZ3No34Yw905X8ZcaB3L1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DK34VmRZDpWpqJaXHDdIzMd9s32QhvBRxDBTMy9ERx9PTdyuA2dt1TOCirBi+Dvhg
	 A0pTx4acz9QUx3FXKCoaBlA46M0fuJcrsn7dHqMiAI8vaLWCdSX9l/jj66WIf4vu53
	 erY7qAN0/BPEuEXsc4hHNz2+H1790iZUEZXFu5QPwiwXo1zdkJ7nQ6zvUPrZPSh/mX
	 IXMBed0xt6ItS1Hv8VnZMeUHdshqylWbC7IQpZhBxE1aw8TFZX44O9HfB7KnxfwbUb
	 lZygvEwVPTHFApMTI3UkrvQJl3HMRl5aTSZ/WE+Ez4asb+mILKtC84UFmutHDkxlRN
	 tFy6wSWmfhW3g==
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so2523556e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 02:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplymWcghbqjOoyqCU06qlrEZHcDcLv6ranGy1+W229DVHb/4gJXb280Xkdicmq+/dH7nYSKvzvsA==@vger.kernel.org
X-Gm-Message-State: AFuF++kki4M/wA7ltKqFdRjWVyLlNRZvlB/BHMRZGuS/yfpMShyXMEDX
	f9E+IU3/66vdVcgE8v3IosGUDEo/k4bk2ohQw96l8uCKYW0zErUCX7tb7Y9bcePaEOsLPZODMPP
	NjKiwBHAzzM3W/9h32iP97vM8KauGcLY=
X-Received: by 2002:a05:6122:d8f:b0:5c5:d7aa:13ec with SMTP id
 71dfb90a1353d-5c5ff3afbb1mr10254511e0c.1.1787563761384; Mon, 24 Aug 2026
 02:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202608241339.0y44z2vK-lkp@intel.com> <aovYmy6AKkSgM9ve@rli9-mobl>
In-Reply-To: <aovYmy6AKkSgM9ve@rli9-mobl>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 11:28:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrXkXP9mUoucSh3wo2eKXBrXAkuF2nDR3ZMjpMFZVZeg@mail.gmail.com>
X-Gm-Features: AcwNN1XmxVTGjg_uzUCCapOD-By05vZNZCrMq4K10Bz5UPDc9CcHN63AGsjXzbc
Message-ID: <CAJZ5v0jrXkXP9mUoucSh3wo2eKXBrXAkuF2nDR3ZMjpMFZVZeg@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS 361498477a97b6060e2441f64fc29da7b1e07eac
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:37=E2=80=AFAM Philip Li <philip.li@intel.com> wro=
te:
>
> On Mon, Aug 24, 2026 at 01:09:51PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/lin=
ux-pm.git bleeding-edge
> > branch HEAD: 361498477a97b6060e2441f64fc29da7b1e07eac  Merge branch 'ac=
pi-button' into bleeding-edge
> >
> > elapsed time: 2941m
> >
> > configs tested: 101
> > configs skipped: 1
> >
> > The following configs have been built successfully.
> > More configs may be tested in the coming days.
>
> Hi Rafael, sorry that the test coverage is still not full for various arc=
hes,
> we are still working on this to avoid missing important kconfigs.

Thanks for letting me know!

Kind regards,
Rafael
