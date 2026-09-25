Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7035A397
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319955; cv=none; b=Co+lp06KiMruHkjb6/HpqVncX7HXzB1m6H70RG3fvr/gWNLfla5rQHEleKsIg54s8YqM7sYaWAJjw9SDSbKNQe42COWBYMB2EeRKkQQQ2r5h2EpeBuQ8MjEnzZxLghltdJaqf33jsqrpbOu14Mot/SiHXL/Ecol/GLK9N4Cp27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319955; c=relaxed/simple;
	bh=nhesPjFvoW76FDZ7bEI+kbqKwbJDEEFfJlmizuXgtOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehqJ2Jnb6PuGFBPv2BOFfcX2SIR2+d7O0/kWTFNk37zHLupTEVE9bK+NBjnLzX9lD8CyUe6HACECoT0QoHarfaDYOumaqs8L4RxcFUYcr/H6EMi7KiyizaJkMoZtz+90VStkH5do8FjwaO/ckMK8CRIpnUuqLzhb5GDtp4pZxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me; spf=pass smtp.mailfrom=ik.me; dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b=Wy7tvNgU; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ik.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ik.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ik.me header.i=@ik.me header.b="Wy7tvNgU"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hrhYg1fkLzhsW;
	Fri, 25 Sep 2026 09:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ik.me; s=20200325;
	t=1790319943; bh=SANosIQfS9VpLzZYXOYAVknD82NtPdMJVQcK9zSydXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wy7tvNgUMuO2Z00gC2684Xj71Ho6F3X71wVvDJldghRadr2kfLTM9qIFkA6+s1Df8
	 ZTGsrKKAdJ4Yg4b4JA2lKYxMxlohMh0rxJmepwbaAcdkbGZ3IC2T6BsUNjrjVRuM8y
	 8HsiytK0U5CB2MmNCJPx8bRSgB8Akmx6zeVusjC8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hrhYd6lPFz8k1;
	Fri, 25 Sep 2026 09:05:41 +0200 (CEST)
Message-ID: <3a080b50-6396-bf8f-2e70-011b85c15fe2@ik.me>
Date: Fri, 25 Sep 2026 09:05:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
To: Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
 <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
 <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
 <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
 <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me>
 <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
Content-Language: en-US
From: Fourhundred Thecat <400thecat@ik.me>
In-Reply-To: <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: :2997a34c1a6c8c6:ham:c07166f4469634d
X-Infomaniak-Routing: alpha

resolved by resetting BIOS to factory defaults

after that, I tried painstakingly to enable/disable one by one

The cause is two BIOS settings, and the reason it took so long to find 
is that they are independently sufficient:

   AmdVt (AMD virtualization)        Disable  -> breaks s2idle wake
   PlutonSecurityProcessor           Disable  -> breaks s2idle wake

Either one alone is enough. Both must be enabled for the machine to 
resume. The full matrix, all with the IOMMU enabled and 24 CPUs online:

   AmdVt      Pluton     result
   Enable     Disable    no wake
   Disable    Enable     no wake
   Disable    Disable    no wake
   Enable     Enable     wakes normally

I had both disabled.
It also explains the confusing bisect: when I tested AmdVt=Enable with 
everything else at my settings it still hung, and when I tested 
Pluton=Enable with everything else at my settings it still hung, so I 
eliminated both. Each test only showed the setting was not necessary; 
neither showed it was not sufficient. With two independent triggers 
those observations are both true at once and single-setting elimination 
gives nothing.

So amd_iommu=off and nr_cpus=16 were both masking this rather than 
telling us anything about the kernel.

this is clearly a Lenovo BIOS bug. should this be reported to them ?

thank you for your help !
