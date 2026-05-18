Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D248033E;
	Mon, 18 May 2026 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111454; cv=pass; b=a2g+nawIFP21vBIENwg5Afe2ANEBmWNfcrtrqngXhCZKRtGYU/0Ay6NmBmM8zB7ORQUxv/EX/sCLu7tbnbWW2X9sfnxGCJJ0ZynwpzU763jtKwBj0tmeR97wxuGKu8tfnh6PTqU83QJapZjXbyoKuFsuKtuvxOhD2ewk2+MjAeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111454; c=relaxed/simple;
	bh=+e6oEH4tyTvnU6zYjbVd7MwiBzA7O8dMtV+mPe60CX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ga09YljTTT10Usk4XmBi1wJDvmS45t2/aNB46D+4jyzIRlA0hB/s9GHsN2tEzpkbzDl6qfssk6AfONMnar4gsNOd74uHoJD4OytPGcNU1tkYJvpeEQe881ArTyo3BSZPmZIQtxXBVsZJ447YQeW1owzCJKvvB9n4ZZEcQ7+dj54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=EVopXY/S; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="EVopXY/S"
ARC-Seal: i=1; a=rsa-sha256; t=1779111435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GYLw9qFnl1E1+BIUAhzm5KFnoggm8eNVenn2CYv6DPFFHFpWLlj/OfOMWNXKAE1j5YZQRm6Mf2iPDUUjOg2w7YCdNR8wjiics5yY1LLsetkLlDLgcaCrCLngNsbXX4zfgQYl6N/J3NKk/yw52XW+Wf4Oj48Iu0hVsvpvAX3Uj5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779111435; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pDmMt0d2TQjR2lzHcVcP/uxbNLOLbCHnHdsM8iEc370=; 
	b=e2ul+0EeThu21NoW3ghCcJyVvdPHEC1wGCNOe3RHOjMqF2XHbaIPdi8a5QlHgDQ1ItolH7f5puyL6938uyUleqvuTdUlKjwD6ikCQKynB1rTweuwIzWxMJAGPyPT5nE8Jz2KDzXgV6umcDU3le9i+KGF6ECecDp7WeWOMNHMtLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779111435;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pDmMt0d2TQjR2lzHcVcP/uxbNLOLbCHnHdsM8iEc370=;
	b=EVopXY/SkUPK9/IL1aZgjUdJUIhoaIiC2qW+82DkLSJDKN8WOBjNHu/1CcSWONTZ
	ichB53ZGXu/+3TQW4WnoTBLPMMv86MkKCl9GT3/yRS5ANJ49R9zUDroUhGj5lnD8A0F
	lR6vxiBoGzsHI3Dvn9ZaxOMQsTESbucI5tc5kaeE=
Received: by mx.zohomail.com with SMTPS id 1779111431150572.9013351128403;
	Mon, 18 May 2026 06:37:11 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,  Len Brown <lenb@kernel.org>,  Mario
 Limonciello <mario.limonciello@amd.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  YoungJun Park <youngjun.park@lge.com>,
  kernel@collabora.com
Subject: Re: [PATCH v3] PM: hibernate: call preallocate_image after freeze
 prepare
In-Reply-To: <87mrz78brw.fsf@collabora.com> (Matthew Leach's message of "Mon,
	13 Apr 2026 10:12:03 +0100")
References: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
	<CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
	<87mrz78brw.fsf@collabora.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 18 May 2026 14:37:08 +0100
Message-ID: <877bp0q1ob.fsf@collabora.com>
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

Matthew Leach <matthew.leach@collabora.com> writes:

> Hi Rafael,
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
>> On Fri, Apr 3, 2026 at 9:36=E2=80=AFAM Matthew Leach
>> <matthew.leach@collabora.com> wrote:
>>>
>
> [...]
>
>> Can you please have a look at
>>
>> https://sashiko.dev/#/patchset/20260403-hibernation-fixes-v3-1-31bc9fa3b=
a2d%40collabora.com
>
> [pasting comment in-line here for comment]
>
>
>> Does this relocation introduce a deadlock during memory reclaim?
>>=20
>> hibernate_preallocate_memory() allocates a large amount of memory and
>> triggers direct reclaim. Direct reclaim needs to write back dirty file
>> pages and swap out anonymous pages.
>>=20
>> Since freeze_kernel_threads() just ran, threads required for I/O
>> completion (like kswapd, jbd2 for Ext4, or WQ_FREEZABLE workqueues) are
>> currently frozen. Will the I/O for page reclaim block indefinitely
>> waiting on these frozen threads?
>
> The existing code already performs a memory reclaim after
> freeze_kernel_threads(). The old shrink_shmem_memory() called
> shrink_all_memory() in the same position, after both
> freeze_kernel_threads() and dpm_prepare(). This isn't a new pattern
> being introduced by this patch.
>
> Nevertheless, the call chain looks like:
>
> shrink_all_memory()
>   -> do_try_to_free_pages()
>     -> shrink_zones()
>       -> shrink_node()
>         -> shrink_folio_list()
>           -> pageout()
>
> pageout() only writes back shmem and anonymous folios to swap; so jdb2
> and other FS threads being frozen isn't a concern. For the swap write
> out, the I/O submission path is via submit_bio() which is also
> synchronous.
>
>> Additionally, because the OOM killer is already disabled by
>> freeze_processes() earlier in the hibernation path, can the reclaim path
>> get stuck permanently without being able to fall back to killing
>> processes?
>
> There's nothing new here regarding the OOM killer. freeze_processes()
> disables it in hibernate() prior to calling hibernation_snapshot().
> Since this patch is entirely contained within hibernation_snapshot()
> that pattern hasn't changed.
>

Quick ping on this. Any throughts on the responses, or anything else
you'd like me to dig into?

Regards,
--=20
Matt
