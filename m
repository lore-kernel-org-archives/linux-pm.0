Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594460;
	b=MMe33xfRPkx9D7AnbiDzMWWuBdgKp98SzMjtLZUKJkcg5IHhS6VAdiH6GGYUeWmdskmj
	 s/1o3HPMx/SrCVpHRUqnYs7eDPt8ZVwSRr8ImdO3lnARUs4x/eqR2Kzr4WCE0vkkIYKcE
	 gjserSx2FnCBP7DPy3zluapWooxhLMN7FoAzaupApXQZBJ5KGJQ+4PIC9eG+6XMX1VNT+
	 3TovRD4uEG/t4MWLkJQ9aoEaarSF3+OxFkpsiyW4OJ/IWOCERKn23Gb28imLQiu/lys66
	 TnEuzK0Z+eW1PEbIFTw51kAMNsHvvyba3oFii/ibS8FIlIfYz34Ik1Zql5ib0XSf7tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594460;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=4bWCmP/FJHVL3F/1yiWab+5A4qO8hsCmanhxl1oVKUU=;
	b=zkmOsWUfx/gxM6douF+mXD4tKt2c/ZnSRbRy6tbaJxSnqZR8a98xnzTxq/eow5Xm50R8
	 yEF8UIpEyEwS59dhaqJir/5R1kNaFBr1fNinwavQoEMeIDuVhwFZSN4sdHoidCekblPls
	 /8pALT5zw4EF8FlCORhnZ1FLG2Uu+WVLXXTVe6W8RXTt9BxWzuOu+1kPYTU7EcU5mchYk
	 5sY97QPWcjyOOvy8vlEPMxXCq+Q0MqgpEqJzUSi3RI14NvS6OahHM1PDbc7kMqrGH8Udw
	 AVBKnZCWslAmZESKGdzL0vy9myYAWN/nZuCvZg9F155YY2MZ5BfTPNgYpt9WWqJiSJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b="enaE/FKx";
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F8606A321;
	Wed, 25 Nov 2026 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=enaE/FKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	MIME-Version; bh=4bWCmP/FJHVL3F/1yiWab+5A4qO8hsCmanhxl1oVKUU=;
	b=enaE/FKxBDs4D75lgaF/0mfKHaft1H0ZjkBh8gJzwH6vTO+sq/GTr0gUVE0u1V
	tFJXHGj+d/YUyeiM9XVdlyu25z4tnQixp3X8hNn9xxyjuLJhyKUgrck1aO9FI12H
	ttt8Cd7PKRqQlrLhHrfjqO74tNSsDTblkImEwD1KnzTQg=
Received: from [127.0.1.1] (unknown [114.214.177.196])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXxSnWmAZrP3z2AA--.645S2;
	Wed, 25 Nov 2026 16:14:14 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: supply: qcom_battmgr: Apply the USB host
 current limit early
Date: Wed, 25 Nov 2026 16:14:14 +0800
Message-ID: <179559445400.3708856.10349476503948801160@mail.ustc.edu.cn>
In-Reply-To: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgBXxSnWmAZrP3z2AA--.645S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3ur4UZF18Ww4xGr1UGFg_yoW8CFWUpF
	Z5KasxKFs5J3WxZw1IyF4j9r1rAayfC343Cr9Yk3y7uw15Wr4vvFZ2qw4jkr13uwn3WryF
	y3yqqw4DWw4DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r-BtUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/

Hello Venkat,

Tested both patches on a second device, an SM8750 tablet (Lenovo Legion
Y700 Gen 4), kernel v7.4-rc3 plus be5e7367bceb ("Allow setting the USB
input current limit") plus your 1/2 and 2/2.  The kernel was started over
fastboot boot on the tablet itself; the probe script only reads power
supply attributes and writes input_current_limit.

The mechanism works here:

- write 900000 -> input_current_limit reads back 900000, rc = 0
- write 500000 -> reads back 500000, rc = 0
- no "unknown message" from qcom_battmgr in dmesg after the writes
- usb_type on this port reports SDP, so the filter in 2/2 lets the write
  through; without the filter the behaviour was the same
- the firmware default here is 100 mA, not the 500 mA you saw on the
  Motorola, so 1/2's replay is the interesting part for devices like this
  one.  I did not get a sample of that path itself (the limits above were
  written after the service was up).

One observation, offered as data, not as a request: on the PC port used
here the battery-side current_now did not follow the requested limit in
the expected direction (500 mA -> about +1.14 A, 900 mA -> about +0.77 A,
two rounds each, same boot).  That number is not trustworthy on this board
as a power measure - +1.14 A cannot come from a 500 mA port - so I am not
claiming the limit is ineffective, only that current_now is not a usable
oracle for it here.  If you have a way to observe the effect on the
Motorola that is less indirect, it would be worth putting in the cover.

Feel free to carry:

Tested-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>   # on 1/2 and 2/2

Tested against: be5e7367bceb (power-supply for-next) + this series, on
SM8750 / Lenovo Legion Y700 Gen 4, USB2 SDP port of a PC.

Disclosure: this test report was prepared with the help of an LLM coding
assistant; every command and every number above was run and read by the
author on the device.

Best regards,
Qianhui Xu

