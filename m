Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772611;
	b=i/3bJLQWgghyrGd3ksJCfEVi5xQMrmdg44LEJ7NCmsr6zRBJnxvkdLJQgDeSHjQNdzid
	 kAAC6N2P+HWW9vLdpk9Aeq4GXHyGxiLtR/WPmWAOkaqMspQKVIXKiep92SE03g+YBdwcn
	 RFIkDx1qjKdTyXqVcqnjGp0eu2HJxkjVbjd002bi2U3TjiDtQfU9fjUsdnkL2dOzuBnfm
	 KpCY3XGhbB24Wxxf632j1k7khfIZdMAfKaeaqlErVwqt8+73K3LzAxwMtjrCzwzzqzipP
	 7dVDBDpYjm5FqIrWm46vegv6WDJUtxGkxxmZ+BZ+4DubmCHaoA/7qTzFEfgTpW6clIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
	b=QdhKG49Adsoh7aSsnbritb8HmnlFBavCASzLjN/bo3WESgmXkVRmN4V0AKDvXgTUg8dU
	 +yu8JlkB5uo4FWOEjotPOlRDA8NZULOMRQqk+mbm1DSsn7PY6cL1zh/3EYRQDjWPMT4vd
	 8lhIbsE8peANCIfGg0w0DFwyTI+QlI3pCB35uqdtkU9p3XosGrcfdWy9wuCNwZ2rHiqNp
	 lv/dxgijGJkYtRGWp6Zao4YpgeIpSR2MN+EVUqh/FlqtMdwZiJcTirYoQ79LQEX9cbWRb
	 aODei9yNPAv4jgPuwIPDoyF7adJYQD9LPw/kKaVR+XRBWDMwOTtTHWjEvGfk86I+vQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0bYFay5;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89D606A31A
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E89D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0bYFay5
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so378360a12.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772610; x=1793377410; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
        b=Y0bYFay5rd5Colmv2O3UNeuLmTZNXFLIC/MvK8TKv0S1BpjdZ0yre/J8qNF3u9ElSg
         02Tq04Ah+coJxqKQSKeaKl8qHFBsmIDKOaz9RhgdtLHAKJpXn45LWy9crKwQ5jhaEsfo
         EfF8cz/coLGrDSNKhfFbdUdIb7ZlUJTpMtMO9PfGugI1m1HXnJFDUir8sc2FCkYQr6Cb
         eeEpe8tiwmfvUzGgfdV/fZI+LdK0afmyM8nfde02KMJCboQUEwoYV+ZIoFdxcsRGwsEI
         8jS2GEc25AYmn3VV/D5WMNsyPwX/QXCPIghs4JtIegf+1mkHEMs5RuTsNIz90k0x0vtr
         1QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772610; x=1793377410;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
        b=yFU+/3TbX72Tnq6t2VOW3KKO0lHOCqKTYbj+eBAcCN//L2JQk4jfBO6BsQUE536cfE
         MQzklm19xZSi3qvWxT41zItayaFfIZXToPoRfhl+w05IifvvlNUIkWKH+rFMFBYvR8da
         FsL/Q3hatAYstVq6uaYdbNmWBraHLk+QV7yQRZ1t+zJFtYzymLSBm5OVgk+APSZnnBUu
         4SAeJnvUVizzy5kk/wCTC1uwlilUM3L5/cDs9vf8HmAWC0Q6Rr3M8iyanXmDRt1+Zimv
         KafK7KnREzierNZ+QsDA6vuaLLjCr+i8Rs8luBDCxglbTzQa585VyKLxv0TRGiJKNxAP
         gppg==
X-Forwarded-Encrypted: i=1; AKwUvByVsAtGFmmmESWmQDJ+dOuKPqX/WyO3zHTyTY9mdjLbhG/LRUr1Vp5gLeTwfiNKDakr9YN87Swh/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVum5GyE6Rzv3LfHIBEVPhIJoYr+zgIfUkymVCS1pDRcXrhAFV
	cUu0n8mkNdKTrK8tEppKe1Sx0KHS4ZwGvM2gaNAZeVal1LsSFZaQrbEt
X-Gm-Gg: AYBFou0zdBgnMcuRQUHZkAsZZrEKwmSfa7Y/0nm2vM+zJy+5B1rCm1TCapQKYZN0uFy
	X+fuxFUgtTfUflSNjnmoVkCgIkF0d8sZHfXRC9Umsx/ti1JM56qh2XDsLfKA9ilccbAQ0+qQBZl
	ffKXE074mYTchJ7CYTyXvP30VbLjXwYS0C71lCwLeuiJuy4lBO5QQ8pYLZ1emsjHhSEgOi358Ib
	6GSmoN0ubBvhfX1J4i7r9Z9ZOhKnbU5DYHDpYarhvcBjEWuv0PpFENjtBNm8hy+ur05g7PMfvri
	+wSxD/tawa67Lnb4L55weNZbMGlmKMb0aTaRAB1p1kERbMywnEB90K1QNlVLAVs/lrzblYQVbpR
	NEI7704BdYiplaZF7JP8npxV1da1/irQEQEqfYN04XuvIQvFeAdIR0e48t0Dp2Cy6EklsE8HUE8
	/QnKi42ChzMpoQOjdJA2EoNRRBwKF88FIy5RYI9GJIdF+eaoJJughWybuMmjKxKWTB2BD2D5jNE
	TNPyRxlPuURpE3LlegqYHYlHMzSyM9TEqZOQk9FZXfaeQuhTJZ4ofTHXX46Heq6j6K2IrHYQbmW
	oBeu1mOwAXg2EHHf17fY5Cs+FbI54EZZcPRlRmKOBBCeEhOlKeUkyv6BXpWo
X-Received: by 2002:a17:90b:3dc5:b0:3ac:9176:e837 with SMTP id 98e67ed59e1d1-3adce0cda5bmr2496299a91.50.1792772609968;
        Fri, 23 Oct 2026 09:23:29 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addeb6608bsm702851a91.14.2026.10.23.09.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:23:29 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 16:23:29 +0000
Message-Id: <DMCCUMTT05PZ.31P1L97OUGHA@gmail.com>
Cc: <zouyipeng@huawei.com>, <zhoujinghao24b@gmail.com>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20240927101342.3240263-2-zouyipeng@huawei.com>
 <20261023083131.58291-1-dennylin0707@gmail.com>
 <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
 <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>
In-Reply-To: <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>

On Fri Oct 23, 2026 at 4:17 PM UTC, Hungyu Lin wrote:
>
> I'm withdrawing this submission and will take it up with the
> RFC author directly.

NO. Stop spaming people.
