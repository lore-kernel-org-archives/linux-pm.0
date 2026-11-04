Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822018;
	b=Hbns25ErDd5zz+Mb0xBLMgai+h+6hYPVCfrG6bQkm+SnvRxYvSoGrMOZoNTvzzcFDapT
	 GYMPtKRJ5808sjTxdOYWHqC5D9pTo/D3GNKH6ZgaXErrN/5O1UaXIA1QeV5ylIRNB8JDl
	 mTb6/77L7avqm0Rjbz7Qo5BAbl1jdct9paIO2y/l9Z38rhRchwmo+BJ1CQ/i3MbOb5uq+
	 7vHKL2gw7xOhld8nRRuPZ6vZM883u6GhoTvhxBFuYP28aEGsZxLCR0svfegBLl7cnGdwp
	 9gQCfa1bqF/g86ryoLyPbtAO6178qlMhCJoQBvuhqRs/wxuRD5dlJoBodMoMTUkYhPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=YS6vE+zuJxU8J40dt5sS3MHZkBM8tQUiCGmNr3ta/56RVedTekJg6ufhgTdayPUzU4vL
	 OzDHVEULUF2CnLbXhcFSiI98Sfx1myhTkH0xRvk7xq5lP4u+jdYauwJSbaITyRktLI8Tp
	 tdDz/yA0Qe7ojJNT+eQiWQGQpqGteSBauQJGI1/Oh7FvaeAEApuKj8Irt6Jh/PRfTF4+4
	 /f+cai1LuWGb/mou3dTSS9lD1nQWcAam7VY/wYSpUDsZMK5XLyWUVHpeBnfpAUM4L5Nld
	 enHhHvyJ+JlIS306JXGolMR+9NXa1A0f/TIkSDX/cJlQD9/mxIHjYjjR0fKgvMKC0KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99560960A1
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB99560960A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-19305bcb72cso1062197c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=jt3ad/PXjsMqdNblXCcfAO1mgf/p0pqsLZa5xYQyQvR0Ik8kuaWiiPtqDMYp6wCF6p
         yI2/EVFCmQKYcHQezgeXtSdXm3i94oEMrlo8g/jwnK5UycOfTi+QRngs8TTPfz9HZR3t
         mYtugVxBKd7RdGL8bvnVTcccTzVcMapxceFj0a8cJo4RuZ8k0MkUhPft6OzWguvhmQHe
         AoCNFHsikhRz5xYMZZEKm7KoZJEMhkJ9vFhUZF5SxiUiLXWFjdi5jO6a4WL2HpSusFyk
         FOtQVZMM8XRnygc1+Pctgj4Vzp7qKWCQAnC9nEcHZpnx41wVoIT6gEbKrVvU3eaqwJr6
         jXxA==
X-Forwarded-Encrypted: i=1; AKwUvBz9aZfrVvmrz23VszWlOpOJ98QtGDMdME6c5pxkcRmIHknxWy5jbMEd2AYUmLqDhKFxAomgJEPJIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8eXgOInYPoRjEwWNjHRkcHib3I5mYwer5zc9uL/1raLjJBr3o8
	vypl9GiNW0d1XNOAGHLJh/TWn/iRkCc8fu7tLzQ7XzmrlwuVdNVjjNo=
X-Gm-Gg: AYBFou2conc8q4IEniDJDuwGMNPJ5BT0AoTS1OEGWWLiyc74t9V6GD3pl8zK+ic2stX
	lpQGcwu+TjOhGVoy4LS4JvM/GgfcDobnIYB4v6/Y34fT/PP0HaaRMkHxPbXN3jS3+S+HxfifUER
	+ltMVkQU/nwwSqwXkoc5dtyqstGoUGVh5yFcMSZmtOcfrxtxHUxeoHkeQxeWKtZLI7g0I27D12I
	JAu/qH9bpr9zXd0/PJK6z/LHxUsMUexvv6CyaCAorFe5scE9hFdptQkEvwbQJv0n+ysbyIA2AlN
	lTuiyGs4JpnouiIF854ewkwV6+QqvWIMOWJL565zm4fixEfDkBseWeDBcmzCbVMhWyZql8TFX0u
	2S4rXNTinO/vaP96eqbO9j5Z44hOy4AzhmKWl/a53gIT7b00cqktRUIDkNt2fYHwzdgGSGeavrK
	DTJvos/AHs59GHRhHU+r3BqWb6RXLP+MceWdIpDMMQP1jooJs9hLcIL0WrvRRB2G7WR0HFd2XxQ
	YmkSnoOwiCDTio9AFf9j0PeKuVLRG3oEbJnN9l93sj5Av6Si3/shqcdb9UKsby9QpbP8oNDkadX
	f8pq6tDec/bwX0h35DgaHxflDPG/dIRs06Mt41dcHOj2KKGp+bc7pjFkwXUE4/Yn
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
