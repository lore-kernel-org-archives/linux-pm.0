Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D132C923
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702063; cv=none; b=I8Pq77y8lkdiC9+vCHDJ3lG3zMD5omeleeKvZjIH8IDrfHIZU1GwlMPuaOtWAvklRBya7xwqQMiJYbc+lU/nLzP98GM3OPbJ1trD2i5al0mD0SqbU81HjkVdxiybwJsW29zz0b0d6ls79YVkT0DYfzo8VKjZYJK/zxNTfyWrb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702063; c=relaxed/simple;
	bh=uH/E9kM6ANIRRx8ldFYBbMd0JyWKxtDcLX9zUO8KnuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP1MF4cquZbKdk5nF6u/Nm6g9Jp3OSw417Qdv/bxpJzL0wVRQNdIMaPDmTDvV8zDsxU9B8YHcyZC+cSnCcTpjyV+sXqNJHGHoeszWqjwPL+zaURo96bVbhCuBWfHTF5o/kobpL+VY/eWwpwcReeUVsPNmMhuUDinCoozRHLO8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPsu7CcP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPsu7CcP"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ab3b5fcso515641785a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 21:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770702061; x=1771306861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UsweLwyiRceTIoKAfsXCtIwJ4N/M6cF1VZ5rClDl5c=;
        b=UPsu7CcPOs6hKhcgHoCcKWeYn7P71yaRaTW+Am6RSFqS2N9+0ymjooxtGqZ7Qv5t4b
         Ea+DBCbd0rmPwzRAEKGb7NZ/xCG9uv+wSWR2n/3ODCGZVwrYzcgKKrd6VSlmgE4BDkbl
         lduHxi4MfqGaQ9HSMcyQ6QuxKUQWYgE8lEbMGOC+KRYsA5a1CtNOkiFy+gOaBpNtUWcD
         3A/Ojwr0smCxqmN8XVu3KDHf/omv7Lfv1IFL05uymmPWyvKEjtgZzGrZthGTFtei7O7Y
         pxfBf6nuYszReqhf98nrf21NQMgj5EX3HXAwSgL6DYGiW148qLfJSJBQe6VwgwI1gEWV
         POLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770702061; x=1771306861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UsweLwyiRceTIoKAfsXCtIwJ4N/M6cF1VZ5rClDl5c=;
        b=etN2RZ0YpHVE5PHd1NHkdAsDu45ZE+dtBA88pLvrg0NuSRU450H9lFdPJDSmnk1YNn
         YJFpLUhvEupwQsecJHtkn2Wl4QpzJZcuuBB49KSlM7yhe+ibOK+3WN4L1mu3I+6B7ihL
         HSZggDy64RMQzL1oGzXMwChWpa0MKr4A+FOAsfVcFGG4ZDXYcgId9Hln8hSeifN6e/W2
         8AIFURQJabxPEHeRXk7UbiqvjTiLu3OBbzKVL4mc4oYxCBLas8HaXy4RCijcpdQPm2Rq
         1WUksktCeqVVufc/vO9S1Vb43VJtMnDU/WdjTWtFZylkISrBAlU/sKC7Taw4H16J0H8y
         H7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWWGqRzPTHvnJj1Bw2P6M5FxDlQLzh++NMLe3ZoG9fU8PKhFjgeS5XtjzSgUhToz0KWxe2lbrA/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1pynsFnWdMppN6NUP+ViMWJc8E4CrEiqF6MoLE2h5WShos1L
	0KyIHz51I1Hsvs0InPpb93/kTgFJ3/0T76CkMDWko06Kx/7yYsnTDN0D
X-Gm-Gg: AZuq6aLLXI3K+QLRTm64q5AYxToOXOzwsodZiSwqLA1qMU6mV8G4BUHucM/AfKwbLzs
	tQvy/rCnLpHEuQAiWIkHvg79wkUrL1ZdOsimJkG/9eWIV4nFKL7kPQn3nbCyifY8nJEppJ3oj6C
	2460bQn3YGXPY9eMGjfXyIEAYMsIb0rO0XUkwhgo8Gm+QCh+dyNQvTuCDmcXmadVMwiI9HB3rWD
	1X1gv6qW6tX8acjZnFV1omY3Krli3CELixWeaAtRH7rQyVNlEBSXktmSXiN05fHH/jfl96sFUj+
	29gcFRmNZblAojDYOzX3xQ3ZJKDdzgNZPZj+s3b7f78I3opwmuRY7ZgQw5fuv/QSYVxLD3RIwJz
	68K/TnMZTa19DuY8gtTAQHkm66cuwIgIiQMxeI2OLiQ9cVtvDuONXaZz8LLm4BBtkt800pSyeZW
	4phNlMqDRbtkilz7bOet7Dxw+XDEid5UzAYIHWXBMYauFKiwnFBLCPgKM7Nx1BpDSZefx1d6IH4
	GRcQoGYjfTA
X-Received: by 2002:a05:620a:4708:b0:8c7:1952:789f with SMTP id af79cd13be357-8caf16e9e9emr1736522885a.71.1770702060868;
        Mon, 09 Feb 2026 21:41:00 -0800 (PST)
Received: from aford-System-Version.lan (c-68-46-10-116.hsd1.mn.comcast.net. [68.46.10.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9fbasm978632285a.39.2026.02.09.21.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:41:00 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	Adam Ford <aford173@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/5] drivers: clk: mediatek: Fix error finding regmap
Date: Mon,  9 Feb 2026 23:37:05 -0600
Message-ID: <20260210053708.17239-5-aford173@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210053708.17239-1-aford173@gmail.com>
References: <20260210053708.17239-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock driver for clk-mt8196-vdisp-ao doesn't use the same common clk
functions that other clocks use.  As such, this clock returns an error:

  Cannot find regmap for /soc: -ENOMEM
  clk-mt8196-vdisp-ao 3e800000.syscon: probe with driver clk-mt8196-vdisp-ao failed with error -12

Fix this by using the common clock calls.  With this patch, the following
new clocks properly enumerate:

  mm_v_disp_vdisp_ao_config
  mm_v_disp_dpc
  mm_v_smi_sub_somm0

Fixes: d4fb7e15a520 ("clk: mediatek: Add MT8196 disp-ao clock support")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
index fddb69d1c3eb..070c60f40b64 100644
--- a/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
+++ b/drivers/clk/mediatek/clk-mt8196-vdisp_ao.c
@@ -67,8 +67,8 @@ static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vdisp_ao);
 
 static struct platform_driver clk_mt8196_vdisp_ao_drv = {
-	.probe = mtk_clk_pdev_probe,
-	.remove = mtk_clk_pdev_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8196-vdisp-ao",
 		.of_match_table = of_match_clk_mt8196_vdisp_ao,
-- 
2.51.0

