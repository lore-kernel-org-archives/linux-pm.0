Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794368335;
	b=uELckUrCbE4ju02qrWEwAYimHn1PeE3mQoDwHvwhtnuGodYWRdY0LJiNsMFxne+BIoWj
	 k8mlytZZsL+zL6MGG7OR9gCBeX+JXUW3CWZsthdn9wkmNmVZ5/I/fL+y2F1MTv2lCxXG0
	 OF02cqVwpCNKEssndYvxFfUx5fmSmc7X+CUtatpMRraWfx2ZbEMnsZx6VfpsKsqvjUtY2
	 co5LwTq5wCSM6E6Mes6lz6JPp7ABPtFLKbEK1pC94sCcQoDOVl4/Qdwm7wMqpw+uBSrat
	 S83bx4U9k4pR4mJ1cmHVZ6FIcP8vhs5XJrtJI98qrYRJL1UufkXe/kSap2qz6HNUZ7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z2ET6l1kFZ7646cHbCayQI5WEMFcXf1kwxAiWCRuN1g=;
	b=Tpw7D/VijxEd73G4/5u4op1cdtk4B85dUsSw3Tbu0PlyvX2TB2MaX7Fk4YUm5yLGh1Kf
	 kV65JVgUPfcbz4Lu4Uwo9K+6vhrwWkJj/Yujq+cCFeDKq7vQb6tzulqUu6DCaD5CL/qOs
	 f+yCbEr/wGeiIzdtWb2/VJRPyyKwcyT2RzGKCPgw72aAVxmSMVJ/aTH/a3pD9UlpiFxYq
	 rxAyPyR1dSzXnZB50LTlNr5h1IVHWC2DyuVMFqGdoVOow7nxyggLLdfTHxOwWOafU78zu
	 gBDnbiFTHB7hUtmZdGIdtP6aZb3CCyy0S3rAwrhRCECiKGry+x0A6E/Gz3PybzZmDFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q48DEDPK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63332606A320
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63332606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q48DEDPK
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so373132266b.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794368333; cv=none;
        d=google.com; s=arc-20260327;
        b=DBrW2HGnroUzDNTxd4zXRIZFQTw1L6ypa7/iX+I+k0cqGjMDEh+wflYf3W2fecVOZX
         5Exabe7AKzhA+kZHeLzURuMywlYrJSQVbi2X1IhLnXXpBE2jp1+SyME/3j/pUHyUh2Pv
         NCyXtPLDFbsBDG0qZOJsKHTlhQwjPUSYnxG3J5gE2MFDaSYL3PS3XzzFIrLvsR7SVi/K
         x/uEziIsw4SLoeLgH3PMkkdBxeTn+FyQu9qhSH/q5lHW2SmflEikbxmfidi+6MBHnlXc
         IAaBB6tQMnowwdcV7Bbt4yzuATHtjBfqYaR+nAWTQUO8jmFGWJsUBi7zUOXHfbHj/0fT
         65xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z2ET6l1kFZ7646cHbCayQI5WEMFcXf1kwxAiWCRuN1g=;
        fh=3otpeBqPBDrH+03EVNOEy0+fSKaEzVCUvPWR07AJglM=;
        b=NoeH8/xIEvWd/pLgQKTMHk49Lq65pTINNdb5X2NAZhTtlL0GSpQ4/BT61mcQtqa9Gl
         jiwh5l60p4hSzEtVMlAZUeLBbEGFK0RIiOODLfEKsoF3rHcMQ4it+cUmmXoNtWgTjH1p
         UJOLqC4H+nwXdC/NiO1SAnLtQwIbuvjd75bkzkcrNZTA8SnWQ0krdmMOnv3Bt/zc+0Y0
         OOaT033witxDSLNyXQuDYF20u1IpthXpo4E8iQ+EbzOQ9PPH7vJBgihFgMBBwu+Z07Zc
         +O49r4gSff/4wJ0TDwcwtRSWM4Zy95WmF1LWzDYwuw/vXMAW1ZgNEvi3O3SsiyW+OnZS
         8vsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794368333; x=1794973133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z2ET6l1kFZ7646cHbCayQI5WEMFcXf1kwxAiWCRuN1g=;
        b=Q48DEDPK3Of2iJ2kM6UKtQiZRfJnMg7PyITt8bFmZHKKWWyFDhm1OJuxNnIOt/aTgT
         4bh8Y8ReU9hiLWFjht2jSVZITzhyJbDqR6fXNRhud4YAFKX3Uiw99skP5j1XYatYxLY3
         gDMzKgqAbw8BWKRZyGpJC09abkkh6f+MKiwXaa4NmlWXMjRWfZeE1b53DMUe4h3/v7NI
         D/oJCcbaLwyfi1rAwa0YEZoCngyaU9qmRWFrpK9AXsDauYUC3/MWazSQAIkOO5DvYhSi
         9AITZcX0gGxQSRfuIIwS7ZmCZzbja+jLDTMkekuCm1RM7Hfa1n3kB9ZE8K2qSyVmUSVO
         1qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368333; x=1794973133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2ET6l1kFZ7646cHbCayQI5WEMFcXf1kwxAiWCRuN1g=;
        b=b5KfDrithlu7wcvF0ODSNFpwPj6EHujuanJNWIyYVPp+xc8FAkyyAJZeIYygMqiA5O
         zS3eEhKjKz6VVmgOPyfHADpXkaPVejYUKdQnv+t2LuJ8K4LSG4F4qep0TAx+6lR+Mo6/
         SIgzLko+/S8g8z1HYaGV+/x2oQtRZ3r/sPsQRrxnBYxUX1BPtBOVvDHaMPFCIyRuZlPc
         XRFj2zEHUuVlGPPZ6vYWPBPr4PIormFEo8zXyuCnijZFrVPV1u6zZ9KPk64oUqmJ3AFp
         fzYMdvZBAWFimjPBZ2uzhGcC3hPqS3ARtfHlxZ8MXE+1e3dgCin2h8Bq643l0srXQePb
         IDpw==
X-Forwarded-Encrypted: i=1; AL+hErFfmanfgXtXMPY+FzHUrABgc2mDKwMtwtSkbVf+X4YLLQzlNO27buD8BbWKwxrv5orztIrXBc14vA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8uXay3XSdSk3jrm6MJEgweCH703KOP1UCJjkRlwoGww/4Jx4F0
	pgdVKRiTpFb5IQBqxdkYJosxyMJBz+JKP6PSVXplDTSQCzI/P3hheXzBp73WpkncmtKgWlPKtFk
	FglOQ3DBhrg/y1Z4OL3o4Vn+BfsHll6KOg1TTB5/t
X-Gm-Gg: AYBFou2fKxn6yw9wBJFiY38yGZWUgxpae8vgcLnQvjsdxJ8XmyxqDIStcjek4WgLBP7
	GjpCjMNjiQb+5tQ4D2o0orD06eEhqXROkEjLjGK/GP7nop5XSv8NFkp16E3OA7SUGUF1iDV+AOP
	/sUUmpB7Qmg9nhA7bLVnoBaU3J0K05pr5uC2FV2uYLFe74lDJOcjDH9Oh7ZCs3DwUB4BZua2no0
	TMLD6Jp03hoXnX+aeDDSySJNQvEt1Pbbx+YsEYWpScKmmykhQPGAiWWTfJay7ShKEDKIGeRb4Xm
	6LikC8IQMUBodVtpsPOHfJglI/ty7SzSZ/3ym1pGdbThSYFfhgVkDQH8P5K+r0kksaIF+jIC4lt
	Zta3ta94/D2sAPgXYHamMrk+VsGsaIApu9ZW72Mu5F/RalK4tJTbedxnrjVkrCjoiWtayCKWg7y
	1ycwb+DGivGgo1TJ8=
X-Received: by 2002:a17:907:3e8f:b0:c31:c767:adfb with SMTP id
 a640c23a62f3a-c50662a8062mr90474166b.0.1794368332418; Tue, 10 Nov 2026
 19:38:52 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
In-Reply-To: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 10 Nov 2026 19:38:39 -0800
X-Gm-Features: AclHuK8W422emwCtXaoFuChUjWHORL2ljfu7vHUC1vM8aNEtLmFd_5-AJv8NDRY
Message-ID: <CAG2KctpRRDMXR8wG40PeohsTyAdoNC=+4Nc9pHGQc1fmw9AXeQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: runtime: add new runtime metrics and summary
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 3:34=E2=80=AFAM Joshua Crofts <crofts@kernel.org> w=
rote:
>
> Add a new set additional PM runtime metrics to improve power management
> debugging and reporting (these metrics may be useful to userspace
> utilities such as Powertop).
>
> MOTIVATION:
> The current implementation only measures the duration a device spends in
> suspended or active mode, which is very limiting. We can't find out how
> many times a device changed state or what its shortest suspend cycle
> was (to detect a sort of power "thrashing" behaviour).
>
> NEW FEATURES:
> This series introduces the following new metrics:
> - resume_count : number of successful transitions to active
> - suspend_count: number of successful transitions to suspended
> - last_suspended_time: duration of the most recent sleep cycle (ns)
> - min_suspended_time / max_suspended_sleep: shortest and longest sleep
>   cycle durations to help detect power thrashing (ns)
>
> By reading the debugfs file /sys/kernel/debug/pm_runtime_summary, you
> get the following table describing the power stats of each device with
> runtime PM enabled:
>
> Device                           Status        Resumes Suspends   Active(=
ms)  Suspend(ms)   Last(ms)    Min(ms)    Max(ms)
> -------------------------------------------------------------------------=
-------------------------------------------------
> 0000:00:02.0                     active              1        0        45=
688            0          0          0          0
> 0000:00:1f.0                     active              1        0        45=
687            0          0          0          0
> 0000:00:1f.2                     active              1        0        45=
686            0          0          0          0
> 0000:00:1f.3                     suspended           1        1         1=
658        44028          0          0          0
> 00:03:0                          active             15       14        19=
627        25899         42          5      14811
> 00:03:0.0                        active             14       13        19=
626        25900         42          5      14811
>
> TESTING:
> Tested with an x86_64 defconfig kernel and QEMU.
>
> AI ASSISTANCE:
> Gemini was used to prepare this series.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
> Joshua Crofts (3):
>       PM: runtime: add additional suspend/resume metrics
>       PM: add sysfs attributes for additional suspend/resume metrics
>       PM: runtime: add debugfs entry for pm_runtime_summary
>
>  Documentation/ABI/testing/sysfs-devices-power |  36 ++++++
>  drivers/base/power/runtime.c                  | 156 ++++++++++++++++++++=
+++++-
>  drivers/base/power/sysfs.c                    |  81 +++++++++++++
>  include/linux/pm.h                            |  12 ++
>  4 files changed, 281 insertions(+), 4 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261110-pm-runtime-summary-8dd29a1383bc
>
> Best regards,
> --
> Joshua Crofts <crofts@kernel.org>

What is the vision for using these runtime PM stats once surfaced to
userspace? Runtime PM and suspend have disjoint portions, but I'm
curious if you see any non-obvious areas where these stats would be
insightful.

And is there a reason the stats need to be surfaced in both sysfs and debug=
fs?

Thanks!
Sam
