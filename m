Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324633;
	b=IsRDD01NS9jE05iZ0zS4I0VvnL9nJFRoQrRfL+/AAf76N6X/lPEWiC9N9YxsLplAlRnE
	 n70hHGuYsR/krXy7/YS21tkKXv3M/VEh/RsrkVwzkkFCthhKsFuOpqcLk06gaXGOMzjVG
	 8VjgOrxUP9CPtMpFdFq028YRFb96Wwqokt98GZ08YK1htxITGvcdWfOHKCZZFgt1arwV6
	 ngywsvRKQVg1XJG8S3Y9BA9JmMzVlj+dNW9WpTdTIxD4sUAdv/Lxy4sG6f78Qj1xuw0NL
	 ts4Td/wAP6/IxeYxb0rUyzYeA8c5I9lfvcjbjjejom0z4C0o3kjlWqCv7SRBr+iOTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324633;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=q6j7RRXIm3PPuBUrMxz8I+oc41LV3z9cgI+plUln180=;
	b=wTu9jvfEzpAenFCHl+gEEmrOGApXTMRF/harzux+NsqciJZCOQAxk3A/UqXFUWNVFwB2
	 wMVTnnCHd7ZeR+rq+oRCLwMVsq2lTJPg1llRDINzeB2JgvUD+ECD82yS+ED/5OAMApvtj
	 j/tDFnMZNXR15fIWO4DluLa6hfFDuZhY40+Q3l/gwKtMwju5IUg/U0kfVl9R+Ni53zEyA
	 qNALYpNrJhRxq0mYDyw+DvTXtBt4P7JaNXssoTkXz82qMAe0A9EAet1WBr6fm2w6VidtZ
	 CCUAMqNke1EiyasQ786JNyNp/qF0CZfiJwaimdIRPeqPpZtEev6NjYkZ4dbxJMDUzzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=d2NVGOsw;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93143606A320;
	Tue, 10 Nov 2026 15:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93143606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=d2NVGOsw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=q6j7RRXIm3PPuBUrMxz8I+oc41LV3z9cgI+plUln180=; b=d2NVGOswqExJVgsx7Mx8b5c/OV
	V4LmcoLI4uvm119YWL/o0zhp+eXnaclMBzSjClvt8/FzADJpGnjjKmdRCoFgH0u9x4otlpm38utYD
	w+/P0O64IIGDyVqF5aqZ3SuGeO3YVtIPytzA7UnUGLbts/E4CJDOzkgQ+7pteRHSOG8QGlHoqHMTm
	FQredGbMpxvagtHQ/ht2eIU8cAInovdH0Yhdh7tISUQqww7zJXv+BLUuLY5MvAPF0o/KpokQ5XSt3
	TFck7S6C1ILRUWjxYRtdqEXe2fnqJxTKA+pXvomW9fdNY4qBVKahfHPN+CYZBSvBmERKS0Xj44CXS
	v8ucFKPQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQnnm-00CV8b-1a;
	Tue, 10 Nov 2026 15:30:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Nov 2026 07:26:47 -0800
Subject: [PATCH] thermal: intel: powerclamp: Do not log an error on
 unsupported CPUs
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-powerclamp_mwait_msg-v1-1-18c03fa17ebe@debian.org>
X-B4-Tracking: v=1; b=H4sIALs382oC/x3M4QqDIBQG0Fe5fL8T1EEtX2UMMbtrF2aJxgqid
 w86D3AOVC7CFY4OFP5LlWWGI9MQ4jfMEysZ4QhW29YYo1VeNi7xF1L2aQuy+lQn1T+GEHX3tLH
 r0RBy4Y/sd/t6n+cF048V92YAAAA=
X-Change-ID: 20261110-powerclamp_mwait_msg-93bac0782c79
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=leitao@debian.org;
 h=from:subject:message-id; bh=L3RQMfycbGJ3LubWzXCd6qPJp+uOzrF84Hrimw66cdY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8ziOndj3QrZuqb+Bv8bQkMyesuu8W8EIyXllH
 tITDxEvZo2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavM4jgAKCRA1o5Of/Hh3
 bZ2hD/9ChvyI9ROhCewzv34fROkkaHiIq4ebYZmQcrp4Wf0OI9jS7fMGI7wujXJVOnTTKaCruSF
 EuDFNGAjQBgzOgF9vWkaglXXI0QcfCE5c6DIzk/U2rEPZdh9dkgLkgWTrAxbdcs5LgyWjWfGciJ
 /uLshLIk3I+ocNPh8YTpTAIbBWkazW1QP9Crq1nZiDGLtzguG+U8qmHNVL8h8Un1Wy707F9Lkop
 uREWVaBU5G2Fy0EMHwxtH5ruZpNQJXyKwC3dnRCNMP3Gw/Esr6ddFsbMjrvRFUUSpbGzo6b7Qe/
 Di9zv10zJD7kaukJsy9Hk2S7DZsjYWpFpyEi+R6NMI6kthXi2GysbgfddVn1oTHGxYw+1WH5EEO
 2oR9tjJLj/1ePo8oIuezHRL7Drk2oZTa65GO4qGImlLZ9bfuhl3eMFYfBLduInjxt2oQDnp1CpS
 GHpc1BKTrI2ehuJQ35CQ5DVYKVZ4xLqjU1comwsye5Mm8T70xmhZWQxW4qJ4crbHl1ZNFRTYI7S
 kZ6AFDRmuxfG7oazupP5T2Bd5KPjbGOwT9ZR4R6LVAuSzgQXGhZh4z1FkG+yUJMmGYTVP10HEma
 zpzsXKKB4r+RB8NRo3BjAgW4Nph+CZZNVQtFH3uchhIY1PuOIaG0HZS87Zywgg6eexs86Usxvj3
 AlqEhycntIegXyw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

powerclamp_probe() returns -ENODEV unless x86_match_cpu() finds an
Intel CPU with MWAIT, and logs "CPU does not support MWAIT" at KERN_ERR
when it does not.

As a result, a kernel with CONFIG_INTEL_POWERCLAMP=y logs this error on
every boot on a non-Intel CPU.

  # grep -m1 vendor_id /proc/cpuinfo
  vendor_id	: AuthenticAMD
  # grep -m1 -o -w monitor /proc/cpuinfo
  monitor
  # dmesg -l err | grep intel_powerclamp:
  [    0.485728] intel_powerclamp: CPU does not support MWAIT

At KERN_ERR the line also gets past "quiet" and lands on the console,
and on kernel metrics.

Reduce it to debug, and also name both conditions in the message.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 1ffcb0a699e57d..82587dc8b0156f 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -695,7 +695,7 @@ static int __init powerclamp_probe(void)
 {
 
 	if (!x86_match_cpu(intel_powerclamp_ids)) {
-		pr_err("CPU does not support MWAIT\n");
+		pr_debug("CPU is not Intel or does not support MWAIT\n");
 		return -ENODEV;
 	}
 

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261110-powerclamp_mwait_msg-93bac0782c79

Best regards,
--  
Breno Leitao <leitao@debian.org>

