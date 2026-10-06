Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB173D4132
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328820; cv=none; b=e9ATzviqlzVZ98gi1fj8znKLg9aMZq0+NDwoOQsivNPP+3rBgybwS19b4Dg8bxZsev/UizyfofSzEXiK0Tx+jEQWv9esmiTigPF0DE2rxjkmMhVCMFLi3TK1gvlFQ30kSs+RfYNPeJvwUu8IKvWdjsM97QbMItR0GpnvP1sYiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328820; c=relaxed/simple;
	bh=sjuSJIbwK+9pC3HVLoTkORP6Bqh+nlExjwmlTCp9g3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWpfBQO8B8dSlDJnrTHr0bmaAzVUVZyvGU/dCT1NneXa5nWDXn4KoEvQMjP0TiVkWw4RyuOa8gR2igtWRb3liwI+B6f74dztvB9EVUjeAqze30oSdVWr20O65Ek/Elz/boqGgX3/RzZNxqkqXTIofAejSJXlSs5j0/iR3IcXls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D3J9qWW6; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D3J9qWW6"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-351348eb579so1464712eec.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328799; x=1791933599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PkD2yI0m8nq8ghTI9DLQE4m/ducagwKY3yX77vxrJc=;
        b=D3J9qWW6k+EMdpdUFWd+4UaHlG69QX5j64a0EX1YcFvTrpStVTCkmrY4Ui11aMHXU5
         oqOix2+E6SqQoZtIp0V7sBFw/FDJfBHiHcq2PpMVbphJxmT6AC36ftec5TH/xUv9gWil
         Eej9Z5HITI5GZiGU6AZp+Uq6m4MjuIyLmzQvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328799; x=1791933599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PkD2yI0m8nq8ghTI9DLQE4m/ducagwKY3yX77vxrJc=;
        b=Fax3MCGElucmp/z4M7AmwXp/Tgg3xhFp9/7jN0xvKc1Fl1TUopZfOPVRPGSJwy9xmx
         Anvc9xGM3d80JQZGZVwKTJuGi8EKnffsgiG6YAz08hUVyaOrgXcjYJa3pVrkeiaytaxw
         Gz98pWVmynnN6AN3L9v8jJBt+uykZQ7KRuaR4mLaN4utorJbOsqxyewmdWZUfRZX8U6v
         2o8p0lY7hhjxNfyPn+rihqNyaojrfiJ9uTFmQ/njfuveRZNKQA7BOGwVCaQRU3X22B/F
         nqUkKtT0X0/+9/BG/voQ0KzS3ugf9qGi20QD3DTB8poSLiE9pia1NllJ/NKg2MLISJCU
         DLlQ==
X-Gm-Message-State: AFq9FYJ52Uayv0dC6OjkeQ7rdjm5HMekPXBAnQSlkQN3kdLuXuoKKHdW
	Qp+fzr+I5SbI1jGvgpXtg/dyUFiUvQ/ZG9hT4FmX9FYDti3C1Ar8qHA7aC1hDqDHOQ==
X-Gm-Gg: AYBFou03ZfJ/dvft65uHyAeKR5MLx0Y2NhCly9TWJczhrLUtrYj00HbCXSIX/ewQcFW
	spk69IAopQwtb3SRezMQ1wCIL8qz9ax6VT/pw2MgZzyqNeeh9p7FleqW4nnEYbL3HYz824XW4mx
	cFVW+Lim/sojUofImvY2O+fGaPhAOkwJb9Fx/QXEFmTed5mXb8iR74FbP1NFut+HLDDJDe0NRlC
	edYO1aTvlq2gxQhBZuqABIz4JLe6aHcZZnYfl0piu9oOJ6Fx7YviATZEkrRPNF9JecFjpJHXYGO
	Rm9MYbge9Mkdfn/Ci11f60CpuLdTNFRwxlDC09z1fjpBo3xRJjj8evDBxbEsNxLTI9bdabQj1Tw
	+MPVlspPSWiBtgh0eAY4eMdCX3TYpNKxNwzzwwnbbk+vkLgsN8Baw44D2tVZBMSZ4YUsH+54w2Y
	WMljK/NJcIApE5pXLX4bjQH3ZTzkNL8QlyrV08Son04vEVc3tv+Cnap4BDvYlhEUyyjw35zpEOw
	qMGwiVWZ75NGJbu1j70PfFKpqrVx+is8ZdneQ==
X-Received: by 2002:a05:693c:839b:10b0:351:4708:9b61 with SMTP id 5a478bee46e88-35147089d49mr4409223eec.19.1791328799286;
        Tue, 06 Oct 2026 16:19:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515af511a5sm1977457eec.15.2026.10.06.16.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH 06/13] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
Date: Tue,  6 Oct 2026 16:13:34 -0700
Message-ID: <20261006161337.6.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing SPI setup due to pm_runtime_put_autosuspend() returning a
negative value is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update ti_qspi_setup() to simply discard the return value
of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/spi/spi-ti-qspi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 34b154922ff2..63b9098ec8a2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -158,11 +158,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = pm_runtime_put_autosuspend(qspi->dev);
-	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
-		return ret;
-	}
+	pm_runtime_put_autosuspend(qspi->dev);
 
 	return 0;
 }
-- 
2.56.0.360.g66cac248cb-goog

