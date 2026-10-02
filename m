Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B89471244
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982446; cv=none; b=P7E9zSCAk4fjaxAI9vTrZQc+1HtafS8tQ3SX6zj8x6b2vMcPUBW96zVGyW36iF+mdTz8FuJVClh+2aPFZzEhQLnlT3151Ou7WZG1XMOBULF1NH6YWow/tvfKAc+MoeAFIZixWs8nxAK+DuS7fxkFZHRhRfYIgw8hSVD0reqdGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982446; c=relaxed/simple;
	bh=0Ye5uRCpFYj10aSEKZ4sOZLoRrzXYNiOUhVoX1kC7Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+E/Y+SuKG2RBr1EzRehDokE4ZRCAcx40B4jGxmq0a/gjUyab4YK0xASnnReJSHwiCOUkq5KKsCjf0okI/QznjLi0A4cCOacP33lCbOG+iKxUljG8SMHhEV8+9moMBU7eGhMdwiQ14K+MZ1sNgiIG1pJ3zANwErwf75k0RsWYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mClFcRsK; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mClFcRsK"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-34bb8b31647so174450eec.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982441; x=1791587241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Yhq5TvFbCkOnmQ0HyRqBja4cyWrB7IIoElNmyWi5U0=;
        b=mClFcRsKNyiTE/6xvZYFvQZa5uS8eNuLvzYRqYie7sBUycYyhEl3XSWpSDqaQUg5NZ
         TPjjVhCkD9yZ7QoMHqufTkqk9eDdyU4rsTxLT9/z8LnNHUz+Q642wqlSMcvUxEmFthyH
         6doEHrMqeynv70LU34kDxuJdfJ/ZO4uiNNONE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982441; x=1791587241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Yhq5TvFbCkOnmQ0HyRqBja4cyWrB7IIoElNmyWi5U0=;
        b=fI+eE3iA8dsDlXOHw4DfBq+AbuRBstVuXIuOrz4dsw023C07wTAQ2SGVqGusUxOPm4
         xpF0ml9m5JQB1wXP4C33rUJlaVkHFm984llipJ0pcAaN/FIJEJfmUjrVkqeVxS/a+JaR
         4682RmlwipHiL5TKDGFUfzFyu3DogPzClxt1NUDPkR2TG37tAB3mk1506++zMyiuz97W
         LgLdpHXi+LNTYNdYLc0FtbTXtEkzKY/r+NgjadSqaB+kQT8hKwwnShrMqIOUBy/E+8wN
         U0m/OCK7cRhqFMSKKj0Npd0lMag1im/t5sUPZf8RRXC5o0jRP+e1LUMuisuFGxlABx9V
         kI1w==
X-Gm-Message-State: AFq9FYJwIKhEATzQh8m2bCJiYJsJaowULRrXVeHGXzt7B7acz9xWrYTu
	De+1Ev3tSQPRND9UTL52M3MqlI/lP+3Za6+5Up9juBdFR0G9iRQU5vJxvrKp6fHG3w==
X-Gm-Gg: AYBFou07D26k0GidSOZOMpwJtKjwGthpiR2c5Epv3x99gLUOaFA23PlY4JLjgp7PBtp
	WOFub2q4IVNvi0BxMqIeUbHdn2EOSFihIjaOBZVWAWckD51oa0WGg9AZ4VmW/j6ZfBxdqRVY2yw
	wu5CWl77RVsPtghZyKGncm+yP8YOLxnlrMwRDW3w8qmB3S32uSNSOnsxJLVu21SYHXiNU61HJ8w
	IpQOVcIQuUsDXPM4YPq7G3xMeFOUfJPEgnZKKZdM5vPjLNJHuFaQEuoNt1ZZcMvH4oVdrZzqPFW
	uZ2bTs91hqti7yCO8o3waFnSF753jFIgfyHOf5jIyTb67j/rvCZxtyfRzAfZp9wqQSY/ldwvLsg
	4Id57PYxnlNBxYpniClFae/VxhlMTYd4OMx8PPsAO6Nja7/5U6SNxHqmMvS9ZZT9DATyWn1x1MI
	YGo9dt6B1S44XucI1uSbCkyqTm3r6lnhMlfKT+I6c4OC2XWYxqPLFmXdHplclk0hA/dfCInaPe1
	vRvBf9w/dmEz8b1wj/YRCPcDL80F31rFW2ZVg==
X-Received: by 2002:a05:7301:5f18:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-35111552a86mr1003826eec.40.1790982441123;
        Fri, 02 Oct 2026 16:07:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-351143b577bsm702253eec.15.2026.10.02.16.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:20 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/5] PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)
Date: Fri,  2 Oct 2026 16:03:05 -0700
Message-ID: <20261002160309.1.If69ddc515c2e9fd4338441e87688b9d690d2ef36@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261002230714.507921-1-briannorris@chromium.org>
References: <20261002230714.507921-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be5755f023e7 ("PM: runtime: Only queue an idle check for
RPM-linked suppliers") was incomplete. There are two other cases where
we perform idle checks on non-DL_FLAG_PM_RUNTIME suppliers -- in
pm_runtime_set_suspended(), and in cases were we failed to resume
suppliers.

Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Noticed while touching this function in subsequent work.

 drivers/base/power/runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 655c0b8af095..e70726b499e7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -343,6 +343,9 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held()) {
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
+			continue;
+
 		pm_runtime_release_supplier(link);
 		if (try_to_suspend)
 			pm_request_idle(link->supplier);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

