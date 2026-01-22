Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51332F759
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069344; cv=none; b=Jo5jafOZkvHSn/JtRTShgTfulu6UDmfgcDxec6XuQFjwBHvaIA5O9RXdyl2J8pZFXfjRJs7JGjB5TFCcplLduHcKRA4+qQCZjAwTtKb1+RAidHRq9k4UlTx95Az1IMt4NZdrscroQwRdEsYKkMbe8gF3B+SidE4NwZLdNRLQJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069344; c=relaxed/simple;
	bh=QSjDQKP7w5Jubw1+zZUNbarj9SplWG8N7yqqj8fv5CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mkv7fP1yM5tGRKph6ewqrVypY0x/ussxc4wz3UK6VzeudQx8IrTxe5TJvRvbt+4kShGTRTWIEBlD27XBfFjW12kLQrdp+3L5vAYhRWhImZYpoj+Za7knAvFiVU6uDT6ynQOIm4NWJuREppG65LI01xoEQ3UmJ87SEUw35c4eO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769069328-086e2306f732360001-MQbzy6
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx1.zhaoxin.com with ESMTP id L9AYUwFFloStUew8 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 22 Jan 2026 16:08:48 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 22 Jan
 2026 16:08:48 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Thu, 22 Jan 2026 16:08:48 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from [10.32.64.8] (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 22 Jan
 2026 15:41:32 +0800
Message-ID: <3cdd4df7-7511-4164-b5de-0f9b17420cda@zhaoxin.com>
Date: Thu, 22 Jan 2026 15:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
To: Viresh Kumar <viresh.kumar@linaro.org>
X-ASG-Orig-Subj: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LindaChai@zhaoxin.com>
References: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
 <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
 <345044bb-15e8-48d3-bc03-d5f327aeb3ae@zhaoxin.com>
 <qlcwa27dujkhxdyeminfzc3435xdz6z7bc627hd4fukr5qbhiw@anrsyspxw4mz>
 <c138c3dc-14ab-4daa-bbed-3cbe5d7c33e4@zhaoxin.com>
 <5saz7opvq3bslycn53ebhtkmhhzmqos6x4it5v3bgayss6nmin@vbel3msho2sy>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <5saz7opvq3bslycn53ebhtkmhhzmqos6x4it5v3bgayss6nmin@vbel3msho2sy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/22/2026 4:08:47 PM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1769069328
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 540
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153399
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2026/1/22 13:26, Viresh Kumar wrote:
> 
> 
> 
> On 22-01-26, 10:13, Tony W Wang-oc wrote:
>> The driver for Zhaoxin using this patch still needs further verification on
>> actual platforms; it cannot yet be submitted to the mainline. However, we
>> have already verified that this patch itself has no issues with Zhaoxin's
>> driver.
> 
> Upstream features are only allowed if we have an upstream user of the
> same. Can't take this without a user.
> 

Okay, thank you for your explanation.

Sincerely
TonyWWang-oc
