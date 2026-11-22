Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795348536;
	b=W1m91+gpda7WCToQtUFSw/p2cOZt0OOdbSR9W7hmdciPe2RIcm62zfkuVqYgxJy8/zcm
	 Fxevk1fM4eOG9XvFJ3xqJ/NHRtjTjq8Kk/Zj+T6SvLdZd4EK/vTtvftNuexoAnTlaUheC
	 3O/ATthw4A+Sb1UYjGf7kMz3imsjkbMqqyOwk0Cq0azdqJStXeCJayndjmf38k8bRSfTF
	 75+FojXELtSk4GVYqkscNHaLMbuiJeRp0Xhz+mnYInt7kG9AMjTp10TfYWV9PT/xVuag9
	 p5WHYYs1w7AZxv6ibw6fLqoIonzhzQ/2jyypyZG3T51B7o4bzCdosuEzxIghBFabmhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348536;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=sfPsKfP+u3D1vjIbzuH85I1yOXI1ADrVod+fm0L2OAw=;
	b=gjh9/gmqFhuZTUSx1K6Wo/rAlYDbcI0Hb/0CBFZZdp+/c80SX/LDK0V0JXHvzGctIKDx
	 67O7ngTvLKMbt8xO1Dn8mDfWyvn8Dx6aPzW8mp7Te6KceCh9pFv+VUgJ44D3b3o+yfAQ8
	 3y001Xo5XcvXrWOZ8b6BnntJkv8D7yLSClvxflic/KVZ0z304c0svCCgHoWAUQfO6M0qm
	 JUJ7n5QKDQAOGrhpAiZLKgDz7IHe1KubDFbq5d2Cy9TuCh7mHJlNDGj9orJrvW67dET0I
	 7/C0qNVfzEmoVwI7Z7hPYWR6bNsx1VqVB2egNCSSN3d6EbH3gUKkFTRLfYGPo20PL5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI6ecUN5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A2606A33E;
	Sun, 22 Nov 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI6ecUN5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795348535;
	b=GeIHg1rwEIVD77k1s9gKIAlMChvnL4mKUHXwxXloFUYZc/kJDvLKZpJT+WQNGmVJZnC1
	 8Zle3mQz+I1u/PP2BLJ+zvLUIPjk12XOH5quNR6dhP2R+3CwBD1r7NXdftto42237AIYH
	 wZYtnUyzJEetbZ+/B0AvghCEdkVcKlI0vAuR69B+tjl9F8285FECo6Qb7wU+ZmUxlp7z1
	 3ecW4y5hAqKuSOexcL7aYdwzdTfEBG4fnnMpAfDqkCdh9+mHb7kcbbvJgAxtXu/BJ6gEj
	 Wa7o9Q/jhxsQsjY/6VKiDO5h/5qPta0FyL0RgUWBkzAhJ4USKKOfcvHPOCwNtvbLzlg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795348535;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=sfPsKfP+u3D1vjIbzuH85I1yOXI1ADrVod+fm0L2OAw=;
	b=QKaCl5E3rITjMsUEf+Vv5IS1RHZAY1MLaycAZ5ifsRz+GpmN0zYFKkbW9lN66Dvx81wW
	 ejFc/f0FQaRcKx8FIv1e9UWu9JsM2WVe7oAT4z579DsT1uob9Ye6BifiSaOhmO6HVh1PI
	 z6U2bUZQCtLKqxoIq9fBvktJn3txjdnL/KZoDWrtJEl/hYMr+HvAniq6og+gvlaZyIfbB
	 YSgXor6TGzH4JN1d3yZYY6xe2UfXW5VH7MUehqorKf4z/M7UMgt6oNPB47BMH5fp/9i7b
	 irnwGvMJXYL172T7EGKeoK6eV38Oalgokr239unzWz5fHybbVDofzMARNXM/Om5exeQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 442991F000D3;
	Sun, 22 Nov 2026 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795348535;
	bh=sfPsKfP+u3D1vjIbzuH85I1yOXI1ADrVod+fm0L2OAw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LI6ecUN5zm+YWMZc+UrPJR6RjeimvQQA6f2lQzWFDhIMvsG4RYH3c82YH3TDHSXq4
	 4JJOAl8kb/E382xN9dKGICM3bBnDfae35FPMEsX1iw2rDrKv2gSTms3SBbmZFK1lEX
	 C2XKDP4Kyys4Khnt3xwAmbqCSa73Bk3swhznyXygTI8o3Zugk6fvkB89Oh/zIxmQH6
	 X71zIH5BGuMCiAPtWdBImWyrzbSwW0ZvwmjmPnpTejYesQ1/YqEhRCojHjyrwfKyoD
	 qfCuxzVNn8ltue/i+qNHBG2uH6M/fksbSlqG1WNX2etr1MMHIIZ7te600KCX9DFcPa
	 RwerWhDx6gKtQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 945C44C01B;
	Sun, 22 Nov 2026 11:55:27 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Subject: [PATCH 0/3] cpufreq: Fix leaks on probe error paths in three
 drivers
Date: Sun, 22 Nov 2026 11:55:25 +0000
Message-Id: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAC3YAmsC/yXMQQ6CMBBG4auQWdukHQILr2JYlPJXRghCRwwJ4
 e4WXH6L93ZSJIHSvdgp4Ssq7ynD3QoKvZ+eMNJlE1uunWM2YV5jwmJG+EGN7VBFy62tfEm5mRO
 ibNfv0fyta/tC+JwTOo4fI8lzFXEAAAA=
X-Change-ID: 20261122-cpufreq-leaks-0de5f02b05a3
To: rafael@kernel.org, viresh.kumar@linaro.org, krzk@kernel.org, 
 peter.griffin@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795348526; l=860;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=oIQfnl7M3LakYVj9eUuZPGGQrd8JJ9WvL2rZCs+mAW4=;
 b=Dw3HZ/Htimtqz09/4oos98ULzG9c99ofSXnu/hME1AhOvccUerU9jFEpxi3CIn2JVWTA75bqT
 +EypHFn1RYfDIPBzP27XmefoIKFhYx2jgt98BPARvGWAB54nuCsZXfq
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

Three small fixes for resources that are not released when a cpufreq
driver fails to probe: the cpu clock in highbank, the three clocks in
kirkwood (also on unbind), and the regulators and register mappings in
s5pv210, and its reboot notifier, when cpufreq_register_driver() fails.

Found with a static analysis tool and checked by hand. Compile tested
on arm (W=1, multi_v5 for kirkwood); I don't have the hardware.

---
Suyuan Wang (3):
      cpufreq: highbank: Put cpu clock if clk notifier registration fails
      cpufreq: kirkwood: Put clocks on error and in remove
      cpufreq: s5pv210: Fix resource leaks on probe error paths

 drivers/cpufreq/highbank-cpufreq.c |  1 +
 drivers/cpufreq/kirkwood-cpufreq.c | 15 ++++++++++++---
 drivers/cpufreq/s5pv210-cpufreq.c  | 12 +++++++++---
 3 files changed, 22 insertions(+), 6 deletions(-)


