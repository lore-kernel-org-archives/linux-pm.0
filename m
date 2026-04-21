Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB291C862D
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781635; cv=none; b=O1vumoA3cAB9Af60XncOiVL9LWK/+1+EWUK+ZZI1dAhCN7Fv7WvQV/o5ZHHol6QXV/7eEqAOo26fCCku78uoSzz67Ikd4zAbPOhBWjrZDjLKc9B3DsoLMgtD9gTK1mJ3bKJtMjvmq4V2ATDDAOYiG50RLw0MW5blE7KctNGecWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781635; c=relaxed/simple;
	bh=dzvYAR90ONuHYy77DmO8JKW+CDBHX1iMYCGCcl3AFxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOhBPOi+NC63P9RW7+ZdlD3tOZeoTZBtsfpvp980rZhV7csnHeJ/wAbG00OCAqE1sQJj0VW4kBwW/Jb3Au8WuSnvjo9ao0lA/OthGvDIylKr6pd5wxsJz0BpwRrAAAXekAtPd8SJdYtWiqUfMb+YCkKf5yXsk/L8z4rS76KAnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eV0RZhVp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eV0RZhVp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04C625DE;
	Tue, 21 Apr 2026 07:27:07 -0700 (PDT)
Received: from [10.57.19.135] (unknown [10.57.19.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B61B3F915;
	Tue, 21 Apr 2026 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776781633; bh=dzvYAR90ONuHYy77DmO8JKW+CDBHX1iMYCGCcl3AFxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eV0RZhVp2TS5sgjtsVJ72pfBJzfQ01amehUueX3aAKuw6R1gaewrcLj0VpuBQoCIa
	 qRs1vJZNnZTPhzwPBMBIMRjx/PjNWz2p7PwMbbWXmvUdl0JgNaIZpUYh9B/IaVkAp2
	 RDzotVg5OSBWMHZ6kI4aMm8GS2FkqLVjwdYECtu0=
Message-ID: <fff66226-a460-4c11-ba4c-88764cc1f1c4@arm.com>
Date: Tue, 21 Apr 2026 15:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <Pierre.Gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Armin Wolf <W_Armin@gmx.de>
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0juVDm3R3rffQsV3gQeC6zr=0q8y+KSpOPqvToyWh7vKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 4/21/26 14:47, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> On Thu, Mar 26, 2026 at 3:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi All,
>>
>> I'm looking for topic suggestions to be included in the power
>> management and thermal control micro-conference submission for
>> LPC2026.  The deadline for submitting LPC u-conf proposals is April
>> 23, so if there are any topics you'd like to be covered, please let me
>> know within the next 2 weeks.
> 
> Just a reminder.  The submission deadline is on Thursday, so I'm going
> to send a proposal tomorrow.
> 
> This is the last call for input.

As discussed at OSPM26 during the presentation, I will show some
implementation and experimental results. So the topic would be:

"Latency-focused QoS for kernel devices - implementation and
experiments"

Regards,
Lukasz
