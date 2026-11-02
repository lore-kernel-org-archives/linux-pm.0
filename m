Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640971;
	b=ggCfRcNSeB3QCsFAhzrd4axFrv9brIfzqXEHMyRpDIXTqmuBKeKaIQVp2htvoqyPSolh
	 YfKyYL5SXEmA6IXYOBQQL3p2eL/Qyl2OGzm382DFsxdkqycQynwaS6pFKPPVAr5QqQM8b
	 /Y/NxxmDbGDekrDut1d98q6qi2voC2UIQ5gI8BLEdcSFmHvWkF+E58yQP5BVjhjCXFlDW
	 4zp0OtvpHZF/WyGS4MW9SaCWMIo7HuHkC5u4TLQhb4XshEfCyf+zRJqCbZt5aBJfLOh87
	 1LObKYu35O+gN3hC+yJE8xXdLDF8tnridHGKDYmsmUH9XzjlJWAaCBQ4xorVoOOTvsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640971;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=TqU9mzSMoRSBhA2tlAVmvOR4VvtxTohd5mgqbKgv2co=;
	b=ERP8XayGdSg+ChZEj9snSX306Ub9/2LWi9CSbywiSRbN8VR9P4idH6pDLTzw5ldrk932
	 uAWa7phXHxVOAelPkC2jiHH3GXmYV8QTdIsqRnoJsW8Uf1psWXwTuxrczhlysIgL4Qroa
	 J1AwZ9nDFwigtXPcDeZzz0By6mJ/jU6aabIcEmOhdBIApvvQFz2066x5q326Oh1s3RA9x
	 IENpmO5XO70G67XK+WknaIhsgQ67yvZbDkgKrIHU6gjbJmeLP73IhOZ8MUnacZLa95W6E
	 6g+X0V5wBvwJucUWto6FNBST5e3k9MAYo8/Ntgh7zUWwOavtKnOVseMfxHp9EU4ANAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O81IAeW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDE606A5A3;
	Mon,  2 Nov 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O81IAeW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA11F00A18;
	Mon,  2 Nov 2026 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640970;
	bh=TqU9mzSMoRSBhA2tlAVmvOR4VvtxTohd5mgqbKgv2co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O81IAeW6IJUA1Nk2cdoAcXSRnCTH51kX5MkN6Qvmlskt9E83jMtz663IuG3BUOXu1
	 UlS5xfmwvLn0WMsafnxS4UkxqVuJj9Tn4UUUlEi7aNkDk1ciZ0Qm4phS44zjZrFw0h
	 TQxVylzgm+r9oLnOI02QdUGsxfQUzfhQdgs/+V5H5y7DmA5K7CUieATIJVaC2vLrtK
	 g9NkKVQ+4MwWVgJWjBjK+8kCJGe65ObUZAg65EZshD5G37qCJdBfXn6tZMashF35gd
	 7v/Vk68d9/vkLX28C8Tnv58m7l/XnU/ibxTEqJKZncLq6xPjIHWsi7tyzJiNMkTlUL
	 3fnySMkjPPy+A==
Message-ID: <043c1f21-f7dc-411e-a2cd-5748e1162169@kernel.org>
Date: Mon, 2 Nov 2026 11:36:07 -0600
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
Subject: Re: [PATCH 2/2] PM: Add shutdown=legacy command line option
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Bartu Alev <bartualev@gmail.com>
References: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
 <20261102-superm1-s4-at-s5-v1-2-313e0012dd39@kernel.org>
 <4d80567f-ecdc-4dcc-aff9-4645df4d3ea0@infradead.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4d80567f-ecdc-4dcc-aff9-4645df4d3ea0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 11:17, Randy Dunlap wrote:
> 
> 
> On 11/2/26 5:54 AM, Mario Limonciello wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 0b3c140babd94..16d584bdbb73d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6981,6 +6981,10 @@ Kernel parameters
>>   	shapers=	[NET]
>>   			Maximal number of shapers.
>>   
>> +	shutdown=legacy [KNL]
>> +			Use the legacy device shutdown callbacks when powering off
>> +			the system instead of the hibernation power-off callbacks.
>> +
>>   	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
>>   			Limit apic dumping. The parameter defines the maximal
>>   			number of local apics being dumped. Also it is possible
> 
> Alphabetical order, please. I.e., add shutdown= after show_lapic=.
> 

Ack, thanks, will change in v2.
