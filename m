Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0540B11B
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565336; cv=none; b=E7rWLwe3e9ux5jDlTH+uO2WNlkew5MVmXJyGcOJGJMTQ4ZatIBkVD1XgyoA0i81/6nE9v8RX7owss31RlGfnuNOOdChwuLLrKWZrK1uGE3M80x2ap/+dydeAf6cclNNFqOIMSyJKayyM1N5WEdkoiaablCE+DNINykzLZ3QWmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565336; c=relaxed/simple;
	bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oot4QvJbTs/n7vv2RBQwGMxxNg9BejyMjwCG5egZAlIGIcTc0CPs83Ox/ZCyMHE84SEVAD4rhQc5fSyHFJ73PpTsJUOwq3Unt8e/sxhHedMV70zHOzgF/qPsBsBdyzB4zFohKQUcYWosx0OyLYGiIiHZhZhiMAySVbicKVSD5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SriF5u9c; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SriF5u9c"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fbb11aea4so456665e9.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565333; x=1790170133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
        b=SriF5u9c3M1yb4t2l0x9yA3RoFsu3Vst90q9fR5CzgrcSm+f6B4+JUdAqc7x96bTgL
         CyO8ie0Zzaizi1UAoyc7uo20C8BjH7pQS/5JkPsZdFmmtT77upCXbaWFeNGDWR3/B1jQ
         rMT6g9DXhRShNlVFmSOK6+TgqeMYJF+7dvaGDX57R/xL2Z009KCxCGyTtn57/0XKDN3g
         qbD3dulK479ejAT1VxqfFvLpmzb4EI8jnkFCKAmI207Zke2+/3NR1vR1I6+a9senxIHG
         jAotvyloepLXY2BOs+4qAW0EDVxRkGfYX9sL/GfcidJ1YcMN+sFw3p3JBj0apE3M+B2p
         ykZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565333; x=1790170133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqbeODdYQEEftgsPxXsYkF97yhYGAJosPirzjv//pFQ=;
        b=WZL/mognHGiRK29kAOPRL2mowCELeQIcHs1fHwfaMhygD6z4ibfYVWTxPFf8ubRI/q
         9P1fKkRlnTD2J9iDQ/ltSaPDwEdBtDVsrTRJcrJgA4GRtqv47xAANX96jOawbWLpjGZ7
         mxJIR5ShULQvJ6LznQ5XoRS8cCAvnTSNlLTKmWbKVUPJNz43mmSRlaW3gIIXaFSNob3P
         gl55GFht3Ot68Il0cguZP+X9cQQ3Lrl+PrTAjcRBkb27/5zWGoAP8IlCCcuZz07zXQTP
         u+kQq4bbk19+wzemH+Czk9pE5rUntMXHGn2JXDyRDkggM5wwM3DC+bfRcfoJeiAUZIGG
         l2Uw==
X-Forwarded-Encrypted: i=1; AKwUvBzGjDO3Jq2P3trEdqlcMC/NqoMX/M4rUuBDUE77m3lL8EoXh3tQeMS+PTNHd7RLvgL1fccW8IfmJg==@vger.kernel.org
X-Gm-Message-State: AFuF++njjtVm0wcQWa+9iw7SgpyaF1EbZxLZjbol1MVgAKKLT+97zv4g
	+sH+2oUYkRE5/ND2GyS4fOFthplQU4nHdIUu7MnV3QQBrI63yxwTzhtQ
X-Gm-Gg: AYBFou1Ff76/7uZogznbAh9JxLotNgCJXXhCdAYmK6zjFCZBS7cNq3KKy7pd3EtB662
	2PL+1T2c/I3jlEwQ+A8FrFYSdEe3cMoviDdLdV5qrHSW5FO3d3Q7Mk7icce7kqD42b1eEQT7HoA
	x2k+bD3l/Kb5DLm2edzferDImLeV5aluysGdo4OEwWadZex3m/IAD82/2bPqexB+KP2iRUSohUQ
	r1+LFlDGh263qaql//OFQZBn/skypyh4sS1DTqNKQ/+HE6qKbMGargD5NC0nEC/kCqnqdiXuJx/
	FEIq1AAP/5reuYnJqwDbYj2qy2A6+4ElZt+wcYr4KfAcWS62MekprQEWE+F6PDSOwfWTxJsEmZ+
	JlV7qfdPvBR69tkTOblVL5/nAHLM1xFiGL/vBlTmd5JxnPRk4Y63HuraENd3d9TpD9TuEV9d85w
	e9vw+Q6LUpsRYwXdK8ZC2ltV05+vwVX3bdWFVhRLe69X1mspJO3v7V/XeCBBKiuScdwDIUepDFh
	GF74IIsquSckQnuRHgqugMaKh0sc9272ghQy4Mkosp3bwI6CMpeercqpjblIzykMuKTlml46hxZ
	sMc=
X-Received: by 2002:a05:600c:4e89:b0:49e:745d:5768 with SMTP id 5b1f17b1804b1-49eac4112e9mr27160505e9.0.1789565332521;
        Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8E02001A623C292D45A2B3.dsl.pool.telekom.hu. [2001:4c4e:1b8e:200:1a62:3c29:2d45:a2b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847da0cdsm594135e9.2.2026.09.16.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:28:52 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Oded Gabbay <ogabbay@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Alexey Charkov <alchark@flipper.net>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Wed, 16 Sep 2026 15:28:24 +0200
Message-ID: <20260916132824.13527-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915104328.45901-4-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-4-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

Thanks for flagging the job_lock change in the cover. I re-ran the
same protocol today on v13 as posted, 2+3 and 2+3+4, three runs each,
same board, base and config as on 12 September (JOB_TIMEOUT_MS=2,
PROVE_LOCKING, DEBUG_ATOMIC_SLEEP): 73 induced resets with nothing
from the driver beyond the timeout message itself, no MMU faults, no
lockdep report or warning, and lockdep still armed at the end on both
kernels. Of the 126 inferences scored, 118 matched the CPU reference
within 1 on all 48 channels, and 8 missed on all 48 with the channels
the scorer prints reading 0x80; in the two runs traced with the
kprobe, those 5 results sit exactly where the 5 -ECANCELED completions
do.

The limits are those of my 12 September mail (all resets on core 0,
one client), plus one more: the model is a single 1x1 convolution,
which Mesa submits as a one-task job (one completion interrupt per
good inference), so hw_submit() never ran from the IRQ thread, which
the race you describe needs. So this shows the lock adds no lockdep
report or hang on this path, not that it closes the race. On that
basis the tag stands for the v13 form of 3/14, with the same comment:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

If 4/14 changes shape in v14, I will re-run that arm. The scripts and
the tallies were prepared with an LLM assistant; every number above
was counted from the raw files of each run (scorer output, kernel and
serial logs, kprobe trace), not from the scripts' summaries.

Regards,
Igor
