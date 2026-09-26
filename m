Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A61227EA7;
	Sat, 26 Sep 2026 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400376; cv=none; b=BZ06ZTkfOmy1FrFjVcqCfAhlrCjJAaYfiGjkemYmKsH9W8YWANQF/WBJ75ol2xJ0q/aoKigpQjVSHlIVYRYbaNU0iI/MxFBnRgAAClHJO8hmHGQrvMM+y5nwNaH4zl/qFfnD09576f5kRJCnKvQtGpD7FmeT4jIlKnnIFM6oEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400376; c=relaxed/simple;
	bh=gIHPd9h5Vbnm5RLG7zQJ+SAj3Kkp0Sc1Q/tNWUYimD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8SyUsftaYfZL4AgpvjuHwBVem9DcmQZ8zfuGOqxUHEcYhwN+IxGn7I98Yxak3DtaLgusuMwQv2dIgoLLF32ILltApJrPPUCkltthbRvSYTLzrTmu/zYZHKkduwRu7cBgiLAtwAGLIuKSpovEb2TriRtTkuOnJINwZN3X71eoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDhp/qQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDhp/qQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9971F000FF;
	Sat, 26 Sep 2026 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790400374;
	bh=hDa9npNfJuDxNd7gtgXXdOumIY/2QpBZnEXtltyonF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDhp/qQtHrKjJrdjeYqTs/N/AKf61PUhzJtReOlXhhjr97YI2ZUyncE4iDULD81Ag
	 kpJZe2/HAfOxFGWjpINVGb5RFfl4TVa0mKcSWhNv2rzZsOYMGqTpNZ3wr+Bkn260ZT
	 qxGQ3t4TW93zZO3tLe9dJuIN94uEM8K5ZBKbT++8J5koFcq7QVPcSxeuWAe3NQq5mM
	 8LLhLxCgqErIsNGWPSuGIfQMTY4UuaP/9TImNnNPmNVGzU7o9qxZaq5hcvEXRLY8Gr
	 0m76P1dmTlUtCBs+nVONlepNlMQ1nv80GBfJnymEh46LnPMpSCXXGpTwnpRCp5rhHt
	 VCWChmEV6dZVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/hibernate: Ignore page-zero RAM in E820 checksum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthias Goergens" <matthias.goergens@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: scardracs@disroot.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@kernel.org, dyoung@redhat.com, io@r-ricci.it, x86@kernel.org, linux-pm@vger.kernel.org, yu.c.chen@intel.com, kexec@lists.infradead.org, baoquan.he@linux.dev, hpa@zytor.com, moravec@ukf.sk, jlee@suse.com, dave.hansen@linux.intel.com, bp@alien8.de, pavel@kernel.org
In-Reply-To: <20260926052117.3613637-1-matthias.goergens@gmail.com>
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
 <20260926052117.3613637-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:26:13 +0000
Message-Id: <20260926052613.CD9971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

> The legacy kexec_load path reconstructs the E820 map exported through
> sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
> transition, so a kernel entered through kexec_load can see conventional
> RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
> range starting at zero.
>=20
> The hibernation E820 checksum compares those byte representations and
> rejects the image, even though the maps agree from page one onwards.
> A QEMU guest showed this transition:
>=20
>   firmware:     RAM [0-0x9fbff]
>   kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
>   firmware:     RAM [0-0x9fbff]
>=20
> The checksum covers e820_table_firmware, which trim_bios_range() leaves
> [ ... ]
> kernel carries on.
>=20
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y map by md5 digest")
> Reported-by: Roberto Ricci <io@r-ricci.it>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926052117.3613=
637-1-matthias.goergens@gmail.com?part=3D1

