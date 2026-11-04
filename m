Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806053;
	b=RZ8wRUqruUOX5MJNC8QjYNotLmQRrocpjxZ8u7ty7PJTLFCs7NB6/dHaC2Nw+OUeHRmV
	 JgTx2bkSiA5QV5ZVA+NP/ycEtB3MLLnvirYDEIojd/BwrAKD5pNttlfSMXUrl8yC3DcGO
	 hUgIn3qeOzSSdRzYNMyVID1RVqh2zgZnA/3zBDxtA+LhP8WiY9QSaWL103/vKZLLwjhMq
	 gE/4CwVihK1+URUgi3wSyEzWz0OMCaJvq7UEhLqO84BZ6Op1kG4SchltXpfAq0khwk5Gz
	 qZnJQ76SYdwSdJwoRHcU6rtSDJe6FG7NSeIFWGCOMQg8DAVTidljd5S2nKM317aSSGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
	b=l+jJEBqp//42dLcZ4ech+VXFsihZJmzkb3S6w2gbGSy0UTh/mkWfZtWKsPuVifrjK6hB
	 6ku+e1qPmPHiYtDuNOswCrWJrUD0KAp4Nnx5sJYPj5j3j/ETig18F5Ypk8VbPo0N5PMwg
	 VNg3QM5uU4duNeftRXY/LQuSYmDOD2VnWrxGHqG4q1mVNyAspIjTiFYKqvGW+1X0zLxMW
	 6V+En1hevi/kkAnZia3CLTJJwSSiKrlI+9lpm0ohqCdmgWVPOw4qaoT8gmXlFkZdvFckk
	 BZf6GGXfOt4f4c3vULvdrDnDKmgmbeM/Xpdn26mBAvGXwYhwId0qbsnHsa3Xkw1Y+Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJl5RNQ5;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3B606EEA7
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC3B606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJl5RNQ5
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1534103eec.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793806053; x=1794410853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
        b=LJl5RNQ5b7c50OYJXgxlRs5H5LxDFdVXsRyml3D92U9/ULyM26t4vzd5tEZjDmhgN5
         S9P9RQ/lPI5015Q+QPS8ja7fGIy7ddh53e4tPbW0ZXa+b6Xqj50UufcjriYjVxqgwgYZ
         ybQy95yMR4ZKpTLszyt+tjRYf0FsDqFXqDLqKj2nUN/lmiFQSrP0EfTaPf0TGrwURsg/
         qtFgzOyC+9pQ+GP3bcLTSKy2RogBXRzXCn7lOK7BrNmsuIUSmR8cmjeitjasVBLNSkWs
         y041Uuls6bE+MJII7SrNxXR7rStb/j9x7o+jlyQJqHkOBOj5+q5qvHsxvCQoJ5z/bdS/
         L1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806053; x=1794410853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
        b=ply0W4JIo5nxDOuhB9o+T/btzJz7XqzqW6comXN3QL/XXceQy4+3sMCyq52w31A//v
         0vciLOIVRo1PJSfkNZLyv5hcHCCnb+BGkzTE2XrUmlUDwKbPT+ll2zMqZHWlX4uWOZZC
         iyPNye8bXPVEZYbWLZKEl8gxHk1F6D+QYhp5Ejm9ueEmxw1Ny9eOiJR2T2PBcAYLqBYf
         5MgDpCS79//tIj3N857YiC2Z0YrGPKmt9wr/j1YYeruKofNYOQSyXwJ/YtZ4EwtP+064
         JX8PgZH5RL7mV+rMWqF66/gi68annW0YLt+c6QXWFhy20T9HJrjZBPn/sL3JhUiF7jb8
         UUKA==
X-Forwarded-Encrypted: i=1; AKwUvBy+j2eRVJxClBuNSA/iESepYJBmvgH/7HvL2R1mKqbYN+7olABhw8dTeL0O9Mr0nO/LKrgwWQv75A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pa/W+PS5/coHuqdR/7cTrOJ340fnkKFYVNDcNWG8UzNrOvc6T
	Bdr8aDHKHW72YAvr31jltYd2eWw6cSEf6/0nNb0JXK1U4XrSgPE6u48PfKzu2e4LbuXvEhz2gMD
	P50MaX8PEiCvNJDeyCNEuZw==
X-Received: from dyjm35.prod.google.com ([2002:a05:7300:16a3:b0:358:f250:485f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr13279550eec.12.1793806051988;
 Wed, 04 Nov 2026 07:27:31 -0800 (PST)
Date: Wed,  4 Nov 2026 23:27:30 +0800
In-Reply-To: <auo6bvjDtwAMKOid@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029040005.2100005-1-stanleyjhu@google.com> <auo6bvjDtwAMKOid@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104152730.3102376-1-stanleyjhu@google.com>
Subject: Re: [PATCH] PM: runtime: Update runtime_pm.rst for non-fatal resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 03, 2026 at 11:47:58AM -0800, Brian Norris wrote:
> Those need a close eye, as the code involved is a bit subtle. I tried to
> review, but I'm not really an expert in those subsystems. (I'm also not
> quite sure the second one was 100% a regression, vs further exposing an
> existing underlying problem.)

Agreed on the UFS clock-gating hold release. Keeping the hold until
resume succeeds was cleaner regardless of retry behavior. That fix has
been applied to 7.4/scsi-fixes. I have also sent v2 of the block-layer
q->pm_only fix.

> I think it would be better to flip the comparison to the other
> direction, and deemphasize power.runtime_error. For example:
>
>   "Unlike with the suspend callback, failures in the resume callback are
>   never considered fatal, [...]"

I have sent v2 using that comparison, without mentioning -EBUSY,
-EAGAIN, or power.runtime_error, and added Fixes for commit
aedc51762a0d covering the ->runtime_idle() paragraph.
