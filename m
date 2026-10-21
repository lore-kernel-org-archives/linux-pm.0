Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586026;
	b=fYM1H9ndiB5Meir2+syMttLhn6YcP9SHUZLJKv78hQzWLSNgKZ5yj6hDEvGNgFnGXKqO
	 31GvluVJ1yXIXXUrmfKSAPZX5+tmrOJ6FWYZhtVdhKZCrl/Ic9oMuq4bz4Hl2HFxDLZIg
	 gtizA/MbAp4STekysvXHSOFwE6nzvmunfHWqIzNOQJOoYd7rFoQLhmWq1tyfKhn+a2q3l
	 pyru9N62mwEtxX6RZViqGVCvmWL6yxBLP2VO5R1Vy4LkQi93yTb3BVqLiCsUIWBcMJLOL
	 VuHJ3z5+/oSsKAnS+fElQFmdCXhrqFR17ZVG/W9tn4AbJ0Uodd1DcxSj79Hn1XfjtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586026;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=g4UAyOiHX3u+Z8VUXBuCR6x3De88Q+2oGF4gxxKpcrc=;
	b=FToDMyrKWfzmRdzYFDxO7aDgjB7E3JtyN9ZcgZd+mgbaAHJF7a7nXPZJAJ+a5kWAY6OL
	 oufnvnAy0H44DXBxBuTlsqJ6DxQNUZQ3hA/kIbWe7rIDNjGI9DNZ7riBIHldPoiygTepu
	 EQt2+PXd2BNiX0xAKEmRfD5zmHrqyPWIlb5NThjQgN+bRHad4PPT7eCtGX924ZI3OjLo6
	 ZR6rB9Bt/QnYIGPx1AuB7z/OxkeCOqELu0NdVQdLA8TO6ml+Hvf0R7RiUV7RaZCklr3lj
	 1clDrv58u6NMkECGfNcdHuvbfF3zZ0w3JgcGFTqPHohf5JuikpFO/Y54biPHsTnOOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CE606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 12:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-540537f959fso891533b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586025; x=1793190825;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4UAyOiHX3u+Z8VUXBuCR6x3De88Q+2oGF4gxxKpcrc=;
        b=GaBcZxQRs5cHkerAM/Zq00Vh1jyEAq3yVSoCZ7gc8md5hrWdsOQX2BKRT7pf1R2mO0
         WelEkGFsrvx3jPclQhDnHhgUMQ5UYIIncLza7uApyYbp8hkjAoD+0FtF+Fqx8EQct/qR
         S5UuRMvmP5RhXbZ0kL7NoxQ3i55QpinNbAlbfmkAFueTEs3nURfLQsEe+5C7NVE1IqWR
         xoJyK8ymckYYHPPV0G6e/VmaM/tTpNwQe3sI2VcXTLfAcfXXMTl8CqmRDScb2i8dpq4I
         2DGvN7P5l6YtMo11Fj24Do6r1izqZ9fldLH29EHQ2kwr3TTCU7ixRdZpxu9hoLagH9xr
         mu0g==
X-Forwarded-Encrypted: i=1; AKwUvBwvHmdCQQGP1WdvApWWxoQHll4iO+bKKYdQaSD+wIjZ4FC1A7Zebvy6kUkCzRcAap9MB5ekd0ZHhg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwhvOaIJ2FL2UV76LSW+4YhJPG5PD07QZ9vc2EjGk8odXnXhBl
	4De60YaDrFHyFjL+ZkdOWlr8OHbZCd/+MldvUWaz9q5rUw+XWSvJL0yRoU2oeM+RFl3OfujvKcb
	TdAxSDg/THYHJyrfo8Z3vU/yoPAMB68nCVQiiR2uSK2g1vE+eo6H9vKmLyy0=
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2507:b0:4c4:8ace:cce8 with SMTP id
 5614622812f47-55350396824mr1164508b6e.8.1792586025405; Wed, 21 Oct 2026
 05:33:45 -0700 (PDT)
Date: Wed, 21 Oct 2026 05:33:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad8b129.a384138e.1e340d.0002.GAE@google.com>
Subject: [syzbot] Monthly pm report (Oct 2026)
From: syzbot <syzbot+listc1584644ec31736acf97@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 13 have already been fixed.
There are also 6 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 93      Yes   WARNING: ODEBUG bug in trace_suspend_resume (2)
                  https://syzkaller.appspot.com/bug?extid=98850521518b962c5bab
<2> 5       No    BUG: scheduling while atomic in trace_suspend_resume
                  https://syzkaller.appspot.com/bug?extid=3ae5f6fdc78789d76c5d
<3> 112     Yes   KASAN: invalid-access Read in swsusp_save
                  https://syzkaller.appspot.com/bug?extid=461576769f21a04b4bc0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
