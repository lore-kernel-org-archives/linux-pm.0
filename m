Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB831E853;
	Thu,  9 Jul 2026 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563183; cv=none; b=Z51KUOTHjoZDgKkZG+O9lyt0oS3ohHPnkH0V2er1ZtyDzF7wtKMoSugEzExp9H+TmNFoHXPclbGCVbcYeXCE++67fQVBy5Zd2bAGPgeb/loEwlQYIbxq+fRqwDhJz/yg9WDEhEJTNT19CGMAYiRMmVxUtF73pf1KUCzmGYnirno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563183; c=relaxed/simple;
	bh=bL2Iyf5eOHNNA/EfrPGSMYDxREk+FrgkB58KU6UgGBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzJ+lKQ7s9gO8lMBQRycbZjKHjccVUWn9m1JX6C4sYMfchCy/neo1YQiVrVxXKhAc8qwWy51sFy4eyAcNr+20qyWDZKMagM275h0W4oSISUUcUunpCxT1nJvTXOm6X2w+dljpZy+mC6NqBZHUbmjx7Q0Ot46imErjyDvcOTZZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3fe583c7b3b11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:639ea853-0cf4-4b13-b477-2a48f1396c1e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:59b95266b14f250c4d2e980b10088039,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|123|850|865|898,TC:nil,Cont
	ent:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3fe583c7b3b11f1aa26b74ffac11d73-20260709
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1577074722; Thu, 09 Jul 2026 10:12:57 +0800
From: luoliang@kylinos.cn
To: Jonathan Corbet <corbet@lwn.net>
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex Shi <alexs@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/doc: Fix stale em_pd_energy() reference in sched-energy
Date: Thu,  9 Jul 2026 10:12:54 +0800
Message-Id: <20260709021254.2627347-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707085335.2942128-1-luoliang@kylinos.cn>
References: <20260707085335.2942128-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the EM and scheduler maintainers to the loop, since this patch
touches a name defined in the Energy Model framework and used by the
scheduler code.

No changes needed - just making sure the relevant subsystem people are
aware of this small doc fix. The referenced rename happened in:

  commit f0b5694791ce ("PM / EM: change name of em_pd_energy to em_cpu_energy")

Thanks.
