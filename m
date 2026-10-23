Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792727015;
	b=edQd2his5XX0aBTEHFKJ/EJoV34eFobOmb3EZtHSzp+6TJKxbCJC4y1bYNNU2VqN+yQG
	 JfaBaCn2xVHJX2RoLVEnWJWNLImTDq3rbQ0riOZy4m59qwZ+q4hePKwUpdEmjoATfs/A/
	 7seUphhXWDCbzk7XvUznXCFJnPFAQQO+R8fs62BcWUoAjj+TavPPqqdJPAJFOFNx18wGF
	 /xxifPa0FwvCRFTPaSnOXomYo+e36992x2kVn9jXYiXyzu/cAn9uX0kquIrI3qYf1Ibjv
	 9KpZaOfSbyZn9Tgj6ehA+4U3H8eOFFHjQvy67lC9M14ZDSfQEqOxliwWdUndmizRpnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792727015;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:User-Agent:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding;
	bh=E50/RBqF2TPivq5LvTrJausyxc+RJyTt4pm/+y89sBM=;
	b=bH/NLK+WVKvEcgYxdtW8tTANuE6N2ITd/4fhXtAu4H5+h2q8pKd81EBaXHjFxYsdywd8
	 ssj2XWHioEqW1VE7HXGVT6hpo/wTUEGO1GAMUqbCj6xDocSopYBTmmbUP+5ahFxUxlXmk
	 SM3/94nkSVYWSC8TxyO9SyixZUNhvRfWtDprVsWLUY5/9rIB6QfY8urJlEafQ6rhSC+vQ
	 D3edDqi6V2xrmVN3XzV3QNvi/0CYNkt27z4tnHEIu0PU5wV2bcC95lnvceBrGJw/7u568
	 iKGYJS9Mg6qz8AqqfYkQkCTxWdzIrDp8h2DPOqNZE/K0PECgsV5XUMP/NM4gXHuYapQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Jl4vS7cB;
	arc=none smtp.remote-ip=212.27.42.5
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0364606A31B;
	Fri, 23 Oct 2026 03:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0364606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Jl4vS7cB
Received: from webmail.free.fr (unknown [172.20.246.1])
	(Authenticated sender: test75@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPA id 730495FFAF;
	Fri, 23 Oct 2026 05:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792727006;
	bh=F9ALlbO6u0ptGfAVky2KFCZatwTm+yxf/LlcIJ/3bCQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Jl4vS7cBMMSYgd0Gi8cFm9hkBEujPmkxWDhrrPtHdumoZu/VMPvc7UwtlG7NkP0Fy
	 T57xROUcPRy+qktmzRV2bg4mcLk+lBdZoRyS0+9fhxtljxGCSlvXDk3v4q6Q8cMZgm
	 6qbmAyLBor0Bx/PJZRqdVOSfj6KDQZH2nQqhSyztHmYvJSUWK77Ob9szG34oKvuYh+
	 SaIoRUme3+hbCgyKICv6fiMGalM22Chaz/yftGCL9Eju1sE+kyP+G5TQgsyJF/nXBH
	 PaUN91dRINMXytNi5m0HdSZmh3g/W8788Nwowrd2EvDz6XX1Ht8Z3AY1Ij4vbM94XI
	 EaSkM5Ho9bnBw==
Received: from 2a0d:e487:69e:6c5b:3ffa:e9c3:575:b5f7 via
 2a0d:e487:69e:6c5b:3ffa:e9c3:575:b5f7 by webmail.free.fr with HTTP (HTTP/1.0
 POST); Fri, 23 Oct 2026 05:43:20 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 05:43:20 +0200
From: test75@free.fr
To: linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: miklos@szeredi.hu, senozhatsky@chromium.org, peterz@infradead.org,
 rafael@kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
User-Agent: Webmail Free/1.6.20
Message-ID: <ba420b83d986313239d1252a94315790@free.fr>
X-Sender: test75@free.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A field report that may help with the design discussion in this
thread. It is a case where freeze ordering alone would not help.

Setup: Ubuntu 26.04, 7.0.0-38-generic, Framework 13 (AMD, s2idle),
systemd 259, rclone 1.60 FUSE mounts (Google Drive, SMB, SFTP).

On lid close, a gvfs backend thread was in statx() on an rclone mount.
The rclone server was not frozen. It was waiting on the network, and
NetworkManager takes the Wi-Fi down as part of the sleep sequence.
That dependency is invisible to the kernel (the same point as the
sshfs/ssh example earlier in the thread). The request never completed,
so every suspend attempt failed. With the lid closed, logind retried
every ~100 s for 6 hours (about 210 cycles):

   Freezing user space processes failed after 20.003 seconds (3 tasks 
refusing to freeze, wq_busy=0):
   task:pool-906  state:D  pid:153003 tgid:6222 ppid:4922
    request_wait_answer+0xd8/0x280
    __fuse_simple_request+0x11f/0x370
    fuse_lookup_name+0xd6/0x260
    fuse_lookup+0x9d/0x1e0
    __lookup_slow+0x86/0x150
    lookup_slow+0x3c/0x60
    link_path_walk+0x348/0x410
    path_lookupat / filename_lookup / vfs_statx / do_statx
   task:pool-907  state:D  pid:171158 tgid:6222 ppid:4922
    request_wait_answer+0xd8/0x280
    __fuse_simple_request+0x11f/0x370
    fuse_dentry_revalidate+0x146/0x410
    lookup_fast+0x15c/0x170
    link_path_walk / ... / do_statx
   task:pool-908  state:D  pid:197388 tgid:6222 ppid:4922
    d_alloc_parallel+0x37b/0x460
    __lookup_slow+0x5d/0x150
    lookup_slow+0x3c/0x60
    link_path_walk / ... / do_statx

Two observations:

1. pool-906 and pool-907 would be covered by a freezable wait in
    request_wait_answer(). pool-906 sits in lookup_slow(), so it holds
    the parent's i_rwsem shared at freeze time.

2. pool-908 is the third task. It is not in FUSE code. It waits in
    d_alloc_parallel() on the in-lookup dentry owned by pool-906. So
    even with v2 applied, this suspend would still have failed. This
    matches the "contended VFS lock" limitation in the v2 changelog,
    but here the second waiter is a plain uninterruptible wait in the
    dcache rather than a lock. This pattern looks common in practice:
    desktop indexers and trash/thumbnail daemons stat the same
    directory from several threads.

The same signature shows up 1,000+ times in this machine's journal
since April (gvfsd-trash, localsearch-extractor as clients). I can
provide the full logs.

Thanks,
Phil
