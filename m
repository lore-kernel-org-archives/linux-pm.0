Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591127;
	b=M4wEgfILe2r812UYLDyXZJ/lh5hhKCk255HA8Rqiq8aW4Sk3QvuSaSvd1rWqxHkVW3JC
	 PU6UhmS8g7YUcMJsuKnBOG+BuB/rZo2sgM16ebzbLuuODPLOFYwSwt3S9txNYFjwF341N
	 SpR0yC7aYzG5WrWl1PaLgEkhw2xwaFpmJcK9kgKo2WWfvRYqeeRcU+neOUdWAWMWvpWUg
	 aXoCxOlviHYU+d73LjrlVXoJSSgsEkfsHXNZCURvDhO/vOOHF+FixMvMj1PDb4EZibRCa
	 GUn7hw6cWwCJ2fWOt/2wJFT+kmaPmSmzaZTuE/wAgtSZypiLDWCQkGCxmkQ4KG8LXbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
	b=V4F0mtmA3I5sWWGDn8JuWRYCtri9cikhXZLORlNexz2pSQVHEj4s6AY89GnWQ1VRJdQc
	 o3230EiEAT1TcE1rqvizP5rwO+LociVKbRLP9kZSOR+PPm9JjRNXHCssS/AJnCBXtHWtV
	 0nu8JnA0LcQ32BlgnIIn6BiPDiKMKHpeQNX5OFC8fWfQJurrBjub/lnyCGKQHZ2lOE77k
	 +RZn95iS6aig4HgeQif/+F2CPMGzbmR7/RCZNp9Tx6cR8WkwyzpmF7iJwBBMmPROrRA6y
	 qNjg29KE8MC0g0V5tJUzI8iR4rpNGDtMjY0IKYmdvTDmsMzEJs0GPuRVRu7r8socyAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBvJApti;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3297606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3297606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBvJApti
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7538422bso106474a91.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591126; x=1793195926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
        b=NBvJAptiWLVWyTnnDIdNkW7PRUv0hDRVi2HNyBXHSlHsNGSpubjArczgoe0F+uKrMf
         E+TJ8OztoOv9h/IJm4b/4EAZqNxBOBnIF1mGWTYmCQ3MQspieCzuaqEzKawhWldsa4zW
         sh4CjX9QwoDkE94aoj52vZjOOsw4bDwxE1LfzJ1IeB30CJ5J31mexy8lFtzvGsQzIyNW
         Tp2G9ygrE9dqZ9qaQKkLvuUwIkf+CAA55ssWS7p8jbdsSz/ttTzB6I8W5sG3IZcrcUxi
         I2LSW/P7P58yNoQxLATR0eC9kIUd2e/hMXwI+2/TRGKFMPDBeCwMH4BJ9Qm8dvri68Z3
         7ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591126; x=1793195926;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zg/LYuc5EVJgXpf2aLA4/NF2gq/+rC0L8/4lGLzGqE=;
        b=ej/gPknZ1tyRqlFJqUivY9fX7BqP7v8nt9sDr6EDf3cca19reQV6UCyJkzDERH4A0A
         r9kgs20uxARmMz97eGLeU4BoUI59rsK/n4RWjAlOQ7eU6mGwCMoVQdorlS/W7bBp66Ws
         AUpyloMBAOpiQEkA6ozKDafP/cx20EkqaFOl4gCP8bIrVUCtSw1hwuLO16kGdToqOjnu
         2TYivE7RigXNP9oe6q+FINbwOapKD0l6wLKNdFUwsE+U6DlG0Xxy1D+lksz+wmQ1mCYJ
         R8QUvPMubSQ8r1//xc9RW3Qj2s5TzlUDc90hTSNzSDGD8awgFtTGQq3GkxAndoKTlzrw
         kY8g==
X-Gm-Message-State: AFq9FYJNWe5+7Hjpt7iOpphQy2I5puqtQ/DXTTHD+1kQxrh/m+zKL9FM
	/3Wgfop4RVDRuHOm11nHtSdsRqQztnm1FCnoXPwrQagFz6z/90DQMhIO
X-Gm-Gg: AYBFou04vZ/Q0Gr04L7ogXaTy4gxvpkkKo9fDfzpS9xPFVNpd9Lutuc4cf9lAiJfM9F
	DrXWe1Kn5yVy57RmqEDcjVCWFaoEk65beJJi1C2pxpfdyU3kPNi/ZLinO+owget26weDW7l953L
	uHG1O353Mq5s7SX/h1IZ579T8RQPp6imL2scFpkdzssDRvr8d16YGW3ivhuxuAi0+avHJk8EzvK
	zDfuCCmhob59coTw0gOcp3xPMv4H1lAK5Vrezh8ovx1GwulDi3H4LF96N/gXp8hCjt7Bv1IAcpA
	ULQtYTy5CgOdv4ngQz1mfi0fw4p/cbtsiJi50IbtKr0SjxRT6gFAkYSTbXNV35sRSiXghk5vp0P
	SEYO9h9v9vR+/Kr9UW5X3W+qNMPCeHfPIDR2tDsp2kjno/UqnznuMPs3Zgji7NXeLPFGcWFiX4e
	9KPf+bZ+AsusMnoqsMCXrGobFJF8z5QFkCvNQjemFRcj8yi+kGOE1qAi+yH6Nw/juulDq/52Lti
	G3bCnkv45y7gI4JB+PYAghzjgLx3Sck6twqNuZLuAwXeb+PA5xc9PfZx1V4wkEiu0P9vFmDcgiK
	6ENxWzA=
X-Received: by 2002:a17:90b:5249:b0:3ac:e6a:1af5 with SMTP id 98e67ed59e1d1-3ad86de0976mr3286305a91.2.1792591126388;
        Wed, 21 Oct 2026 06:58:46 -0700 (PDT)
Received: from [192.168.31.234] ([183.193.19.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85f38df2sm2209811a91.2.2026.10.21.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:58:45 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] pmdomain: core: clear states after freeing them
Date: Wed, 21 Oct 2026 21:58:39 +0800
Message-ID: <179259111932.19580.13027750156272888992@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

genpd_free_data() frees the genpd power states through the ->free_states()
callback, but leaves genpd->states and genpd->state_count pointing at the
freed memory.

Providers that allocate the states themselves hand them over to genpd by
setting ->free_states().  When they fail after genpd has taken over, they
still run their own free helper, as psci_pd_init() and the RISC-V SBI idle
driver do:

    remove_pd:
            pm_genpd_remove(pd);  /* frees states via ->free_states() */
    ...
            dt_idle_pd_free(pd);  /* frees them again */

The second call dereferences the freed states array and frees it again,
causing a use-after-free and a double free.

Clear genpd->states and genpd->state_count once the states have been
freed, so that a later free helper becomes a no-op.

This issue was found by manual code inspection.

Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/pmdomain/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 052ec478dfcc..12db69f53aee 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2353,8 +2353,11 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 		ida_free(&genpd_ida, genpd->device_id);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
-	if (genpd->free_states)
+	if (genpd->free_states) {
 		genpd->free_states(genpd->states, genpd->state_count);
+		genpd->states = NULL;
+		genpd->state_count = 0;
+	}
 	kfree(genpd->gd);
 }
 
-- 
2.54.0.windows.1

