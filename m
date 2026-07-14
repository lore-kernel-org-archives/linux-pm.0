Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267753EDAD9
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013996; cv=none; b=NthUDhI4O/EW4oBlRTD2spP2l25bZNwBkwq9solVq5NnAyRPhNiQLaRq+2oXxDbw8td5OqS7/HEj3cbLpRtwsr0EB8cnlR7Mm5l2L8ObiJyvaLvygfS44Tvh6wZp6fwjXSOm3eiUo31Slwy4O9t0BMi8Hg8PhToaASoa08XMcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013996; c=relaxed/simple;
	bh=gqgxlL1wcIWRjiux7JiXsDXzrjtgh8gyXp/zU0l3m8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rckDrcSwAVMnCShsLW0EWeT1+TZ5EeUslGeItCmhwVTP+jKczdFoE/Y/z+ch0ORgfQkzgAHLC9Ao1TVGxGM8QQrpbCDu1Mzhi38WyBFFLsBJR1BYD53g5SZ/jtuu+n89gamAKS0XhykH4LnL5e2ygAOSe4SrV7X6n/c7DA4KWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faOnuevi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faOnuevi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384c94c9414so571075a91.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013994; x=1784618794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWrGC49VmtfhMBZgg//gtgGRJAMo+Z0lMImYE7VXdcY=;
        b=faOnueviJbhndehZnf4qH+wWVWlVvyP0JQVfjbHFQFWQhY2/HtnRtdKMsCg4mbIVvj
         a1pHXpQyqnNLdt3vEWa5EsSuPhGlq4LIy+ryawUEnNKlYGSpu2MW1pHhBsg4iX4KaIzA
         hwYGpzBE3bwB2vzDkyfSQXD/XabJ4F5dxsjLySPagn3umkSezGFUMuG+iQLUk6Oflye8
         kSCKUUzEbwC9+rAIbKo8Z5Grl8yo3yjY7SIiPNfQD9e2DuBYY8eAVld11mKfgC9MWiD4
         Yrv2VS7FV8lA1RORkZHc1LXesK7BfP9s7MIjMNZcpp7I/MOpjpbMwtZxL1GIebLqpfeA
         Mkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013994; x=1784618794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWrGC49VmtfhMBZgg//gtgGRJAMo+Z0lMImYE7VXdcY=;
        b=FXsPtzUfR3jRH4QrsIqIJl586jH+jd02oGmueOmhl77FyqgAcZb9duvLe+0y/43b88
         4JZ4LzpgUK1HHMaXhKRitcHBVURqfVTFx7lmhoPpEEpspdSVeWs+PBrNPYhwxGK0ncq6
         AqM9qndSK/16Lj0zK9S8wISwGs5jeaLEQzgWLFPuW6BpzB+FHsL6WQxhlgKMutspxlqa
         i8jsas6GRb8xEa2W3ONLs737dtUylghLBNOB0Qj2GL+v1MB64Zpi4f0Y44MgehDEd4qM
         rXyiUQ8QfB/1ht9BE4gg0Ka9k2o2qUgkr35pQU2ukSyIvmsyQusq5v8LKRe7Wk6j4EJ5
         XM7A==
X-Gm-Message-State: AOJu0YxuTEvFZQ8puTtoKr2uUQhKp8uSmUUDMNEZyQZTpp8CCI6x7h96
	jv1A+SVy252qYk0UdQ1Slea4KMhmXnQwAXtjv9xd84H77wRT2r3jG7bI
X-Gm-Gg: AfdE7cmJX/fqBjVGldxXgJ+l/6sfaC1bBGfYHdSkEOAtQJHcJ10b8MmBjZywcvNa6DJ
	MTVhKqFS7UERaCMWengM24enkjKTPIYapsGIN69urnaUwMLf2JJlkg8EbHUEZwGJ3znd/M8bpCo
	dyp7y408xND5re9CWZt4ketKKDTmmT8h33n1YUGVGKZsP6YxCNd9HuJO15N7MBFP3Pl8Ww29APX
	098/vyRKgpg8XOq/Lo7qBU6PddaG9yFdxaT+RkYzOnrZ6hmrejNUV8G3p+h4Enc7k8Qc5p8/2yw
	lLb/4jzqGD3IbjeKvKtDSgTQb38GJRuCScST29xFTOJsp/ERk9cxLYkBPdQEuEGRDg78dKvaD/y
	UfiPppnBDuN0g4/Fa92hpBkWNmgEVxy82jkzADdj3UoSHbALx5cCFHKMg30taFq47OOj8tGodCm
	hKZ+/QY+0cbekk07MAqdZ6rR0t7W3ZsCnBGVQBJCq/mH2TpvJnhF8=
X-Received: by 2002:a17:90b:4a0c:b0:37f:ec5e:12d9 with SMTP id 98e67ed59e1d1-38dc75f6500mr11902857a91.16.1784013994502;
        Tue, 14 Jul 2026 00:26:34 -0700 (PDT)
Received: from matthiaskim-HP-Z8-G4-Workstation.. ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172fd17asm1041271a91.12.2026.07.14.00.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:26:34 -0700 (PDT)
From: Haesung Kim <mattkim513@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matia.kim@lge.com,
	gunho.lee@lge.com
Subject: [PATCH] PM: hibernate: swap: defer linking the next map page
Date: Tue, 14 Jul 2026 16:26:27 +0900
Message-Id: <20260714072627.3165744-1-mattkim513@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay allocating and linking the next swap_map_page until another image
page actually needs to be recorded.

The previous code linked and wrote a new swap map page as soon as the
current one became full. When the image size was an exact multiple of
MAP_PAGE_ENTRIES, that left an empty final map page that existed only to
terminate the on-disk chain.

Instead, keep a full map page in memory and only allocate the next map page
when the next image page arrives. This preserves the resume chain while
avoiding an unnecessary swap slot allocation and write for the empty
swap map page.

Signed-off-by: Haesung Kim <mattkim513@gmail.com>
---
 kernel/power/swap.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c626e9dc3c1c..e5cffb399e3a 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -430,19 +430,22 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 
 	if (!handle->cur)
 		return -EINVAL;
-	offset = alloc_swapdev_block(root_swap);
-	error = write_page(buf, offset, hb);
-	if (error)
-		return error;
-	handle->cur->entries[handle->k++] = offset;
+
+	/*
+	 * If the current map page is full, allocate and link next one first.
+	 * Delaying this until here avoids writing an empty swap map page when
+	 * the image size is an exact MAP_PAGE_ENTRIES multiple.
+	 */
 	if (handle->k >= MAP_PAGE_ENTRIES) {
 		offset = alloc_swapdev_block(root_swap);
 		if (!offset)
 			return -ENOSPC;
+
 		handle->cur->next_swap = offset;
 		error = write_page(handle->cur, handle->cur_swap, hb);
 		if (error)
-			goto out;
+			return error;
+
 		clear_page(handle->cur);
 		handle->cur_swap = offset;
 		handle->k = 0;
@@ -450,7 +453,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 		if (hb && low_free_pages() <= handle->reqd_free_pages) {
 			error = hib_wait_io(hb);
 			if (error)
-				goto out;
+				return error;
 			/*
 			 * Recalculate the number of required free pages, to
 			 * make sure we never take more than half.
@@ -458,14 +461,21 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 			handle->reqd_free_pages = reqd_free_pages();
 		}
 	}
- out:
-	return error;
+
+	offset = alloc_swapdev_block(root_swap);
+	error = write_page(buf, offset, hb);
+	if (error)
+		return error;
+	handle->cur->entries[handle->k++] = offset;
+	return 0;
 }
 
 static int flush_swap_writer(struct swap_map_handle *handle)
 {
-	if (handle->cur && handle->cur_swap)
+	if (handle->cur && handle->cur_swap && handle->k)
 		return write_page(handle->cur, handle->cur_swap, NULL);
+	else if (handle->cur && handle->cur_swap)
+		return 0;
 	else
 		return -EINVAL;
 }
-- 
2.34.1

