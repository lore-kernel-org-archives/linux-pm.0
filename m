Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5C37267A;
	Thu, 25 Jun 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420489; cv=none; b=UqMUKMF7JL9UpY0G9yP+/KlItNYp52VVZBXTfxURhpoiRhjtODOZb/oPwDbKUpJKHfzS66fjBKYkwxuHJE9knNYoLf+0TEhxv6e7oe13ffgFREz7ERJerIeR5BvSLE/Lou8puCfmj3UfIbTkNtzjhKv7CQWaI7To7Gw0Rto0CmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420489; c=relaxed/simple;
	bh=W5cwB5VuK6ZUPVros4aaXIMycAXDpY9OT9u88OjXCjQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BS//mZWxCtmxh/dXxDfvd+xNa9pS6ckWdrAoTvOT+TDuo3wpRXwxMi63zKhvAKgooCIixVk3zcDpBSvJ/+kPDoLUtreC0iS0q3O2LBfshsD4wujAfeZ/i7aERj5gS9lMuEoRxSsQiS1inuzU/W3snmOKGebsIlwmVFgHjOLl9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=ingo.haenlein@gmx.de header.b=Ipbo+7F3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=ingo.haenlein@gmx.de header.b="Ipbo+7F3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782420477; x=1783025277; i=ingo.haenlein@gmx.de;
	bh=W5cwB5VuK6ZUPVros4aaXIMycAXDpY9OT9u88OjXCjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ipbo+7F3jaUWAQHR5eyyrSy+S9xq3362ioX1IAmBP0nXX+POr+MKMgmfOrTXSVwj
	 IHemDBnD3ndcIdwkGeX7ZAcnYmgGJbc7OkU2U7Nm3X/h8ISmDCRhyTcmDS4iCcEbz
	 ziY4iO5nCXK9pMDRHTEs33eh3QuL1qBXJvY5qHHwU1tF4rVUceDay9FQ2gfcyCdQr
	 sZoIAbqc4735GrFwRAyLS/geJ6hEGmvhIuaX4VAUEqxhR1R7hjp+P5i6zmzCEQ3C4
	 M5MONokmJ8Kr1C3QJeP8nYYlg0bHuQBTaRCcexRT77gxwQsBDTWdN7B54HazjG5uv
	 bCMNqcdWC26fYZScFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1waO0q1l1N-003aex; Thu, 25
 Jun 2026 22:47:57 +0200
Message-ID: <56a48231-5f1b-4697-a732-bdbddd38a96b@gmx.de>
Date: Thu, 25 Jun 2026 22:47:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: chengordon326@gmail.com
Cc: Shyam-sundar.S-k@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 mario.limonciello@amd.com, mathias.nyman@intel.com,
 platform-driver-x86@vger.kernel.org
References: <18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi>
Subject: Re: USB-audio isochronous Missed Service Errors on AMD Zen5 client
 (Fire Range) -- Data Fabric idle C-state? No OS-level knob found
Content-Language: en-US
From: Ingo Haenlein <ingo.haenlein@gmx.de>
In-Reply-To: <18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:llMqjXq8i+FGfcD1Tfr1fqg5oUgExy6buB+dRO59J4HOPhs02ak
 yHST+Kvei0e+ny57uqaUbD4RKQXM75PQLcg+WneOo5XUYnSypJBTAzWF0hTIQJ+KVnzzghq
 1JKkgzxKa3SBb6DnW/L7tT+ry9XxTYDyS7GmJJoG6vHaYiiLH3zcmRrKqpZ1PX8VOmS1mWO
 5dIqx4qo7zRUqy0qo3inQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+N/n5Qm1Ry0=;r2siSBnbrAzjBspX5/swwt+Pe+p
 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

Hi Gordon,

I am reporting a related data point from an AMD Strix Halo system
(HP ZBook Ultra G1a, Ryzen AI MAX+ PRO 395, xHCI [1022:158b] on Bus 007).

Michal Pecio pointed me to your thread from my linux-usb report:
https://lore.kernel.org/linux-usb/48aadb68-b4d1-4dd6-82ca-76d0846b4ae1@gmx.de/

Same error class: COMP_MISSED_SERVICE_ERROR / -EXDEV on isochronous USB
audio endpoints, sporadic bursts during continuous full-duplex streaming,
no DMA error. Same LTC/LTR constellation: HCCPARAMS1 = 0x0118ffc5
(LTC=1), but DevCap2: LTR- on both the xHCI function (c5:00.4) and the
upstream internal GPP bridge (00:08.3).

One divergence from your Fire Range result:

stress-ng --stream does not suppress the issue on Strix Halo, neither
with 1 nor with 32 workers. Under full --stream load, amdgpu_top shows
GFX_MCLK staying at 1000 MHz -- which is the hardware ceiling on this
platform (LPDDR5 400-1000 MHz, per amdgpu_top header). Fire Range
reaches 2800 MHz under --stream, which appears to be what keeps the DF
out of the problematic idle state. On Strix Halo that lever does not
exist: --stream cannot push MCLK beyond 1000 MHz, so the DF can
apparently still reach the idle state that causes ISO ring loss.

SOCCLK on Strix Halo shows only an average (~650-666 MHz) via
amdgpu_top; Cur. reads N/A MHz -- no current-state visibility from the
OS, unlike what you can read on Fire Range.

So on Strix Halo: same error class, same LTC/LTR contradiction, but
the --stream workaround is structurally ineffective due to the lower
MCLK ceiling. Your questions to AMD (DF idle / ISO DMA interaction,
OS-accessible knob) apply here as well.

Do you have any update from AMD on the questions you raised -- in
particular whether Set LTV reaches the DF via sideband, and whether
there is an OS-accessible knob to hold the fabric active during ISO
streaming?

Regards,
Ingo

