Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92B38A712
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781693; cv=none; b=b8/tszgDZMPYOMjhB2ohUnAkexAhhKWMyLwzA4KpZS9xj8pQ14fKtmmmSEo4tX4Qjgvtjm7iA7HfwUkLhMAgF8IxdwWbBr2ABeEzZsLZOwJ8mHm3TuBITYV8qA1F4ujvZhUCLEpSKVdPGfxvBQOnDp4R6HX730Eak14fHMyxdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781693; c=relaxed/simple;
	bh=C+gelvui8tS6NgId1lN9v0z409E73+KSYs7+924HiSw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWCxDXH46ekHtA7JOJod2glAAj1NdpHhybRdtk0Lv8rYaJCsDOXT8ZbPM2r6m5FCV5md1ftKWYWb6TiPYezFMggpJFi+6h4RKwkf56tVYCVDsYepjfUfKkxN9jw+yxcqmUXHn/ufJ/AGZYNXXJkqcDoh+e9svsVB0JM7HLJ/JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bOiKwns+; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bOiKwns+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1773781680; x=1774040880;
	bh=qL3Ak0cjUbmr5NpdF+OY/TgCOnf5ReTk1JMAKG4ogeo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bOiKwns+lP87F3x3Xnkq2yXAdcR43bEGXDfq5zt/aE+Gwy9KlUTxrchPFsZ0N2Zbv
	 bBwr7RamSMqCATK+xNgE8LI8FpIkmEKhT9s6rdNX4FDyZaPZgdIJBgPFH9wc52t/i2
	 WKhrvxVN5Z/Pd/UY2MQrOPAvjyXnGED1B8oCMbLRUJemWHFBtncalum8+ZkcxCqQee
	 yi4Qo6qJkPSd8lsbN1+K7N3455GrHvrGe6LFY5yuXIevfCEcGJ4rfmrX66i1RnfLLj
	 vXuoVyv/HaAr4+j6r82cRqeoB53moD92MQsoJMURTD/jXPRuvJ1udaE/YPqxUSlRcj
	 QbnpFAXYeUuMA==
Date: Tue, 17 Mar 2026 21:07:55 +0000
To: Joanne Koong <joannelkoong@gmail.com>
From: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
Message-ID: <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
In-Reply-To: <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me> <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 0da1302077d0f203d6100d9b6d5a65f1b4bf4cd3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Monday, March 16th, 2026 at 8:16 PM, Joanne Koong wrote:

> Could you verify if this fixes the issue?:
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 8f8069fb76ba..4cbb22d80acf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_block=
 *sb,
>                  * Don't bother with new inodes or inodes being freed, fi=
rst
>                  * kind does not need periodic writeout yet, and for the =
latter
>                  * kind writeout is handled by the freer.
> +                *
> +                * For sync(2), skip inodes whose mappings have no data
> +                * integrity guarantees (eg FUSE).
>                  */
>                 spin_lock(&inode->i_lock);
> -               if (inode_state_read(inode) & (I_NEW | I_FREEING |
> I_WILL_FREE)) {
> +               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
> I_WILL_FREE)) ||
> +                   (wbc.for_sync &&
> mapping_no_data_integrity(inode->i_mapping))) {
>                         redirty_tail_locked(inode, wb);
>                         spin_unlock(&inode->i_lock);
>                         continue;
>
> I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
> AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
> even with the above patch since afaics, the writeback we wait on could
> have been from a previous background/periodic writeback run before
> sync was triggered.

Yes, it does! Amazing!

I applied it to 6.19.8, upon rebooting and following the steps I outlined a=
bove I was able suspend and wake up three consecutive times.

Is this something you plan to submit/backport to the stable kernels series?

