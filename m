Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666503DDDA8
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403660; cv=none; b=aAUOlV+/hiA3gviOKrKE1vOUQX0R/kerCHBsKRU9Y6ioJBfhGuNCCKzawGqI+3WXQdhJx9rR0D/r2CXwpJ6FpD8vU5GQyFwRv0mYwGuaCoDE+WtEfI47ttSPYHYTCySj2q39xCR7deu9ukCwx0wxthgcKTiUb+/esAtZzZzjxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403660; c=relaxed/simple;
	bh=xROy1Y0XmFv89eTwsOqpRjwNw/zTYKT/R8hDR+t8O7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk68gai5VEesSuiAPxkvDGQ9QQjq2digE1OeY8M1BsTH4mXPE+sLSX3BQweLtUiwZouFRW8w/hH80PAWddsYA2GuQrSRXuWT4EYjh+0T9s4F6+KpCZf9MxTjVvlYCf8pX+KQmUn+WktURL4tUz++TE/ZpF3gZaEp+toE4mNckhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6deDcJs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6deDcJs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3637b90so155735e9.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403658; x=1783008458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RukUpK2hqIlqtjKrnPXSEkZXvAhn4lqBD25H3vkwCjM=;
        b=r6deDcJsYLfWofk8JN/2eBR17YYgl4MGW8dmQM9DOuxxCIs938K+uDudi9fVNRYsq6
         f5yAqARTs3IZ2jsYM9D8nJZv5rglcRHeDkPPz0nmaYmC5zuJYteEit5B35UrvMSMMO0z
         qcPdCmQGChLO6FGQwJ4F7a8Q5tQZDxo76vbjIVvr3IxQvlJ02ofRpTJE2EbjcnGiy0De
         RZV9TbvYd2TwNkSfwrOCY8EHPHor3wSoz6JlQHspUStxUX6V80kvM4FJp5ZXL0A3tqxr
         A79tHLgGBKoaZQs2bHbRRhJ12SHhAUa75YuzPRcIXADEw57QTBGiGOR+dqse5o9K/tJM
         FktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403658; x=1783008458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RukUpK2hqIlqtjKrnPXSEkZXvAhn4lqBD25H3vkwCjM=;
        b=ixSczVqWruBPCi60pitUlLZ/5OQ4CsSzxG289eTe9O2HJAEpqe4gPDikcdp2y4gKMk
         HJhIOrHSbriC/86/AzF0BFcLwfzx9lqli3XqI7CS70tyhllf5FmwUifwEvXBeUZcJZzN
         dp08TgoXYNNHEkqxgrNS7gKJL4kwAjO/RPNd7MEt+NaUNIt5N8GsZXaS6V9MwCpVhqRA
         8tZZhZ1Aj/fjHM7jjyARDZAXt7W4mkhq+Y7Y3Ql9obQzZXlZOrwNsjUjcsT2Awnh2uyh
         ZsGB5oGwEsyhdAbgi3GFy6xdpk0GDnL1u9h6rGeZk8IqxGVmmY7jMm0Vc0cU691pJo72
         924Q==
X-Gm-Message-State: AOJu0Yyi5rSQ5QwdK1KMaHlYCGy+S0AgN2GPQgjSAy+HrnhEixz3XkfG
	hOJ5MLQR9YBj8g+ZmkL8V6TCYh9KsG7x4OtpCreCyem9sP6oPToATpjG
X-Gm-Gg: AfdE7cl4iYPqIfOlDiAKV4GAFx3v7NRbVwVFyyHuZYpo1ovn23Se0gymD8JLw7rSj35
	6G/4huzP53ouoGP1q8fbzCLvwFULvS4Vd7F7zJPklI+OoENsnooyP2fMZe5nv6yJZNN7+4E81DU
	1jpTRXLTLKqyw6PPQv01CoScbwYApgZOxItxgeJKdaCxmtiSHQwt5G6bUfAwjnitZFpcbCqhP5u
	J3I2orBEGoB0ktm3EV+LlZWOjs8enMlGclGZbcrxNlGCrnhuFKOjYzoxZnAQB/m4edmNCsQtk17
	nrDumlKWH51BLzkE42N5u6/6WH87V9vwcTpkXskHIGYzUCnfJFpt5eLIK69SzT/gB8i/EeJ8uua
	6EZApCMUAFK3blC91/VC7bjpi7qTQ262oa3olmBIyd1m/ABl4urUpifEmNsxVCUQaItZqrG1f6r
	0P+n4Ojf3+to4C
X-Received: by 2002:a05:600c:8b53:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-49266864977mr45557685e9.14.1782403657634;
        Thu, 25 Jun 2026 09:07:37 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm12844515e9.7.2026.06.25.09.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:07:37 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 1/2] selftests: helpers: handle multi line in test_sysfs_prop_optional_list
Date: Thu, 25 Jun 2026 19:05:54 +0300
Message-ID: <20260625160556.54830-2-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625160556.54830-1-borissh1983@gmail.com>
References: <20260625160556.54830-1-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify test_sysfs_prop_optional_list to allow multi line parameters, in
order to comply with checkpatch output that limit line by 100 chars.

Allow use cases like:

test_sysfs_prop_optional_list \
        property_name "value1","value2","val3","very_long_option"\
        ,"extra_long_option" \
	,"even_more_data"

Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 tools/testing/selftests/power_supply/helpers.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/power_supply/helpers.sh b/tools/testing/selftests/power_supply/helpers.sh
index 1ec90d7c9108..ff1175aeed72 100644
--- a/tools/testing/selftests/power_supply/helpers.sh
+++ b/tools/testing/selftests/power_supply/helpers.sh
@@ -108,7 +108,7 @@ test_sysfs_prop_optional_range() {
 
 test_sysfs_prop_optional_list() {
 	PROP=$1
-	LIST=$2
+	shift
 
 	TEST_NAME="$DEVNAME".sysfs."$PROP"
 
@@ -118,9 +118,9 @@ test_sysfs_prop_optional_list() {
 	valid=0
 
 	OLDIFS=$IFS
-	IFS=","
-	for item in $LIST; do
-		if [ "$DATA" = "$item" ]; then
+	IFS=",$IFS"
+	for item in $*; do
+		if [ "$item" ] && [ "$DATA" = "$item" ]; then
 			valid=1
 			break
 		fi
-- 
2.47.3

