Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5A32ED39;
	Wed,  1 Apr 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038433; cv=pass; b=G9SL7X+QylCgEz0dDubfSy8GKoEP/8wJbI2x2pwJm5X670j2EF2KZqmgUifuQjxYZo8532o8o5PhSG9k8DVcGYVpA/sqrw6N5jCVOKS7qbZ2gdZ/kEscnoqdu4Cag2lKPDaOOqsjwbK3jKqoN3LIDo60tjtKZWhRW5kQb/b8ug8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038433; c=relaxed/simple;
	bh=nBzN+P5bPERgikCQfqRa9fIvmXnH/oIMkdRwGD7uXiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAnzd//tWsp86Ty+V9ZmckwQ+BtmYAHV5UJlJlW00WO7gYJDiJOmAGMWIJG6rZzA8YRxUnMSTQjeGg9qfgohMUHHCUHIj+uXIGytyDwx4ojiNWcaJVgmKM/oHrBOSzgZbzK0vq4FOR29jl0jHn+sdTDmIiSUuIFEaj7eMEquTrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=kh8MEI3s; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="kh8MEI3s"
ARC-Seal: i=1; a=rsa-sha256; t=1775038416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FUzv/BIFLSZZdy/ldNCRXt5sbTyq5MPbH7WGpNMq8za/JQ2d6CmNXlBzJrx2smJafgLjh5oSBKLetnMYICsxgjqWooebyeTp91OjQ9pxqs2pDcOectJibcKTHjQZi+xhcwviY8kMOjDKxei/9C3NtlyHTPNDePg6tARRj88LT/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775038416; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3XFYgC0eCPOrgEhcNLt+Y88aL+1U9qHgZLEaof/Z8vU=; 
	b=bwQQYPlhOaMzJonW3xx6kwZy55EgXHKtb3nRiyW+RXPGsnQJja7n4ZXtr5NoA9kzrjbtcVtfprjR9Gh4kBY5vH4MwdMOOZz9aBlho//U8mMKcxUkAgSbA9A1ixdeL6Op1xPQYQE0nedy4hdVTVip18xMxSvdE29eMNVXDYUXFVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775038416;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3XFYgC0eCPOrgEhcNLt+Y88aL+1U9qHgZLEaof/Z8vU=;
	b=kh8MEI3stj6iPAgTfzqfMiECGy0QY9SGDrzNFe7+6W2xN0DmC0IZNFoPHG3+PhQR
	vVsKS/skFiVQe7smLmJJ1C0y4C4OZkp+yaD4Te5sbXNCf7MwR0iscTY4Vp/RblOngLD
	TsWGywvtsG2bPn4he/LI2EfDR1oH9zMYs3LXNqhI=
Received: by mx.zohomail.com with SMTPS id 177503841500227.8557919617856;
	Wed, 1 Apr 2026 03:13:35 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,  Len Brown <lenb@kernel.org>,  Mario
 Limonciello <mario.limonciello@amd.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  YoungJun Park <youngjun.park@lge.com>,
  kernel@collabora.com
Subject: Re: [PATCH v2] PM: hibernate: call preallocate_image after freeze
 prepare
In-Reply-To: <CAJZ5v0hjaMFezGQx+pF-TuLBQ-8wNYzd8ZBu+6XCV0=YgEx0Ew@mail.gmail.com>
	(Rafael J. Wysocki's message of "Tue, 31 Mar 2026 14:45:35 +0200")
References: <20260326-hibernation-fixes-v2-1-f6707d82b7b9@collabora.com>
	<CAJZ5v0hjaMFezGQx+pF-TuLBQ-8wNYzd8ZBu+6XCV0=YgEx0Ew@mail.gmail.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Wed, 01 Apr 2026 11:13:32 +0100
Message-ID: <87a4vnhttf.fsf@collabora.com>
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

Thanks for the review.

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Thu, Mar 26, 2026 at 12:37=E2=80=AFPM Matthew Leach
> <matthew.leach@collabora.com> wrote:

[...]

>> @@ -493,9 +465,9 @@ int hibernation_snapshot(int platform_mode)
>>         return error;
>>
>>   Thaw:
>
> swsusp_free() needs to be called here AFAICS or you'll see memory
> allocation failures subsequently in some cases.

We only jump to this label in two places:

 - If dpm_prepare(PMSG_FREEZE) returns an error.
   hibernate_preallocate_memory() hasn't been called yet so there's no
   memory to free.

 - If hibernate_preallocate_memory() returns an error; in that instance
   hibernate_preallocate_memory() calls swsusp_free() to cleanup any
   memory that may have been allocated before returning the error.

AFAICS, I don't think we need an extra call to swsusp_free().  Happy to
change if I'm missing something though.

Regards,
--=20
Matt
