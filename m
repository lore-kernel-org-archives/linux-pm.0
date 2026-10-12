Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8C37DEBF
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812443; cv=none; b=TVGSpW7uCiv/8b+NSBxJyJvDzGl1fVHhMf53T6uVo/mMD3d4kxGmq9ZbMyZ4cMEQoPHHcCcx6nf8510d8Out7Nff1ZgBvv7DFSzRf3PpKJqIeeT0gsG6Q1echd2GEQeVfsMS82dqYRO/K7nd85tXnIVQE3vvSv0UHlCa3J57bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812443; c=relaxed/simple;
	bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnjPlsy7WScE8OK4GEDekE5v6no4uahRQrkBKWxlAcRBSYMIsm+TODx+V/LEyhPXOzqIMjkiyf9fiBe7yTyx7wFFxwgqHcrNCEtd3te8045Cb+u/JE/xpSC3ix6Y1YThoQjXjn9jl2pwLUKRSDYTBFzUxv2WzVAR94V1ljHngjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewBnIMWR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewBnIMWR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e71fc84bbso1430415e9.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812440; x=1792417240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
        b=ewBnIMWR9jG7PoN2FY36ON6GJaI3KlAbdCbYKOeg+Q1sxJ/OT7NxKrPHpsko3Nlk0i
         zBq72r5QD6DTvzSqqnWZ4OlRc8ll+gzKlSD+QXlQS/LSQSS7CwZQUK/Df9pNqMlA6Wry
         yNKeLZ/BgS9nReZ9zOFu2Km1eEypfXal6AUcW2Nl4Avf02siO/izfo8WZLyeL3gsP9Qx
         Fs9o965XqbmJIhtou7eWdfpjRlxBUfgJ0Sihi6aoZmWDTvBokJq19p+dNcVJYQB8f0Xd
         EzhTBL0k7+odOf5V8qAUNRHAenR+5/X1164OUZ8+SmG5acTAB+lkXs5WtwMbFL2nhIXi
         /kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812440; x=1792417240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BW1wpLoYKk2pIV/zuM1YKBU+Jk4slTJCsg2kUbro9Nw=;
        b=ImgQRNTcOBQNaFmq92VjfUFaa0jAgSSs7pAOmWvnvrBHYfI3xWJZPgfhKtpfwwwF0x
         2fM5FN+Rs+SW2XM3+hGHlJROBqMq2KioHvAgmqmAR38+FgvDfrl0GISgwnBgM4Jp+jkm
         KRyyeZXATaP2v9v+wUBtFZH+INEZlLwQaGO+dA9xB0cCRYRVyeltYGQFIH1r5BhecZNr
         kzNveiqtjFwIsFRMWz616WxPTqK+X7hi0cm+hzmuGEbdvMIPfrO+mzQAmH9ERv1BTv6d
         BJc5HREAgjt8lKifr1o2GwgTU2UGbqVTjk+sqIXRuyB8BRtU5QAkvuTb/3POUGkekEXG
         c2Hw==
X-Forwarded-Encrypted: i=1; AKwUvByTN+TliUq6yxbhDzCB+JcVGKDJzRDjpkOOjIstbvsZdP3jG0Ia5zc+S3CiZ+L8B9LWtqt+iEF5RA==@vger.kernel.org
X-Gm-Message-State: AFq9FYICEwWNw8y0yafSby7qeIe5rNBOHhSZzPrX0tVOAUg4AjgdZvXR
	zscRTRAM2dGz0VXSqOyrIusw1Z299yRtekSMYNJ6VvxkySbo6van/aaY
X-Gm-Gg: AYBFou3GRJXiyzoukVGDPW4syM8JN4TRRdSoIx8sdtLgkTi/hzXezzf/RVNgCXC4QKg
	FHYXK9rpLLZGZDHej03Z2Zb/H13j+f58wRDguUPE2pyWoQEjkjR22oPj6DMJOSyGOvHxeU/S7Yw
	8VmBpaiAB+KaH+EmlgHp4Wg1MYyxYRaoth0u//sAlBkGIuK8n+HQ7ZsKGggQOdZ95fbdDShl9En
	8siyelyHOEftAtlayYxV9nxRmic2pH2+7rkYhze+VY7g7QYnqRyAzXjd6P3wOVQh64mjhVw4w4I
	7RZmpeFS//uakiHRIjR38ZHHpdv7cazT/laJIgLnwEYqe7CohmUkdets0nKLriCsf47nifhNtln
	JO4FDwBeWhwLDvVPGwItBvVdIrJoJiHlo7Ji/bY3796LURceMoDY4Jf8xHWbK5El9W4spYwb6eu
	ZyQfeH3N/yRuu+r2IC5uJWpINxErQkuZlmRzqWyA0G//HApcfMWQUXcFd/SnzLWDgyFixHfenhr
	HSgO31CFl5Ilx2wT45Lj5n81BtuvCM0
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr178450175e9.1.1791812440060;
        Mon, 12 Oct 2026 06:40:40 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm170767905e9.2.2026.10.12.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:40:39 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kayracizmeci@gmail.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Mon, 12 Oct 2026 16:40:35 +0300
Message-ID: <20261012134035.2757-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
References: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The push mecanism part is generic and includes a push on put prev and
> a push on tick when the task is alone and never put back in the
> runnable list. For short slice tasks, we don't use the push on tick as
> there is no reason to push a short slice task that is alone on the
> cpu. The push on tick will be useful for other cases like misfit task,
> EAS and cache aware. The latters are not part of this patch

Thanks for clarifying!

Kayra
