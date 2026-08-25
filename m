Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099742F6FD
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661941; cv=none; b=HXjvBr9vNmmNqED2a0t9IH44d4VT3aCu9ydolCabDDhnmvtL5oTb+t4Ack1tLR2/RtVMploaShk3kJvXtD0KVjXr+BqrLfI4Clb0fFP+RduQQXe9sjrIHQZEa/oCZZhx/dv/NwfheZHssUGn0tm6eIlWJIcqegoHIOHUWOYXwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661941; c=relaxed/simple;
	bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfWh7WFJxvXGRvosG+Ai2aYmsk4VnMvkrToOCpVScx+g0tstt9GJaheKYqeJFAQc/mcJLx6rDutjuakeXwXUZwjMszqgA1q1Vj5LcXbeu1LqY1ruIgLm0etgkUmkTjnwKUUY9hBh91NVzHGnGEsoG3ou2I1EWDCz3aQAvrOzwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+xQESJT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+xQESJT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1f1f5631f8so48570766b.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661939; x=1788266739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
        b=F+xQESJTaKqQ0wI5cw/Z1zA6sAFomIylwMaVgm/71UXdaPaON3jZSSuzKDIYoa7gF1
         NMqgJhHtvTDk+zIiuMYpxYXpOWP5u7eiELCZLsvH90xt0KdnTt/hYZCJnqR6vHLizyds
         UZLZ0jKx106kmzYPmvR1AgonCQhGOuVDCzStWsqqnTO+FqnkU86KNGdbyDQDcySt1Riy
         jxF/0LO9tyCqF++ndraDzeOz8pl7FopiC87N9AaVsO5oiFvefeg+M90u8HEqYkl5M0DQ
         GNHoXM9F79h5mK48M4in8WPjizpURDXIc3xDUHf6A+xgoZZeI/dL3W7Sdm+dQa0VxLCY
         mgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661939; x=1788266739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/tKJYcvU4NXXk+0M0kR7FOdArxlDjY1WmX2yzsU5wU=;
        b=UjZDTfuJFQbkERdOkYRQbcQmzjgh/s2N7rXnlBI+vctvFDHONu1e0kYd8XcXCYBLJY
         UhBWzSMEmQ5L3rOw/NQTHznPhxP3+zTL3PbqBIxkqnf6WqLn+/hRUPEmNeXiwfawViWC
         9jsAzv+AyGlqGpbCUHPoNHWU3ZBD8cJcqsK1KWdPmWVJI4JkYLk27tjOZpf9LjflYNna
         7gaL5Gn1QWT9O/bHFaFUAKKdunUA75ZabIMqWNbsiP+qyKIQ7NNvrmUUskfQv7FILtyU
         hpl7V1Rc63WbInc4g3+SUkPajc1G64kYC22LKtWihAuDI6+sqsGbqB5Qk6D6oloBiTTa
         r8GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX8gXCNWl7R+cBz+HGdjC34aNj0Ao3aaqvJtTei6YiuzGaI57aIp+hoHfCYIbRDg2ayqHuthbZ1Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nY6ttWjIL8TlKeOqsHrrj7bo2efrHMTRhsierK4fsh7JRIvRXS
	91yShm9k6MV7NvSFvaosWqLIYcBWRtjLxqTzdokq3Un1JCck8GDnxROF
X-Gm-Gg: AR+sD135OUp1c+v6EoTD/dk5EHfgrmoYd7aBxp86vfPfLegsL3JQ+EBh17LI31KR6Qe
	OcdjoQUGCjkFnfdx9AEFVaEcJF1ZRNhUmZk1YJyTb5d9R7BNzX0moHRc2qroWCXBtvFyVmiZ4bo
	6KhKmEgngaDpehp+XFV4W/mhLx0hIZQKsE84jVVkfCjS0uN7T4c/DjYDMYHqzftrzu6bMkQfgUw
	Iz0+KNebkVp76LNzw1iirDwh2VIfqkCIAhSfI3GneWzYbqvp7Wdd+xLUAA9+0Xqpc28opv+Vo2I
	k4u9guiCUMqHuGoOX6cXd0QXGFnJ3zgLdFImNLLedRJCHBz623y7zZyZOplG+AoCSkKuZi3KEWq
	jWZi6zfz54rrlZhfiPlf4uA+dzQjvlUBDcHkpAiTnncn+wCGWLegTmNubBkgEecP3KqRPFtN9yY
	oSmPN/SU4uq2C9rrTMhUMbEvrHxvMsUZcv7aBqRmOA1cXhsUGyl36V0FPvHo8Ui7EyEp3MwVz+e
	GfM8G78YazlLLxRxrRprab0oya1MkY6pTSbohtLTbYGGGk=
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id a640c23a62f3a-c2469f96e84mr1943665966b.0.1787661938300;
        Tue, 25 Aug 2026 05:45:38 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs. [178.223.53.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249673d43bsm1646329666b.47.2026.08.25.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:45:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/13] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Tue, 25 Aug 2026 14:45:05 +0200
Message-ID: <20260825124509.11657-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com> <7d47bbef8b629eb287fdfa3e8d6c62b95de6b61d.1787568944.git.gahing@gahingwoo.com> <CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My mail client wrapped the tag comment in the previous mail, which
would truncate the disclosure when the trailer is collected. Here it
is again, on one line:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, differential base, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
