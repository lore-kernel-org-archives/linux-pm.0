Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998423E0C73
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071884; cv=none; b=SAsVrFUhguxnvtYh1vUv43fj5UouI1RlWztHWlASHUAK7TPmkFw/HpvmUyVoBdPL7gw+8f8ZfSVaqwBH++512knYVwddA0Lt6Pg9+FEvNWfSulbl8qntJWzdpxlwnRhYPqBOPTjWWF9x0pV2K7Mp32hzpxB6zWRKsj2tNOLgfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071884; c=relaxed/simple;
	bh=gpYTjl/K/JmSlV8fdXZdsLXVEjxzw7nKXOo7et2l8s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+j7aDZnjTwfsR4W8drLbaH2VfbBVlFXcak98PvaqXMK/FsqKJtF2Qza808C1ruDHOiZecRgxxIpUGrp5Z+OyWa9juwm42zsjaFj+ZFi54Lv26B/Vt6QUGuQQb10PW1ak/++3VAA6WkDyq3LKowxrfOaC27jujOpVsWCic29WzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WhnrzBzG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WhnrzBzG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Cc16Q1/mvr/tdL8wmKwmB/FUP35FovOO7CfVZla+Rvk=; b=WhnrzBzGPZeqrj/u4Cd0b7NWEW
	/FOYR+ioCwXSfICckpM89GVUw5knDyJfqS4gw1zxavusu5QEm4DHy18zznktFXFO9HlYl0zEh9TJZ
	xDF4szTrOQbdDyKb7qTaPQaDBb2XizK8Mo5MpMzuHppmxOy7vAbC7zjfW5WrrZiaAXCgjxJ4rUHSY
	XO6G5Dqs9pqN6AtKcZxwYQN74hyYzOl5ujOaVtmTS9WbAzv+MaPhzqBKMyiPgkRaoNSBrYS9l6o9c
	U/x9f1vgu1bdzki6MHXexRQpCf1Qrd3p+YTtCWWtpMeSa4dnGedK8RYsz0NukatTXTU5Ltfir4eba
	nq/dbraA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzczW-00C7Zh-IL; Mon, 09 Mar 2026 16:57:58 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
	by mail.igalia.com with esmtp (Exim)
	id 1vzczU-003UP0-Gv; Mon, 09 Mar 2026 16:57:58 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
	(envelope-from <berto@igalia.com>)
	id 1vzczU-004Q7R-17;
	Mon, 09 Mar 2026 15:57:56 +0000
Date: Mon, 9 Mar 2026 16:57:56 +0100
From: Alberto Garcia <berto@igalia.com>
To: Brian Geffon <bgeffon@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: Drain trailing zero pages on userspace
 restore
Message-ID: <aa7uBMrSII5l-Ofl@igalia.com>
References: <20260309001250.192841-1-berto@igalia.com>
 <aa6uYoVKegcac2Kq@igalia.com>
 <CADyq12z_mhjY9S1_jawX8UuviyYf-ozXn6Q6yB4dHxopD7JmTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12z_mhjY9S1_jawX8UuviyYf-ozXn6Q6yB4dHxopD7JmTg@mail.gmail.com>
X-Spam-Report: NO, Score=-3.9, Tests=ALL_TRUSTED=-3,AWL=-1.733,BAYES_50=0.8
X-Spam-Score: -38
X-Spam-Bar: ---

On Mon, Mar 09, 2026 at 11:01:15AM -0400, Brian Geffon wrote:
> > An alternative solution would be to do it at the beginning of
> > snapshot_write_finalize() if handle->cur > nr_meta_pages + 1.
> 
> I think this makes sense, but if snapshot_write_next() returns
> PAGE_SIZE then we need to indicate some error (eg. -ENODATA) in that
> the kernel was still expecting another copy page.

This would fail anyway in snapshot_image_loaded() because of this
condition:

   handle->cur <= nr_meta_pages + nr_copy_pages + nr_zero_pages

But I think it make sense to return an error directly from
snapshot_write_finalize() as you suggest, I can use -ENODATA.

> Also it appears that the kernel restore path and the userspace restore
> path return two different error codes for !snapshot_image_loaded(),
> the former does -ENODATA and the latter -EPERM.

Yes, -EPERM is the one that I hit in my tests.

Does this need to be corrected?

Berto
