Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A83845C1;
	Mon,  3 Aug 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775017; cv=pass; b=butEerRRr/bIMcJnd3eE/H1XaqedkTyc+0D1mK5p9kLrNfhX48IrUbOC9V+9M73U5FOyqSQ7/BIx1s0InCT1nch4BlTlkfOfHBtptx6QMsNQkbnAD8zRYR8FigNfRVf4cO/IHsZvJYCfs/lpFJQODlr9nBl+taF2yVELRg75AFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775017; c=relaxed/simple;
	bh=KPdW6Xlx8SeRgOLzLiQJlATArV0N5oNhbyWEaJO2k7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T55auN2r9vjVmCm6vS8nmzERxLdZ0+8wRFu/TkmCdWn50bBFShgEghd9qJcToI3Bsntdeum7BUGyBFXD41gQkLml21ZsHlowV1zESjVDiQf6ggz4t2ou6ttBUhBJy2TwG8YbHvMlGLIVhnG5MCwlqYubef5IWJ6sduVb1IqqQ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=pspIl56K; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="pspIl56K"
ARC-Seal: i=1; a=rsa-sha256; t=1785774993; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IzTK9/Hve+6TTPKVOLoV2m/o16uLkxHWdsn3LmlKXYLXHE+Bg63dZC1uZN1aC1bLcAh+dtPGpzfEcklSeIWWDxv/31mmu2ZARo2rF5yrrvWsvKLKoEGJ5YhphJeBkab+6v7st6SinxHfu3DbdoCzCmGjDZfhcWuKdVNklvxVjyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785774993; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KPdW6Xlx8SeRgOLzLiQJlATArV0N5oNhbyWEaJO2k7o=; 
	b=bXmHU45f2geNLQVf5w3ZYFTnUCCiEzLb1/MInF4At8Tf9Ln0ARtHCWT3JZXj/v0akl9EW8baBDtMDk42VOSWzWMWCsolkFJ9JeZhw6N9XswvTEsiKq+lWwKe4cceZk4J47kx07s7pr5W4BLi++zox7TptYFf8fYrduxlKMQS+Z0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785774993;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KPdW6Xlx8SeRgOLzLiQJlATArV0N5oNhbyWEaJO2k7o=;
	b=pspIl56KbFkrCY4XmDumblkPGovkkHCkwmwYQMHH/PIPyDYwUdOakmKJC3MnvhpZ
	KrrjAH0Oh91M+Q09pG8WEaEScsQWdy2TBfsHuwgcVicUbpc6ejGvtxQpnKM4Od1YCiw
	ROLVRwAXuu71qo65zcy2qroAglqKldz63L77SuIQ=
Received: by mx.zoho.eu with SMTPS id 1785774991113161.8230768767778;
	Mon, 3 Aug 2026 18:36:31 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
Date: Mon,  3 Aug 2026 16:36:18 +0000
Message-ID: <20260803163620.104223-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c746110c-6ac4-4500-a4f0-491a06838173@kernel.org>
References: <7fa98ba5-6790-48b4-b102-c1193685822f@smtp-relay.sendinblue.com> <c746110c-6ac4-4500-a4f0-491a06838173@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Mon, Aug 03, 2026 at 10:29:15AM -0600, Shuah wrote:
> Sorry I am not taking this patch.
>
> Please note that build test just verifies that the code build which
> fall way short of testing the changed code.

First, sorry about the duplicates. The mail provider I was using at the
time rewrote the Message-ID and delivered the same patch several times, so
it hit the list as a handful of separate threads. That was not me resending
it. I have moved off that provider and everything since August 1 goes out
with a stable Message-ID from git send-email.

The valgrind run was in the notes under the scissors, not just a build: a
two-CPU mock where CPU1's topology reads fail, uninitialized reads in
__compare_core_cpu_list() before the patch and none after. If there is
testing you would want beyond that, tell me what would satisfy you and I
will do it. Otherwise I am fine dropping this.
