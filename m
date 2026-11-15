Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702608;
	b=CQyAtdu4DhWgLwc/TS+NEDUgVJ/EllE3odf37HDZcK1qWwETaeYV4eps6BH/J231cLS/
	 cpcHs4v7jbFS5URgo4f2PuCeTOhDKQ5u7wiX20F9T7EVE/oPIXm3d39sSil6iyae/cQhy
	 sRnFBmK8nMg17SCZzRDvVQOr44pyywjEs23Qs7005qPz0sZqL0SGFHK8f0nlsY14NT3Yr
	 fh/SXxKqRZLa1rfVeAegGsp7h0JJy1VRZwY0P0+ybyCkcoChrK5EXEaDfmAgJz770p4X0
	 ywHI/QMSYyeb9QvZqg1VBNK3DFxBBmK9Acpg0zhg9ZXbCXWApf8VWF096Ht1Q6xcIXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=9KJyISR2AtHnOeUtveLbWH9gz4mCekwR54L842JjBYg=;
	b=jRrlPIxfNKIZgAjHJIxbQfoQAh8lJd3/pB846lCzepQIIuQ+aqG563joJuy40xVZvIQA
	 iRISK2U1BMr3TZg64jvaVVhCuLaaxlw7FmOgoprtCSc6UOIwlFqdLFH+4PnH4QppY/5V6
	 vpPaG/RfhyHOHA9t80zRTFCMeoMWlTXPt+uVMxm86hQfCjvBfhOhUxMtR+SXSgleYn/Px
	 eai0s9l+qTC7l6IE3Nd90L0t2w4x/Rvod+TvXc8KevZXAVYET9Y12wGzOCCgOz/VvWuN5
	 mrAuSNIREkLi3Wtk0l2a6VxbrWPQMr5s3vnNmJ5ogf1/8k819yKOoqqb+keQ3Qh34LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kL8RpPZN;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A3606A32C
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 00:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E7A3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kL8RpPZN
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so2792189eec.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794702607; x=1795307407; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9KJyISR2AtHnOeUtveLbWH9gz4mCekwR54L842JjBYg=;
        b=kL8RpPZNrRt7KvqOE9g/3dldn91il5lvEMDZjyMBF9qQCep2bf24C+ytmdEI+kPOmB
         CkVxzme3ris/DDsxvsOtOW5vA35XIX3QsGAui1F2V7HnoUAnnNrmkWfMZwk5MO1wUtie
         BL7mjdw1MR1QD1LIFKDNQ+2jrFVaAE/+QVntHhYAJSzXSAjvdESZjPTFOUIh0/ydeHNI
         flYFddZ2OcHCapLnm7JfOgSPOS+F32FZ4rLD8uPkEctQsVTJdfUH0an77e9Vl0eexBZJ
         p7J9OAIW53t+jt4rWnD2bb7ddA9ZyhsZON46KN1bMbogj6Y+VCY0+Zzxp43q467l6HA7
         vIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702607; x=1795307407;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KJyISR2AtHnOeUtveLbWH9gz4mCekwR54L842JjBYg=;
        b=FNWvfL4H64HoF+vvx0FRrzouoKVGA03N6L5U7J2KpTz2OU5OUSTk7j1cD5UnfOS9j+
         h2DwcxJJ98GoxJRqP5+WG92h4SUHKS7/1mCWQy223/M6WanRrradvKDX/lQGh6T7FV3b
         IM/g9iYe8nYpVC6QSKYnKHqgEOmeAVFm1fBS1w8rtDlT/PrlCPcasShiMAN8Km8IVdVQ
         gcScJ8JeVqQjdzkI6ruZYBzsZfdCz+B8QpXe8XVFTWBiKXc4DRqNy9QYb0/jCH16UET0
         g5JDlyhqmiWpZ8Owpdfp2Ucn8w3Q8qH2h8XUQ8l72VeaRnrDSdUfp77slU0abLyJL243
         zcVQ==
X-Gm-Message-State: APuU4Z/EaCzQsdBOGNUH53IEcjVJrcovvh6j+OInYPaOA4Rs2xRHXTOj
	ZtDRCxSjSpDcMRiS3cAWSYJy8oBvg73iq8m3F5ERLCEHtjBjBl8R430jSB0NQXvnJ816db2BSQg
	QJgRXr68YBx8jbA==
X-Received: from dybmf33.prod.google.com ([2002:a05:7301:921:b0:369:e1b:2d71])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:da04:b0:369:f420:8679 with SMTP id 5a478bee46e88-37968b93b2bmr6800017eec.38.1794702606926;
 Sat, 14 Nov 2026 16:30:06 -0800 (PST)
Date: Sat, 14 Nov 2026 16:29:16 -0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261115002915.1849847-2-wusamuel@google.com>
Subject: [PATCH] workqueue: Skip non-freezable workqueues in freeze and thaw
From: Samuel Wu <wusamuel@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-pm@vger.kernel.org, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In wq_adjust_max_active(), non-freezable workqueues always keep
saved_max_active and saved_min_active, so updating them during freeze
and thaw is a no-op. However, both freeze and thaw acquire mutexes and
adjust max_active for every wq on the wq list, which is extra work and
could increase contention.

Skip workqueues without WQ_FREEZABLE in freeze and thaw.

On a v7.3 Pixel 9 device, this consistently reduces thaw_processes
latency during system suspend by 4-5% (~0.7ms).

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/workqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index edbb2aa9c950..902f84bcfd24 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7370,6 +7370,8 @@ void freeze_workqueues_begin(void)
 	workqueue_freezing = true;
 
 	list_for_each_entry(wq, &workqueues, list) {
+		if (!(wq->flags & WQ_FREEZABLE))
+			continue;
 		mutex_lock(&wq->mutex);
 		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
@@ -7446,6 +7448,8 @@ void thaw_workqueues(void)
 
 	/* restore max_active and repopulate worklist */
 	list_for_each_entry(wq, &workqueues, list) {
+		if (!(wq->flags & WQ_FREEZABLE))
+			continue;
 		mutex_lock(&wq->mutex);
 		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
-- 
2.56.0.679.gc527c65306-goog

