Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F873B0AE2;
	Wed, 29 Jul 2026 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309119; cv=none; b=XI/k1BYdPO2EZj62URteylsE8BS0WuQ9dboomcJRJidsBi9dlGo+IBt2++UlA+C1MwbbkLcP0ldEtuJ+5izNZMk/8xvc1cudpUVYcAIbtLuzGjk3MQECi45XlL9olUIo07NggFxDCQbErh4JiUQ4eszuGIU6EyqHnNVKlusqYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309119; c=relaxed/simple;
	bh=I5qTtsts4ePqKS+GLEYxvXdrZHtppnKWgD7Qi8HNo7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCjZE0fBEmozoGHE8f3M686WHqWeY+OnPcJYOsqeeRaEzHrWdoXI9E6B0pL5mRK0xBm9O49WTgmmtVf4a+wi02X0D6YBIhRu0jF3ZLxTSKXOPGHAGqmOrbtkDkK59rkd+v1AUoE4Ky3z3y6qQN2XoGITx8WRy6XN+ps9ysy4rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nrBPNhIX; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nrBPNhIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785309102;
	bh=5xOVCFXEtbG3EQktKJ1PgZ4txTWTZ/R+7K3pkeRkDpo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nrBPNhIX0vpn+LZWC5UysPHzoB/yhIPWty3v/7yAPGafJMg3JAj+uMHTqUDJp26/h
	 2B5fag2DRevTpsBKrVEsXnYMI6bivv5yCuPhS71Bbpq1QkJDDetr91lSCZKiw74Hnb
	 0FjZ2vTaeYEJLtBjEsKOFkCTGKHgd7naP4VBQR1A=
X-QQ-mid: zesmtpgz6t1785309091t976a8b4c
X-QQ-Originating-IP: OsBCyYmP33cesME96eJoZFMj5XpVPT7ejjN9Dl4ojTk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:11:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9183807335896332137
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com,
	rafael@kernel.org
Cc: gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu,
	tuhaowen@uniontech.com
Subject: [PATCH v4 0/4] PM: hibernate: defer UVC streaming restart after snapshot
Date: Wed, 29 Jul 2026 15:11:19 +0800
Message-Id: <cover.1785226280.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260723084633.GE648629@killaraus.ideasonboard.com>
References: <20260723084633.GE648629@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OX/+6nY/vs4T59CMVovMrH6q+ad51uCZxVHFg0y/+nqXbxewTWxzHlN4
	XkwOY/RPAzsyODCxWsUwzoR5hGu1ZnDqc3Q4zIdbl60i8ZVWRNdPNeCDbQEd7yjbnqNkhE0
	DIf7YVRIKjI6jZ0r47rFAwQrC+olkWcQxKGb3OJ9FGVGhZF55p/GRn8irLN6bNY7o49n9tV
	F6ouQU9Pt6HF/ryRjfjv+6KpJeqrhv7JO6hcgJ4yaRcxOm7MedQ9eNJARamGJOlZstV7EM0
	e/gEXcabDhFQE0iW5RzFfjF58uDk+AQQuotaLQNadwW/OPVi0Jg3D9W2o5v0bOimEfokBzh
	8HhFiWR0G/+ZJlf7xHtkpSppKP6eXkU/PiEA9VRZ852B3nknzyzwwD0tQEJYznYMz/OO8nG
	o4Fue+P8H+waJsggceMTU4nRGbp71hAdck5DHZr3JCliIA6aFazJzrTbbE9mFcZWEBwupM7
	VmGng3NmrPpDwCqNDrRy6UYEIVy+3ynaVio3f0spousz/WBIfSite9RPVTJ5z9NLUIZxCjy
	rGxIXjk3n44OaoWUGZsWQdOqAiuqroLEPrhRkQYFGcx+YeV/ozwBYIrbdjPpdsZgHBsA5XK
	AH7T8NkLqKsNmQDUzdfzOYbhZegxlD8ElzB4sUtp6XzxEQr6HfjancgBQPN4Op/0JAEBbKa
	C2JuWICJXi4QcT/knM8kyZeFUwYQ1vNAgSPsVfDl4JOzyZU9n0o9w5JUU2Alf008s8/g+2F
	mGEJ4nDmOnOPG527MUox6GEtud8+IWlLhPVjsEme6xfcP8ppc8GqtKS4d83IcQmTp0U1VFM
	ArwJ52miR4WKnucoKIQjXAkP/6EOK09TQFQ5yeOUs4os/3JpwoxHaTr3RyGthv72TIQzC2F
	NtLHXI+heYQhUwYjWZPPtZ9C+8h6fbROy1VJH0nEDNI8BR3i+/3dB+b7LaBL6ickR6FLmcu
	nN5jBlnZoDLESPBsedy0SaYsO1gqgcJxIxI0YZbE8HQD6fIY7HQH9KTqL5RR5yEkAeabiN1
	OW5PfnSMfzSXlvqldxyNlNOHTX3dQrNvUNVqcu3Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

During hibernation, after the memory snapshot has been created, the
kernel resumes devices with PMSG_THAW to write the hibernation image.
USB interface resume callbacks do not receive the PM message, so UVC
cannot distinguish that intermediate THAW resume from the later RESTORE
resume by using its local callback arguments.

This series keeps in_suspend consistent with the lifetime of snapshot
memory, exports pm_hibernation_snapshot_done(), adds a hibernation image
write failure notification, and uses both in uvcvideo to defer restarting
streaming during the THAW phase after snapshot creation.

Unlike v3, the UVC patch now handles the image write failure path.  The
driver records streams whose streaming restart was deferred.  If image
writeout fails, PM sends PM_HIBERNATION_IMAGE_WRITE_FAILED after
swsusp_write() returns and before userspace is thawed, and uvcvideo
restarts those deferred streams.  If the recovery restart fails, the
driver falls back to its existing streamoff error path so userspace is
not left waiting indefinitely.

Changes in v4:
- Add PM_HIBERNATION_IMAGE_WRITE_FAILED before userspace thaw on image
  write failure.
- Update uvcvideo to defer streaming restart instead of just skipping it.
- Recover deferred UVC streams on image write failure.
- Carry Rafael's Acked-by tags on the two PM patches from v3.

Haowen Tu (4):
  PM: hibernate: clear in_suspend before freeing the snapshot
  PM: hibernate: add pm_hibernation_snapshot_done() helper
  PM: hibernate: notify on image write failure
  media: uvcvideo: defer streaming restart after hibernation snapshot

 drivers/media/usb/uvc/uvc_driver.c | 56 +++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvc_video.c  | 19 +++++++++-
 drivers/media/usb/uvc/uvcvideo.h   |  2 ++
 include/linux/suspend.h            |  3 ++
 kernel/power/hibernate.c           | 27 +++++++++++---
 5 files changed, 101 insertions(+), 6 deletions(-)

-- 
2.20.1
