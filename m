Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413040;
	b=hn2iz6aZ0TZWGgNM8Ammm/8aU1VwONwyTJszX7DuhXi76wFpOkkcj7i3o4vdi/gqJH+5
	 JIkndXYpxuRLqcHN/ehlK5O0zCQG99ZifABOR8QpeZ+UZmJ9/X0mENuMdwINgY+WgVtlM
	 +ceTuYIqXXMzJ7asb3BSES0Gri6GxJ9S7QpMqMgHCApUKu7xQJgA1j8SOkSMYyRER7FPf
	 7lo1oCk1BSPSI1ABgx0GV8kmFP/GR3HjQUD6rb6tpcCl9sQrjbZ74YQj6GDsAObnSpJaK
	 BZ7Yn5VitTt9HrFv11QNdmbX0kICR1aJ1FNLZy3dPWloot28d0H3SNxcdHcmvO+pUBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sutOCZD75kbiRsKKEjghPb53P8SwRi13E5GUxqPAHYU=;
	b=cDRING5NVpR8a1I9+WlzPSt3kGQJKHoBcOcblhBdrYdVhI4wLLGrdH8y0W4JldXKVZgO
	 Maj3us62ym644DQyq3f9ociXBehvMh7HDy1SVEogqiq6JuChq4qvDfxcizx4FyTAHlG1Z
	 Smpi2ddtHwXeQLVLYXcfN3ZHivaaXcRY+HDD7ECHNi9r/H2wq4+xFTVYRQGHmxkYKIT2e
	 r26uAeFJPdB6AAgACT53kmqDYVfcqcxwc9vXeX++1pK67wVehV+2mGPCCtrQKJDSncPsX
	 3zbbgzXQRK1VLWc47t9GZYIzlRNknrlEgrMDEP71Cco4jHfpZLl26UZzpq3+OIwvPtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCbf1rQS;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7713606A326
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 16:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7713606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCbf1rQS
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso22906925e9.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794413038; x=1795017838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sutOCZD75kbiRsKKEjghPb53P8SwRi13E5GUxqPAHYU=;
        b=mCbf1rQS2oF4RkWH7BraYtw7Xxhp6FTbkfOx/M3oMoXxnoec9u/ENhX/ry2yXwpqjk
         D5LGE3rL50noszWbIeGu9h7J5s4wobKWVKKUBc2VxJq6wB3hgp0nVx+dew5BOHNbtStf
         PB1L/9odJkGhKS2hHqwTru+97MFLZOBlT3sX50424CXEdwFMsZ8OMwOSp42Jb0myvKgY
         L3imDxWvSwZxzzbKxJId3kFexdSymBE6+Z8VTiEDHJMXUqfujy3K4fzY6zDM+L8U+wv+
         T7Rmkl75Kn0bWFDFmJYYIogPEgzszxZU7YkyYc5eOJ+3hXE1HkJVRtLpS7lWbj5RQeJT
         PrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413038; x=1795017838;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sutOCZD75kbiRsKKEjghPb53P8SwRi13E5GUxqPAHYU=;
        b=Vlv45MzMJZsw89BmXA61So5hlzvYzQsIuyelqTUmd874esD2a3oIPGI+s2GGP1CiG9
         cavxT3SogSu2SiyDSdgyadJFIM2uVihi6tB53d5enbZBoo4d2CEfdrC11wHr9zRppNYI
         hZQtw+R+e9kk8faYftXED5cXX95K9R/2lwHRkE55E5JcJKlpKlZmBFB0S0lxxtc9C/zG
         Whe1TjIMdMRdtJrwQLqiCWgqFQ1qF+/Ou9T5iHgxliRB2WMZ/18PG+SDFTSsseF3ki65
         fKLDNOpfOwyhlJx+sWqyJbQdL8Fea9EIk8WDBC2t/+5eqztmkuwsvY6ZXS3eVZnNZNOr
         EZgA==
X-Forwarded-Encrypted: i=1; AL+hErG80Vpn/mVisAkn/5uI9P0SLqSAabqdEnjL+AcycwundhQ48J8phlbHAnfHFo47h8hXmcNT379h3A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XRen+zKwYBDrk574kiGvoEVhOl84TGrfmYUEh4AM6kYq4OCDr
	MU3qPAqYTs6+SY+GbvjZ8tZ70Wj3lRY/6EBq3ncM+JZePXIE+qgtvWR9
X-Gm-Gg: AYBFou0N1UeN7bw0KMBIUuziHM9Hd9Uer4VZ3wOGnClQH6mMuqVdGGk6fiCXPnY1Iqe
	24GnlTrdxnD8MNU0W1KepfWRw7i9Tf5jviX1LPWGwFLAgbQALCWkei0JvMXBEGhOp7aopYoBgRI
	wpRRNBDrgAH8q6/OzYPjsL9qwWo62cwLzAsrLrk1trRuKyrRU3HTcvitN/qPkTKt+ohmFxhvRvs
	6bfS3syJ38AJY4xyIpHbR7YdM+Ns3cS6bPmHRgNY9HZVTM4iZiWw7AX1bP+J7iqDPezK7C2iEjp
	15emiCxlNII5692S9NvNl1XtOg/5NQGbQdNt87VgVbtJBHghid+tRNU7CG6QnszawqWoBnagRdX
	QswP4V6OsACdGQJlnW2dyv4SiugG+gM5gsRneQiv9y3jXCv3f9oojRCewlm51Izg1IiH63/lG7r
	y1CCQX0yNNxK0E1P81Me0QFC2PlqH5rDafVLIzu6SKN9rH3UfUgd7EedHXDpg1ScE70FX+jWLcj
	nD9Z5tMVIdqjvFfx4AUO4MxXhuzM7N3Kjn6Z9pFU0qzxEZ6u8EgvE74TuWnmFHhQaPyKLHouzu+
	21x49OiHZruCSvRpqoxLBLwfbrJtP4CDNg+cjvM4G0C3AtPxsOM2AIg=
X-Received: by 2002:a05:600c:474f:b0:4a2:47:b79c with SMTP id 5b1f17b1804b1-4ba093abb32mr52472865e9.32.1794413038127;
        Wed, 11 Nov 2026 08:03:58 -0800 (PST)
Received: from fedora ([2.35.201.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm49553615e9.0.2026.11.11.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:03:56 -0800 (PST)
From: Francesco Nigro <nigro.fra@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mike Galbraith <efault@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms behind another task on the preferred CPU while allowed CPUs are idle
Date: Wed, 11 Nov 2026 17:03:33 +0100
Message-ID: <20261111160333.2206028-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <99366157-08b9-411f-b180-fa61bc5f5002@amd.com>
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com> <20261105081245.81773-1-nigro.fra@gmail.com> <99366157-08b9-411f-b180-fa61bc5f5002@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2026-11-05 at 14:04 +0530, K Prateek Nayak wrote:
> I'm having a hard time understanding why asym_active_balance() would
> trigger before worker 482 blocks

Sorry, that is my trimming: the "blocks" row is 482's context switch.
The raw events (perf script on the same recording):

    .654331 [6] 482          sched_stat_runtime  runtime=792910 [ns]
    .654334 [6] 482          sched_waking        comm=migration/7
    .654337 [6] 482          sched_switch        482 S ==> swapper/6
    .654338 [7] 481          sched_switch        481 R ==> migration/7
    .654341 [7] migration/7  sched_migrate_task  481 orig_cpu=7 dest_cpu=6
    .654345 [6] swapper/6    sched_switch        swapper/6 R ==> 481

Thanks,
Franz
