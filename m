Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA353A6F02;
	Mon, 13 Apr 2026 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071563; cv=pass; b=IHodL4DMug1p5JMZ6JZ9+KZTwXvG3q1UDU4TaHviEGz/3TBZYq7/491NzaAU3GU9fq7f7sQSwb6AmT/DMVWgfoh4gvSl97YuJbgjarVqjMJVC2lHOrx9inXfG5D/FXZjTGjrQN8XHewp/CZNNL/HGqDgA13Jvv19fT3Bnf/ohxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071563; c=relaxed/simple;
	bh=HszuPrz+WeXfvDR4xqSnOIqRLeJppP5PStVadh9O4A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wtu5Nv+NAZ509I+mDahZZ5zgExj+U8e1OE9Bze7eJ5dVRBeNYlB3Uz+iILcqwXKAAkOD5VnX8sPxcfrRYEmiKyFswhSS67lKLruwANkqrgWBWLZSot7TIu+/yjXb5DwlAskFouSTDbaOf635xjMwaHZEW2p+czjE7FpbvQ6keVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=XNDF3aMC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="XNDF3aMC"
ARC-Seal: i=1; a=rsa-sha256; t=1776071528; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nbp2nfsohFyTSXJKxWCJ0e7EvL00xn8DgaB+MaDVpOD1LaY8Q6ty6iL1svm+HBz8lyq08h+i8BVEk6L5z2CTD8YZIyCUb9T+qgm6dmUB56UjK1VpR2ixFfSHh0At+dD6PNwyC4Mmr4wtQ4VLf8+yqdjpwZo0yM/UoaD/Y5yXMAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776071528; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TB5t6rpdmY0Qok4AOdsXH/kuymrQUdAE7c76l8dq+kE=; 
	b=Qf3iJi3gfhrgIMw+pyLwf3jyN9Kx7/wP9NnE1xJyugYdluTgiWSoS0ul8CJOLrGRd1dJnqCXH8HjT9/HdhVTDilNP/E0k5J0oPZ8RrV9DG4nfXf4PfzFx0EinzLoZyZD7D9DWBrGPA1cdtbnOgrdZhIvtKn9Tt/qkBFdanja5i4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776071528;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TB5t6rpdmY0Qok4AOdsXH/kuymrQUdAE7c76l8dq+kE=;
	b=XNDF3aMCDt5rP0iNMuPwC0TXDTV58eI07dwmiaJeca8tPpDX6dTEe4n8FCPOWl5v
	tW2vIYwAZ6u1kXTqGPve6sFJtmU3iMPUWTsSJuLvENOH7VmnbbxhXjCIaO/r7LylfRQ
	X5kidQHG1TluauzfvArgOz6V1PH9M44LG5zvYvLU=
Received: by mx.zohomail.com with SMTPS id 1776071526706476.8249017679823;
	Mon, 13 Apr 2026 02:12:06 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,  Len Brown <lenb@kernel.org>,  Mario
 Limonciello <mario.limonciello@amd.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  YoungJun Park <youngjun.park@lge.com>,
  kernel@collabora.com
Subject: Re: [PATCH v3] PM: hibernate: call preallocate_image after freeze
 prepare
In-Reply-To: <CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
	(Rafael J. Wysocki's message of "Mon, 6 Apr 2026 17:11:41 +0200")
References: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
	<CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
User-Agent: mu4e 1.14.0; emacs 30.2
Date: Mon, 13 Apr 2026 10:12:03 +0100
Message-ID: <87mrz78brw.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Rafael,

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Fri, Apr 3, 2026 at 9:36=E2=80=AFAM Matthew Leach
> <matthew.leach@collabora.com> wrote:
>>

[...]

> Can you please have a look at
>
> https://sashiko.dev/#/patchset/20260403-hibernation-fixes-v3-1-31bc9fa3ba=
2d%40collabora.com

[pasting comment in-line here for comment]

> Does this relocation introduce a deadlock during memory reclaim?
>=20
> hibernate_preallocate_memory() allocates a large amount of memory and
> triggers direct reclaim. Direct reclaim needs to write back dirty file
> pages and swap out anonymous pages.
>=20
> Since freeze_kernel_threads() just ran, threads required for I/O
> completion (like kswapd, jbd2 for Ext4, or WQ_FREEZABLE workqueues) are
> currently frozen. Will the I/O for page reclaim block indefinitely
> waiting on these frozen threads?

The existing code already performs a memory reclaim after
freeze_kernel_threads(). The old shrink_shmem_memory() called
shrink_all_memory() in the same position, after both
freeze_kernel_threads() and dpm_prepare(). This isn't a new pattern
being introduced by this patch.

Nevertheless, the call chain looks like:

shrink_all_memory()
  -> do_try_to_free_pages()
    -> shrink_zones()
      -> shrink_node()
        -> shrink_folio_list()
          -> pageout()

pageout() only writes back shmem and anonymous folios to swap; so jdb2
and other FS threads being frozen isn't a concern. For the swap write
out, the I/O submission path is via submit_bio() which is also
synchronous.

> Additionally, because the OOM killer is already disabled by
> freeze_processes() earlier in the hibernation path, can the reclaim path
> get stuck permanently without being able to fall back to killing
> processes?

There's nothing new here regarding the OOM killer. freeze_processes()
disables it in hibernate() prior to calling hibernation_snapshot().
Since this patch is entirely contained within hibernation_snapshot()
that pattern hasn't changed.

Regards,
--=20
Matt
