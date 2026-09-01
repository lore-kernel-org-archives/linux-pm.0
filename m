Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26649482D;
	Tue,  1 Sep 2026 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287428; cv=none; b=BpS017hMgshZsq5RWm20AwS5H9jfeRSYz+cRKf/dtmuTTxqJ3xLritn1Sh41iA8jwz+/sb3DEurSMwxhW5UMggxxXzfcbNXHMntLR43UHFK8J5DKJlgyOztF9DjRFY44ukqqBzaSfwiF3+n9NUha0PWCreGTdJBN60ARXtnhumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287428; c=relaxed/simple;
	bh=ITgKoadp4ftRl5QuXFcnuW544ZG53W+lRzBRCyPQn+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+AVhOgYi0j62uFAUJ/QifL/Dv8MmLMA5Z8XIUPVgOp8cFtQuYzuzIau0t94eBe3QbHQHO2aq7/lALkIUYviJ2s4LiHMekF6gTCpwwlZ8gdiqvhPScho914SDUwjUNq6DMbYYqnKSbWAPvObfwsdBs9SfpkxnR5CQsQ6cIgjtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NrC/vI9G; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NrC/vI9G"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94C9111D491;
	Tue, 01 Sep 2026 20:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788287416;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=h/fIn+2fqHmyz4MOK5QYTOBPnhXv0QSilGyJRb7Py7U=;
	b=NrC/vI9Gjy+foyqa2gllwWT7HQ3N/8MYhaN644F8GlWdgKbrV/5SVQj8MJZD3U4Ffqqe2d
	Cptcw/8PG80U1WVfMvN1fEksn0/Fhg2ecbxlIdC+3g/cznszEEO1OHJZyNFfsbbII1h+bg
	nj12qhcQmsi90MQ+GaT7b83oDDnQHFjCFvzjgqdZvhqgHUr845l+oY4TOfu0czQhulQoX3
	fJ3nQnNjOdicMBaoYaYxBtNhc5YACT3l1Mabp5oycICem8BhMcBAR/TJPLs9/msfbqrVGC
	Dtg9rvki/+izbL6OIMYEc5bA4slbVubPzACNPYyxwgSxCKCPTKoZxIUnPnJ43g==
Message-ID: <cad5d9ee-401d-456a-a27f-31038fbae939@nabladev.com>
Date: Tue, 1 Sep 2026 20:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: tmp102: Fix up TMP103 bindings
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901174847.97261-1-marex@nabladev.com>
 <0a4ed80d-a5c0-4b5b-b41d-76c37adb99bd@roeck-us.net>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <0a4ed80d-a5c0-4b5b-b41d-76c37adb99bd@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/1/26 8:17 PM, Guenter Roeck wrote:
> On Tue, Sep 01, 2026 at 07:47:54PM +0200, Marek Vasut wrote:
>> The TMP102 and TMP110 are backward compatible, therefore the valid
>> compatible strings are "ti,tmp110", "ti,tmp102" and "ti,tmp102" .
>>
>> The TMP103 is not backward compatible with TMP102, but it does share a
>> schema now, therefore the only valid compatible string for the TMP103
>> should be "ti,tmp103" .
>>
>> Make exactly those three compatible strings valid and everything else
>> rejected.
>>
>> Fixes: d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml")
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Applied (I'll squash it with d67ec24d3f07).
Thank you
