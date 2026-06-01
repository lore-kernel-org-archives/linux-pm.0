Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AC364053;
	Mon,  1 Jun 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348516; cv=pass; b=SIaMBjcsQYhUomj9Wou0UVcxYE3GaMmpFrNJYgTdFKSvkeHpBu+4UnGX/TI14buTLBt/qpX4mJdkvkHyqki+6g8e92OZ+c5V0HxsHK+nC7z57EB/6b74nK8GvLZ6Addp+z+h/SeJBXXTARAa7FCG1qXb52iPE49AxP1yhsVCVhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348516; c=relaxed/simple;
	bh=1YmWwssirbv9+peH+97cCiUxcb3gbZhvjvTlKrrkMHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFGU+dJ6Lr2ZpzKo6Fw+z38GKNtLFU2vZ5rxWscuGnTgCobD4gKKnkBTRynIEo/+0Rilw5427Jx9ayumJE6G6V05mHUxtt2KwB6el4OKmcvSz5yMcUVcy03mLmOWU1lbnBUwwt3gd4VCnt6Ok4jNVVO/8Z+CWTXOeoJOfKNvBVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=L7mRp1FH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="L7mRp1FH"
ARC-Seal: i=1; a=rsa-sha256; t=1780348505; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m3DfVrcaBofCJ3tIVniUoAsY9bRyA9sqv6s5PXQ2+EElXgUXeid8bJcotyPgpfpD2WInnIGIiVO07kFxnD73djMgmscLTtlKDonleVeoUDwvszkENXniPzVwW7aekP3kRSdZnM3qGpVP6WTd/aGlzUWnC/bPsNL0UEjRB0Tjn0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780348505; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1YmWwssirbv9+peH+97cCiUxcb3gbZhvjvTlKrrkMHU=; 
	b=VmviOeR8DMghDfXxd+qop3uw/0a71iyaWC1zvRulj/ZQ1raRL/8eiwelEjT+PYYWrjO8gHT9b6KyWZcyoW6B2wd8hk270CwDysBwtHhUS+FeAkdy5xrDcd/69hQAqxBTsZnaYAbMVJc6pyj75H1n6YjE6H0wRjry3ZLZGGnD/Uw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780348505;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=1YmWwssirbv9+peH+97cCiUxcb3gbZhvjvTlKrrkMHU=;
	b=L7mRp1FHs2a56cJmNUWqOP3wDSzrVLZjSazSALCNp3qXkik1fBkY/MbHsFv3GWie
	6vF/LixexP2c6G9NYkizW2Ai3LsgOnTEgkryCk0ehlhn9RCvSlVtJRO4rROJdk+97/z
	9CX/wpA+h3pnGYIUIW7PovO6kAF2xjVM5H9SPNGQ=
Received: by mx.zohomail.com with SMTPS id 1780348503708253.203249140945;
	Mon, 1 Jun 2026 14:15:03 -0700 (PDT)
Message-ID: <cf747f90a7ba3a26dd84e572ec1152cae48d9b4b.camel@collabora.com>
Subject: Re: [PATCH 1/3] PM: hibernate: Print speed statistics of
 copy_data_pages()
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Brian
 Geffon	 <bgeffon@google.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 17:15:02 -0400
In-Reply-To: <CAJZ5v0i4nsD8NJr_M_W8_rk2DM_0HBE-jnDyJe2zV+qdeK7UOQ@mail.gmail.com>
References: 
	<20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
	 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-1-3998bdf90ee5@collabora.com>
	 <CAJZ5v0i4nsD8NJr_M_W8_rk2DM_0HBE-jnDyJe2zV+qdeK7UOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2026-05-26 at 13:25 +0200, Rafael J. Wysocki wrote:
> On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >=20
> > copy_data_pages() can take a long (multi-second) time to finish,
> > and
> > currently the only indication of that is the timestamp difference
> > between print messages right before and right after. The timestamp
> > is
> > also immediately reset afterwards to the time before image
> > creation,
> > making it even harder to spot this delay. And this function runs in
> > a
> > critical section with a single CPU online and syscore suspended, so
> > it
> > should be kept as quick as possible to keep the system responsive.
> >=20
> > Call into swsusp_show_speed() to report the amount of data, time
> > taken,
> > and copy speed of copy_data_pages() to make it easier to spot
> > delays and
> > verify performance improvements. The current time is obtained
> > through
> > sched_clock() instead of ktime_get() since timekeeping is suspended
> > in
> > this region.
>=20
> Why not use local_clock() for this?

No particular reason. I'll switch to it for the next version.

Thanks,
N=C3=ADcolas
