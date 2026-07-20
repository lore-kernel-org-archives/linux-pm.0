Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297433B42F1
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580639; cv=none; b=r+ujLm8v5KVH7UfFkFkdY8LuV8Jl7ptA97S94mgSJnvQSrZ3oqvwfZxdZJ9Wwo+OfdFbZZ4AFeI49UPe+ghXwmrGBGxdwlec1V3z0/fc4XG/lL237A9PoiEm6S/PBB9uj77wj52cmjNm5CyGmGhe2YY25wZO3BeCElOzp7jRIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580639; c=relaxed/simple;
	bh=HuS6lK18giduftd3GhQ8VAWnwu1OED/BgGxK4jrD/cA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CCKudQ7oq3W4Ym3ccWo5WPRhsFzzfHd7e5NJaNimUqN/JNaMph8iHt8xIEEDQXnh5PUSN/e7+9CXLGq8LQyeqroqRLMI4TSD8bYObZsZ4VTbWrPN0hvfwIZMLTbfxsCQZLtfB+3gqanlhTpAPpyOZsXKpcuvAybgqyi+V6Edc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=i3VmlVbt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="i3VmlVbt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so1557589a12.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1784580637; x=1785185437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQf1ykkwp4X1WlGIDlVib2gotBwxXCqOekLXfD0iRlA=;
        b=i3VmlVbtCtzECEGMoOQaSHKfuepyCh1KpmhqTBGGP+zP8WGgSouL/7M22c4pI0CYFP
         a0X0SCKTInU10Yd/h5qoiGdsHS4Y6DbYD8z/abl6ZGvB3JW2RUqfVgrPio2EG3qU6gfH
         KctwgQYlDHAOxXfLvPsUgX1zZXvF0EujVgJsiwKH5mN36H1JOsbuMuLdT4POF6/XRyXa
         sYBt7wq00tnQcRWaKbTqHUA6xsKIRzreA+m3VgyXSaAq02Akn7Odi0iI2yGUa0vAVbjH
         k6rq/Mj6zAXqc2S2OGj79NB0BMXw8Z3ZVVDuhckmB7Wi1a1cgg0JH/e4KW8lY2hfs/b/
         RmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784580637; x=1785185437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQf1ykkwp4X1WlGIDlVib2gotBwxXCqOekLXfD0iRlA=;
        b=fp4Htt6/cfMpUo3Cd0ghtt52vqFf7ryjNHIHN6O0x0aLSBDK6+Bd3qcvyHrL9lcBhv
         pwo/aYiffb0yRJOiien1CxNklKED3BjRkHqYW4HbIKndZJgu0zjU1WQ5ur3KcpjeQOYb
         RHfEgmZOSZOKpjfT3q1w+t+ZA1DQY1TB7wHAbwfhO1Tkv/RUTN1x5duTvyUn3mJfGu3f
         nw1kerq8VzXZTlKHwbDCc58ZjPbNG1EjjvMZ1jfKY06BB6Me5oGhgK5GvnRzi7nGXHB4
         O7+up3/7nwiq6FgYuuMpqoL6efkRLOWooiOIQ9tA3ajGBSVWjH9RVJfVB9DxEgLmfGRq
         Zb5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpVbWQnicSqBpFj5+SK1c/jw2eFojV5mQL8tYBaputwhGHpqPrfBZPAirrg0N563WTe/CLlOEcpGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1jR3RatBiiqCayzY7cKb9jnJ6j7csI6GrfYCYDpeTVbYw5SO
	wOmvcR9IKar2lUddppO1DjUBkL/L7tf7XRYeJ9ZJ0DY3PTjXKLeszRigJE52karZ1lA=
X-Gm-Gg: AfdE7cnDavKz56oGNugWj2mKgWeZX0bBFIojvRIApaJ/98DU4+Adxl7gK5O2vpXajYV
	62eFkgfqUglnzlxRL1jV3DxIyK1tGfyk/NjQGMjl5UDSNXUftDukevz/kLAIgGaK25EiA89Ty7H
	Jn2vgPfQF7V49KT740pmLx13b6zISTzQgt6g9+0RfXThvI7kn++um3pDOjMabxv0uzbNcXZ3iMJ
	FDA3kheJUB9eCqV7poTdcSkf+T6NXsFpL66UWbNkCh3YhmcoZslcNJFHxR/sphHCNmNTiH8cG36
	5R7GcLLCq3Rvh0e3Vbh03Pd9IkZ7nrFNf7/aV8uPh6Oq+GypoBNerYWVny+A2aY300rIry2XddY
	8QI4vYykfMPGabvp5dvmkVn4tXHTK1Xv2CMqe3BuBrtUbqdA9hu8AXl7WFnf+6nJ8PPTlbgdz7o
	E35EswCgMI4aIatQyOjbL7csgvk5hOowclc7CzYqo=
X-Received: by 2002:a05:6a21:6816:b0:3bf:bde7:d66f with SMTP id adf61e73a8af0-3c3ad79feddmr15904375637.2.1784580637535;
        Mon, 20 Jul 2026 13:50:37 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm38985724eec.28.2026.07.20.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:50:37 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	ytan089@ucr.edu,
	pgovind2@uci.edu
Subject: [PATCH v2] rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBuilder::to_table
Date: Mon, 20 Jul 2026 20:50:35 +0000
Message-Id: <4dcb9b9c756e413c13616e46cb27669bc5b32cf5.1784576749.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `TableBuilder::to_table` function adds `Hertz(c_ulong::MAX).as_khz()`
as the last frequency entry in the frequency table.
But the C API expects the last entry to have frequency set to
`CPUFREQ_TABLE_END` which is `~1u` as per include/linux/cpufreq.h.

Fix this by setting the last frequency entry to `CPUFREQ_TABLE_END`
instead of `Hertz(c_ulong::MAX).as_khz()`.

Fixes: 2207856ff0bc8d953d6e89bda70b8978c2de8bab ("rust: cpufreq: Add initial abstractions for cpufreq framework")
Reported-by: Dylan Zueck<dzueck@uci.edu>
Reported-by: Yuan Tan<ytan089@ucr.edu>
Assisted-by: ChatGPT:gpt-5.6-terra
Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>

Changes in v2:
 - Create `TableBuilder::push` method to add entries to the table
   without converting the frequency to kHz.
 - `TableBuilder::add` now internally uses `TableBuilder::push` to add
   entries to the table after converting the frequency to kHz.
 - Use the new `TableBuilder::push` method to add to the last table
   entry.
 - Link to v1: https://lore.kernel.org/rust-for-linux/cover.1783548374.git.pgovind2@uci.edu/T/#t
---
 rust/kernel/cpufreq.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 58ac04c650a1..f360eb9578f3 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -361,23 +361,28 @@ pub fn new() -> Self {
         }
     }
 
-    /// Adds a new entry to the table.
-    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result {
+    /// Adds a raw frequency-table entry.
+    fn push(&mut self, frequency: u32, flags: u32, driver_data: u32) -> Result {
         // Adds the new entry at the end of the vector.
         Ok(self.entries.push(
             bindings::cpufreq_frequency_table {
                 flags,
                 driver_data,
-                frequency: freq.as_khz() as u32,
+                frequency,
             },
             GFP_KERNEL,
         )?)
     }
 
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result {
+        self.push(freq.as_khz() as u32, flags, driver_data)
+    }
+
     /// Consumes the [`TableBuilder`] and returns [`TableBox`].
     pub fn to_table(mut self) -> Result<TableBox> {
         // Add last entry to the table.
-        self.add(Hertz(c_ulong::MAX), 0, 0)?;
+        self.push(bindings::CPUFREQ_TABLE_END as u32, 0, 0)?;
 
         TableBox::new(self.entries)
     }
-- 
2.34.1

