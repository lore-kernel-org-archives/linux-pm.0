Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585079;
	b=k6dZMy+yd8HmLdwhfttrbe+EzWPNDbOwWuvpm4by4X0y4hIXZ1aPEqdQ3ufylrl27zvB
	 sU3Vl3O+MfdRBydTlIu6rWSoJZz6/Y/zbE4NeMJUMUz4M/9iHuTuB1rTif1s/Uz2fTqpD
	 VlQ0VL5HamaAtnbVLVr2iiK+0Hnb/hddnu276ysL1uZFYtDfyUx9EwbYAHAYKIrz0DAOr
	 E3kfAKS/l+5N+2JyikMzfFvGl8MRpMOQCs7BJa6dpv0n1YaMJLhpU/YiRMEw7HuI9cPq4
	 xCq/xqChNKUIiQ+WMNIlWbxY4stbRLqC5LsJ2ffM60Xqa8X4f436/WfHC+4ddWm91AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585079;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p57p3uxeYdPu3dO2jsiMkVBwtyV0ivwwKUFjRQ3jCKE=;
	b=1fAcpR/3r0QIYokZ+FwWFimo5rPcbz6tKuFomO2895M0z2XHkjLUzCFa2zRGsiL0k4DJ
	 5HSoiLEAHN4+O8duCQ+Wet/Le4tgrZnWwUjWfqMWqJJvNKEruS4HI/8a8auwN6z7D7TNo
	 C7f3K2VwF7IGVlo9ednT5SoYFwU2+57tfUbJbutciypjcVkjS5Yo+o/irNY2Fr2NFN37M
	 5VFAH9BquhW2VHe6iREcNk4dDjIIR8vyceEkl9Pxl35NXBpwO1XMnkNt5QqHxeS8vdno9
	 upECHkDVj+YNxxe1Vz+gUPOupADVn6pDToBVV0Tkg1vfztCGox6STrgv81q15SUaKdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FN0KJZ18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B29606A338
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FN0KJZ18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17931F000CB
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585079;
	bh=p57p3uxeYdPu3dO2jsiMkVBwtyV0ivwwKUFjRQ3jCKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FN0KJZ18ufP4t34x3hktZCSe0aaNqse1xEqZgsLbeR/Frb6pvjQJH1OjkaSA0nL2e
	 7p76I6IxZL1Qkjw6zn9ySR0RQ9Hog9yoK1JlPGR8Bd+FIdJkhvdslZWi8YwW2ue/Tt
	 Kh5gtRnrLvsJKC4J1s9sBzYhyUTYpnaShRn4YIj+Lpl368qtwEOpaoCMyi61AhvgOf
	 7aNchmRnUy/4DcEGJW3/pD0soMaH6fuwC5ZIfWiuoZlg6CMoCSYgM+W7JjuWuRye0d
	 F36hfjXCIcLesN6/RITI2LR0nFsfPEbxKezOgyJYz7LJ+1f14XtOJVGCJkTrn5aW08
	 y4k5N8NW7Djmg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1921982e87.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF+CjZccTDe4KtighZeI9fTcsjppf/ITi+8h7TrJ1fjdbd5P4UwcyZ0Zvrg9vVvbvfEOAN0P4TB1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kVu8Gs/41G6sVRa2wgN+55qj/GtHRDpii4DpT7mpfd0JpFKAe
	Io1Tk1Yux8G9VsgufRtLQmRPOxQqPXT2im8qQy15e7Ncb2mSw0ffEHobMChZITg4VCPibqUnKGq
	UsaZ91BfCMfHIsnJ19r7ohlWABion8Qo=
X-Received: by 2002:a05:6512:684:b0:5c1:4bd3:ef75 with SMTP id
 2adb3069b0e04-5c1705fab7dmr1078301e87.1.1794585077394; Fri, 13 Nov 2026
 07:51:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002034200.920546-1-xiongxin@kylinos.cn>
In-Reply-To: <20261002034200.920546-1-xiongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:51:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jhOR4yEoUEb=DqtRcXt3q1EZmP_bVV=e2dUJjFsWXzAw@mail.gmail.com>
X-Gm-Features: AclHuK9gRwE4EUxI2tZOxwW3kLea2bFo-TxB7U1voYMoOeRcICcneypDQhX9T38
Message-ID: <CAJZ5v0jhOR4yEoUEb=DqtRcXt3q1EZmP_bVV=e2dUJjFsWXzAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PM: hibernate: flush icache for restored pages
 from task context
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, james.morse@arm.com, 
	hch@lst.de, will.deacon@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 5:42=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn> wrot=
e:
>
> Hello,
>
> With `hibernate=3Dnocompress`, load_image() submits the read bios
> asynchronously and hib_end_io() completes them from hardirq/softirq
> context.  The flush_icache_range() call there, added by the
> commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
> restored in-place"), ends with kick_all_cpus_sync() on ARM64 and so
> triggers the WARN_ON_ONCE(!in_task()) in smp_call_function().
>
> This series fixes it by keeping the flush in task context, and first
> closes three pre-existing holes in the restore error paths that the
> rework would otherwise trip over.
>
> Patch 1 resets clean_pages_on_read when load_image() finishes, so that
> a failed nocompress resume can no longer leak the flag into a later
> compressed resume, where it made hib_end_io() call flush_icache_range()
> from interrupt context for the reused ring pages of
> load_compressed_image().  The flag is also cleared as soon as the load
> is known to have failed, so that the bios still in flight do not flush
> from interrupt context during the final drain.
>
> Patch 2 stops snapshot_write_next() from releasing all snapshot pages
> in place when one of its internal allocations fails: the read bios do
> not take page references, so freed pages could be handed out again
> while the device is still writing the image data into them.  The image
> is now released by the outer error paths, after swsusp_read() has
> drained the batch.
>
> Patch 3 makes the error exits of load_compressed_image() wait for the
> read bios that may still be in flight before the ring pages are freed,
> like save_compressed_image() and load_image() already do.
>
> Patch 4 defers the flush on the nocompress path: hib_end_io() now only
> records the restored page on a per-batch list, and load_image() flushes
> the pages once hib_wait_io() has returned, preserving the asynchronous
> batched I/O.
>
> Patches 1 to 3 are new in v3; the per-patch changelogs are in the ---
> sections of each commit.  Many thanks to sashiko for the v2 review,
> both findings are addressed.
>
> Xiong Xin (4):
>   PM: hibernate: reset clean_pages_on_read after load_image()
>   PM: hibernate: do not free the image in place while restore I/O is in
>     flight
>   PM: hibernate: drain pending reads in compressed image load errors
>   PM: hibernate: flush icache for restored pages from task context
>
>  kernel/power/snapshot.c |  9 ++-----
>  kernel/power/swap.c     | 55 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 14 deletions(-)
>
> --

Sashiko is complaining about the last patch in this series:

https://sashiko.dev/#/patchset/20261002034200.920546-1-xiongxin%40kylinos.c=
n

Please address the issue flagged by it or let me know if that is not a
real problem.

In either case, please send the series once again.
