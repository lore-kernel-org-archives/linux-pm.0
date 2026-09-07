Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9541BA94;
	Mon,  7 Sep 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767139; cv=none; b=XNH/QDLP6E+rGgNVSFAVmLSObrpQzWUwA47Urwun4prBjM4SN1FVpHKr3GP/PGPKnkBuU/dCZwIHrvXX7z1NBGBFv/D3bZ9KB9mbmA2hk/3ldG2LiV0nHrnCdEL/6OzazML3MIBPdH4b2me337KB07lvQ+ugP53UujmuzruqmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767139; c=relaxed/simple;
	bh=zYbilynVgctxpKvoZebJMDbPinZizUKJ1YfEXtScX6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCLihzka1WwT9mGye3GHzvEoJQ0B9e2ZpIaqsm/8P6N2R1St7R4+fIbIv954k+hjjRv9w+xNO2U/AjLCbI2Gzr+pYRipc6BZBtzh5nZlu/t3pigUiaNpA13lN7FoK1qJvMBEx7DUrIIVp2KoiQj5HIpazyRHmp9bJTk/UCbW5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EvFaHUOO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EvFaHUOO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151631477;
	Mon,  7 Sep 2026 00:45:31 -0700 (PDT)
Received: from [10.57.7.146] (unknown [10.57.7.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62723F7D8;
	Mon,  7 Sep 2026 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788767134; bh=zYbilynVgctxpKvoZebJMDbPinZizUKJ1YfEXtScX6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EvFaHUOOMvIVEZKPoH0v2QrE6vjNuSePteLBwB7fP3xFHkbdDoMwR6fj4ZavS7Hbc
	 +d8DXoImU+B6BIDljr7NQ+EfTBV4X2mvYp42vkaY6mQJKESH8GYXTgAvJU/cOGn5nR
	 PEY0prscxI3T+ywrM/eaHcDMlEWond8FcRomJawY=
Message-ID: <14ef8279-22e4-4910-b7d8-18e2ba274d82@arm.com>
Date: Mon, 7 Sep 2026 08:45:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] thermal: of: Match trip property helper types
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20260831194235.1182138-1-robh@kernel.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260831194235.1182138-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

On 8/31/26 20:42, Rob Herring (Arm) wrote:
> The thermal-zone binding defines "temperature" as a signed int32
> value and "hysteresis" as an unsigned int32 value. Using helpers with
> matching types avoids dt_property_check mismatches and preserves the
> signed interpretation needed for trips below zero.
> 
> Read "temperature" with the signed helper and keep "hysteresis" on the
> unsigned helper using separate typed temporaries before storing them in
> the trip structure.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/thermal/thermal_of.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 


I can see you've missed my previous tag, here it is:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
