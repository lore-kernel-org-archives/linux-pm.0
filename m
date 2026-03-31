Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB73ACA48;
	Tue, 31 Mar 2026 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958969; cv=none; b=eX+3pRv3jfVOurxC/OKHEA0MamENPabp1BQS8F7u8yP5KKL0UcAy0DhZQFXiagFSNYjLbbYJ6Y2tUFZT3jmLWWm0jbAGDnkEhIXTc1YDjcyJQ9OwjdgkVP7XLn3e7FbmVMx5m+vdjdK3n1SH19A9XCexYJ8qdJXcAhw/Y5bJIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958969; c=relaxed/simple;
	bh=950LWm4pTnDoKulfz+1GiMMA0z1FtoorOBVdsl+0HP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE3PD6KIqlZMiMDv971sbKaeGK4fPrMt66XfcJfs8/mzgVSTiKap49aHoUYo70+Gg4G0f/CK9I871uwEZ/YWsDS8rH24oFw9+z+WeOnAsRpU+tKY1PbstnUxG5YSodpHp2+TpBq1tPHmlEGyLOLA0BiQMcPzzAP39WV8X0DnRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyte838F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyte838F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528BC19423;
	Tue, 31 Mar 2026 12:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774958969;
	bh=950LWm4pTnDoKulfz+1GiMMA0z1FtoorOBVdsl+0HP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nyte838FqYFY3pYNNbC3URoiDfvdqdVkWNIxpTfuUcgjmBeHaPcQzvwzcKNzBhVFB
	 Fkust7tBDYm/6EIwrIuu1FDLmW6nXnuQUXrgW9V2VIG4IGJYRekIMUW4XSC4JyB186
	 uH7IqJQK/xEJzrA88cZJIFZ6z/VJbzfsCvWIh19LknboFQnJBQjzHkwzg+Su/PdZPP
	 T/W0UHEfB/A86smrw+QRjjFzAhS5nVc0eGPR5rmqdY7V6usQEDFbQ8WgSvKw7mQZtp
	 zLCOdDjJx9U//rz25xsZUC02PpVn24QScMYIP3oxSb9SdXgDaOKh7LzGninp8OJdND
	 P/i3aTCDECvMg==
Message-ID: <cbd7f87c-89c2-42a6-9052-86e69f22baec@kernel.org>
Date: Tue, 31 Mar 2026 07:09:27 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Cache the max frequency in cpudata
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260326193620.649441-1-mario.limonciello@amd.com>
 <acuP/Dqh6+jBm+23@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <acuP/Dqh6+jBm+23@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/31/26 4:12 AM, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Thu, Mar 26, 2026 at 02:36:20PM -0500, Mario Limonciello wrote:
>> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>>
>> The value of maximum frequency is fixed and never changes. Doing
>> calculations every time based off of perf is unnecessary.
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> This one looks good to me. Thanks for fixing this.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 

Thanks, I've applied it.
