Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA513921ED
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365836; cv=none; b=M3OtsGvvtf2EN9RCLcBZULUGiyZEjdkcs6c/1TD+Y4Up3MCa3TiYW2K8byfNktIF0PzInNA+zadlI+ws0IYgSAF+MYrtYsSYIVD2THfcBxKg2ro53n4byqKiNR3B8M6Bl6+H/x3WpMrWYwTx/DEGatC0nIpAwfm29bLFDlNh3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365836; c=relaxed/simple;
	bh=BzxBDY+RbekA7FiYpK54JLWfpwZkZSZLsmwzTf60Pro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqaic6GXZd/iyPZj6/ec1JzfWiQ8ewSOVCNAmzE6yx6raeLvdT6xUp4imfOMxyuZlL+8cQV0qvMwX4xJ7/Dxa1+88RWw5wA4hp2GX6ZxzkGfrIarKD8NqlXLgJ13O2lE8rv2EZgLq4hY9imvHH18uMQZUXPuRyw6PjpHxPHvJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FokZKGYN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FokZKGYN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777365832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lp+O1aEXV6LC2MJz4rOO8/Y3DHAti+ZfPdBZjKr/n0I=;
	b=FokZKGYNmsLuoM/nS7ILC2BF0kVROitBmJfS1P8u9LXS1EQCkaP6mCxngeg9lmCxAK94XM
	zp3z6xfzzK9kvLzKSHcBJA1PmqJg9S7NP9gi2O+2XNklF/XpzkYwqNmPFRooyfoVuJSJWI
	wCIKEVAsBIzw0SSw21OPbDTrfOLgqZ8=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: gregkh@linuxfoundation.orgsrinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	currojerez@riseup.net
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Tue, 28 Apr 2026 16:43:35 +0800
Message-Id: <20260428084335.27993-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

When two PnP devices map to the same physical port, the serial8250 driver
removes and re-registers the console structure for the same port.

During re-registration, the console structure still has CON_PRINTBUFFER set
from the initial registration, which causes console_init_seq() to set
console->seq to syslog_seq. This results in re-printing the entire
system log buffer, which may lead to RCU stall on slow serial consoles.

Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
log printing.

Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
V1->V2: Add Fixes tag
previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u

 drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb..01b14392d9f7 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
 	int ret;
+	bool was_removed = false;
 
 	if (up->port.uartclk == 0)
 		return -EINVAL;
@@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	if (uart->port.type == PORT_8250_CIR)
 		return -ENODEV;
 
-	if (uart->port.dev)
+	if (uart->port.dev) {
 		uart_remove_one_port(&serial8250_reg, &uart->port);
+		was_removed = true;
+	}
 
 	uart->port.ctrl_id	= up->port.ctrl_id;
 	uart->port.port_id	= up->port.port_id;
@@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 					&uart->capabilities);
 
 		serial8250_apply_quirks(uart);
+
+		if (was_removed && uart_console(&uart->port))
+			uart->port.cons->flags &= ~CON_PRINTBUFFER;
+
 		ret = uart_add_one_port(&serial8250_reg,
 					&uart->port);
 		if (ret)
-- 
2.36.1

