Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558938;
	b=d8/2E/jpAWgv/0nYVNdybdkR7jhAaeuWgQ3wCGRNVkln1HxU7TGJxHUl6OQfyW+Uvjiq
	 7dAzX29L7bzGTJvX1eishAAZbPO70/CfDgihkS8yeq9b9NYwxmmnXpztpnkyFEmakWx+U
	 7zYi8Rm4f9pJjg1nkboTG/PHbaml5M7SFROQT1PosHufCOjyBVN/ukDMkqC3cJh0e/1dT
	 +KkAPWcxc1t1R3zzugTf9M82lBiDoWrLwYkfBHEPA06qNxxni/DDJ417R4HzqTzido1XK
	 nIm6i3W6TFJT7FF1ZeL6Fgs2NzKPaQRlG2JsqtssFMFOcBVUQ2T87XCmhKWrRg6c3tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558938;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=h1CW13lpZYVm0wmdDSJrVvfHw1mdjy5FAwj4xQLmKNs=;
	b=DpsxGI3OkdX5Ma6ql5tNAlhFRLBAZRv/59T5n4z9i+xX0XsLE8iEncv/aXrGSUppLpfj
	 w5X2obvdDgviBuDCFFuhjrDYn45mcXQo+L7F4JIj5gbQYvXr8XJi/nkwF4DhbyxESKJZT
	 jBmONHHXYp+Nsb1jtVfEgXyZJ9pSlsE9GPD4R8S36B26d0bEZPzRR4YbfH2KQMGxW/5e/
	 eMVTPbwkaOVrI9qe7/jGM0IsFHwWFLg9mfImXTjmi/yjDQpOuS6pUgH3vQWq3Z8I+kHfI
	 aDzWPF2EeqJIhP7TXE3ggFQ7mUTBuYTkaZRRBCLCGb5LSc7Vdq/n7d/jKpM5CEpZQ9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=aH3LPVz6;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D598606A8B6;
	Fri, 13 Nov 2026 08:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D598606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=aH3LPVz6
Received: from reply-fuse-freeze-v3.eml (unknown [195.154.25.110])
	(Authenticated sender: test75@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 7636519F744;
	Fri, 13 Nov 2026 09:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794558930;
	bh=xSHknQ9ZUP7jZdL/cJzlcRIMwVR4CszQSFP2C1kwJ74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aH3LPVz6thNZPJqM2Cr1TyDKxdY5idurjG9T1p+j/xi1F3mi8zasW8F/66Ykv0toH
	 nfkZqSGVfv8OYqGwwTMh7Y63ZwffqbxqLwABBRnHUbnwQb7lJJyR7eSsIu1bTDNeEK
	 +o41Wo1mjX6q+85SAMppAzs4Dhzpd+4qxvjQFINLZjGN/CbkqwZ00rbUDCgTTrEkpB
	 BEFiG3M+2GVHLLSu4rfQ814FikOpXxC9FhK+YjS4EnMizv76MKN+ExeMQwytpAIh0E
	 D2YdhJ8v4yfw98du5KkilGGx8LtcLOrxezgGqtL9W+Ax0pj4Pe1fToizTrxJHSpfBT
	 Y6V8CcmpceHaw==
From: test75@free.fr
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
In-Reply-To: <CAJfpegtv6=40SEsbeVU3RpmjwZSY-FLvCg7mcxf6k7djFZrPHA@mail.gmail.com>
References: <20260819023542.561653-1-senozhatsky@chromium.org> <20260820084933.GA4036497@noisy.programming.kicks-ass.net> <aobDGgivy43cz7xQ@google.com> <20260820091018.GA4120091@noisy.programming.kicks-ass.net> <aobGRjc7SE1rwIHu@google.com> <20260820093402.GB1837346@noisy.programming.kicks-ass.net> <aobKfyGHkdMcleoc@google.com> <20260820104111.GC1837346@noisy.programming.kicks-ass.net> <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com> <20260821083000.GF687043@noisy.programming.kicks-ass.net> <CAJfpegvRw0Emd=2hsEeg3AvYaLgRBUbMdo-=eUMa3FRFfnetgA@mail.gmail.com> <20260821145752.GG687043@noisy.programming.kicks-ass.net> <CAJfpegtv6=40SEsbeVU3RpmjwZSY-FLvCg7mcxf6k7djFZrPHA@mail.gmail.com>
Date: Fri, 13 Nov 2026 09:33:50 +0100
Message-ID: <179455883014.1731541.16877509095558539853@free.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Miklos,

(Resending in-thread; my first attempt on Oct 23 lost its threading
headers and missed fuse-devel. Sorry for the noise.)

A field report on the contended case you raised, with one
data point for the "optionally freezable VFS locks" idea.

Setup: Ubuntu 26.04, 7.0.0-38-generic, Framework 13 (AMD, s2idle),
systemd 259, rclone 1.60 FUSE mounts (Google Drive, SMB, SFTP).

On lid close, a gvfs backend thread was in statx() on an rclone mount.
The rclone server was not frozen. It was waiting on the network, and
NetworkManager takes the Wi-Fi down as part of the sleep sequence, so
the request never completed (the same hidden dependency as the
sshfs/ssh example upthread). With the lid closed, logind retried every
~100 s for 6 hours, about 210 failed cycles:

  Freezing user space processes failed after 20.003 seconds (3 tasks refusing to freeze, wq_busy=0):
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

pool-906 and pool-907 would be covered by v2. pool-906 holds the
parent's i_rwsem shared at freeze time, which is your contended case.

pool-908 is the one I wanted to point out. It does not wait on
i_rwsem: it waits in d_alloc_parallel() for the in-lookup dentry
owned by pool-906, and as far as I can tell d_wait_lookup() sleeps
TASK_UNINTERRUPTIBLE. So making i_rwsem and s_vfs_rename_mutex
freezable for fuse would still leave this suspend failing; the
in-lookup wait would need the same treatment.

This pattern looks common on desktops: indexers and trash/thumbnail
daemons stat the same directory from several threads. The same
signature appears 1,000+ times in this machine's journal since April
(gvfsd-trash, localsearch-extractor as clients). Full logs available
on request, and I am happy to test patches on this machine.

Thanks,
Phil
