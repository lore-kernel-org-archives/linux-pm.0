Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388905;
	b=MBa6sSShIBAvlb2Hjo07oRg8h9ix8y2TKwb+u6MwvfwdcvicxvwkLVXjDLxky/kNJ33g
	 vERb2D1CAqHvc4OHSERsGpsX015mGVjw//jw/Nx58pRaNlm6tCVHSb2SzfwEtfoRFohW+
	 C9V3qjG/ApXcJk+dYlAW7T3FbaJiUwJOdatyBz0bIXIhNINwJvr74yFnixIkqU37CtKGX
	 svuPUxcUlM+o/fY7GQcxmsh+JUe2sktSwXil8hK0pMDcCUHe5z5mH1CU4+LXoc6amPf5b
	 Vsy5GFbP/Mj71PeBPSJhlJBPo/wodL+advCg8FGLf8o3TZCHx732uRYCq6eQ9DYc1RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388905;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=aIRoXJDNqceBdKb+7VcVD0zb/w7fLipsmo4NYHpzbxA=;
	b=t4Xy4hNxaZpuqJHGXO9CdOOQZDl73SzKegFgLuZ+4uEqu0lT2JnWF2oeVRzfyXqD0t9O
	 WOXKBulaZO4GwZkzWyF32PSNy7+ajcRE/P01YXi2Cc9PXuZmWTArrc/55KybRGbLVRct0
	 sCGakm0Q9PpICmJHOjK5LZAtDBTIw0UQLLX61is66bV9wKism2sybGtaBAjyVwiTupVw6
	 v7CZ59WrVu+9+Huj/3bLd/MMQJgedtM6p9rd8UVAjAM+FSRuM2iUiNVfm0jGxQK0OztxL
	 fb3AilClrjoC19+4Sq0OBqZ7iUk0eVQw2M5wFnpBOUVo2+DzQecKOyFJEuGzHIKLcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XWTLav8F;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE5606A31C;
	Wed, 11 Nov 2026 09:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XWTLav8F
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jPdLD3NM8z6WXB;
	Wed, 11 Nov 2026 10:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794388868;
	bh=7pdryiipz0j+iu+O9ky1Ab58BI7pr16Jg8JAQ1379Q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWTLav8FutN8UmK2+geCara6gCpeOBKuxKRLarsz+LQRfOqFzJZGxLbsxjCyBjKFV
	 79TZOgSYui3duOF5Tl+ZWdqkkc1mRS9sfzmEUBmE0S89Euk4XpxFbl5S5qfsyXTgum
	 QiU+NOA/4fiEbr2YDoBTPRcAGUcbZgrBkETGX8KRfsXldHZZUWmKmpR/stS5ownhQm
	 3I93C5pYi+zjLFnPJUHPvByXCqdHKW9BfClnGuoKaOnqWrFwqjSKBDVH2g/f/dCc8N
	 bVJqXSFMPWOcAVVnAuk4MqJ8wTM/zeyLdzcIQV5dUF69mbSSi+hHa5lKBySTfhLErD
	 SA+Kws+c2L+wA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jPdLD2fj0z52NB;
	Wed, 11 Nov 2026 10:21:08 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jPdLB5SqLz8svk;
	Wed, 11 Nov 2026 10:21:06 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DDE155F9C5;
	Wed, 11 Nov 2026 10:20:57 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c92bf044-3a04-4fd7-b1a3-e7ea89cf1e4c@leemhuis.info>
Date: Wed, 11 Nov 2026 10:20:57 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/idle: Stop the tick when no cpuidle driver is
 available
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org,
 linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
 <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com>
 <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
 <0b9b9c3d-8ba0-4329-9504-b9d33c627649@arm.com>
 <097f4855-eca1-414a-932c-107d9eee5088@broadcom.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <097f4855-eca1-414a-932c-107d9eee5088@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179438885852.683699.2690732334273648782@mxe9fb.netcup.net>
X-NC-CID: XD/K3O4gQ183UQRoZIs2OH3cLb2x+hy0xzzYw5B1Oui9uqVdcTc=

On 11/6/26 00:59, Florian Fainelli wrote:
> On 7/28/26 09:37, Christian Loehle wrote:
>> Commit f4c31b07b136 ("sched: idle: Consolidate the handling of two
>> special cases") changed the no-cpuidle-driver path to use the previous
>> tick wakeup heuristic.
>>
>> Oracle reported a substantial sysbench regression on small OCI VM shapes
>> with no cpuidle driver available. Reverting the commit recovered the lost
>> performance.
>>
>> Restore the previous tick handling for the no-driver case while retaining
>> the heuristic for the single-state cpuidle case.
>>
>> Fixes: f4c31b07b136 ("sched: idle: Consolidate the handling of two
>> special cases")
> [...]
> 
> We also hit this issue after it got back ported into stable trees (5.15,
> 6.1, etc.) and this is seen during a network throughput test. 
FWIW, a fix for the above-mentioned commit recently hit mainline, so I
wonder if that might change anything:

96a494c9cfd8f4 ("sched/cputime: Don't account idle time twice after
dyntick-idle") [v7.4-rc1]
https://lore.kernel.org/all/20261005194010.168299-1-stian@itx.no/

Ciao, Thorsten
