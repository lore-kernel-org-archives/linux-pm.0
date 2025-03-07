Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1915746E;
	Fri,  7 Mar 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388550; cv=none; b=GpMU0e3c7Upg2AOvPVr052Aecds4UnbpOhTh4L/85yjBRr3PMcLEpcMXeltMZX48T7MfEzBT7moViw9v0LDyi7dO00456wqq1i96oPFvwGHYzWAFBGy42qhG7iYwTehkC9Y2g/RVKXxBzrnOU87uJG6K1abBpPcu2I4mJe1MDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388550; c=relaxed/simple;
	bh=bPdxq5dw0r7SCssU3p+3AoKnXzG7KvdtHOBTzSRerEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOoojj+tLRe0DwRjn4kPP+6smFdiMkbmKt0JR3pjy7QyBUVPF/rqnq/jMbBfvgwDmEB6PYMTGOI+hbXowSHlPayslYK0PI6/5ynVkfjjyDlVRk4eTbC5GI5zeHlM3+7jBYnYo2tg1al/8waMCCJn8p7oGxEps8uJ0HlHmOL1jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZWTCaJDh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZWTCaJDh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vxpDLTEEyz0keYanVvC6Z/jxCfyjOYhQQfpZLuC8fXk=; b=ZWTCaJDhjgo6ChBf
	hZ0XvGI0dOv+GUlYtAN7O2hzX0IHIznzQcy5WN6kf70nifTfqfmfgnAxV9PizM/OQVj60zrIo57Gv
	zIAXyNOGr9xRU5VejWNUVAL+CaxzJNccnFtSO6bOaPgwS+gy0dhlGUKTIeG3jIKK5N/O704qj0iNA
	+U7lA4Ae5mRMV+G8L2X0f2AknVhk5haL6X56NJhQr50N1w2WJIt13XkN8ax91E/5Aohb/x/qDtr+t
	9P3ZQVxmeLN3zs3oyzBCi98vexci/CrPD+jrQliYaVRGr9P2f2z+QXi+36dlybl0lQ3a1otYVTSr/
	wy/MO3TJUo2mRqIB9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqgi2-003XFb-1M;
	Fri, 07 Mar 2025 23:02:26 +0000
From: linux@treblig.org
To: sre@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] power: supply: set_charged deadcode
Date: Fri,  7 Mar 2025 23:02:22 +0000
Message-ID: <20250307230225.128775-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This series removes power_supply_set_battery_charged()
which hasn't been called for a while, and then goes to clean up
the set_charged() method which it was the only caller of.
  The only setter of it was the ds2760, which I'm not too sure
is used any more, but I've left the device in.

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  power: supply: core: Remove unused power_supply_set_battery_charged
  power: supply: ds2760: Remove unused ds2760_battery_set_charged
  power: supply: Remove unused set_charged method

 drivers/power/supply/ds2760_battery.c    | 49 ------------------------
 drivers/power/supply/power_supply_core.c | 13 -------
 include/linux/power_supply.h             |  2 -
 3 files changed, 64 deletions(-)

-- 
2.48.1

