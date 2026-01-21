Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02926F46E
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999384; cv=none; b=E7j3cfq8+Z1IcOVys3dvYCP3eR7SoiS84lZgFphE9O4ofr+4SWfcATGnUZeQyBda932FftENluWff8saRedS2awkGLS8yVxrb0yfbocbykCOkvb0iHwJnHBamo7riwvGB5pmnsjst2aPdLkutRwLHDRPQ4xM8NPnIdc7IEWyf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999384; c=relaxed/simple;
	bh=eTbdRZ3EDjjLldP7EQCKWuegQaoPyQu8amq1xiv7S24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHmCPRSS5XqtVbcDOFqVtoTK04yi76GdgV3JWfftWe/XGxsI0F6hsIUkllLYaLIpTGGIe8dNK7MagnFx9jMC6g3qtSfxHBUfcPWWoQsGj+zfQuC4IUkz4ecea7R5xujJIqhXBLCeO11wyK/RHW0huCpDp23nec4H2G/RuevGYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTI6q2Pb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTI6q2Pb"
Message-ID: <74596131-4d06-449e-8ba9-30b35e0e2064@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768999380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eMY15jQUg1d9exkjPL03OpjNq9pROg8/Ky6PMmi4Jo=;
	b=GTI6q2PbUlnUusUQtZZHWK4Ah/l3baqdOugRsfq3eNm22c/uW9o1yDVq3n9Bqak03Oszbc
	ISacFJss+d4Lq3FsbQJXKPPCXZ/CJjS9yc4VM6BuJNWTmH9jHq/BXrp+8AQj84aZA2sFtH
	PhGHKxqAaJWkorGMHwJ5B7uP3rlVMww=
Date: Wed, 21 Jan 2026 13:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 lgirdwood@gmail.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
 <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
 <aW+/J7id+7GhD9T9@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <aW+/J7id+7GhD9T9@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


>>> The SDCA class driver currently expects the device will be fully powered
>>> down on system suspend but not on runtime suspend. This is typically
>>> required as when audio is not active (ie. runtime suspend) jack detect
>>> is expected to still function, but when the whole system is hibernated
>>> there is no need to recognise audio jack events. This means the class
>>> driver needs to always be informed of a system suspend, so the direct
>>> complete optimisation (where PM will skip calling system suspend if the
>>> device is runtime suspended) is not appropriate for the SDCA class
>>> driver.
>>>
>>> Add the NO_DIRECT_COMPLETE flag to prevent this optimisation from
>>> running against this driver.
>>
>> Humm, this flag makes sure the class driver .suspend method is
>> called, but does the core also force a pm_runtime resume before?
> 
> Yeah this ensures the suspend method is always called.
> 
>> In other words, what is the state of the device when the
>> system suspend routine is invoked by the PM core when this
>> flag is set?
> 
> Can be either runtime resumed or suspended.

ok, so if the child driver wants to resume to full power it has to be done 'manually', the PM core does not help.

>> Going back to this SDCA driver, if the PM core does NOT
>> change the pm_runtime state, then should the class driver
>> perform a full pm_runtime resume and then do the expected
>> system suspend sequence?
> 
> Yeah we do perform a resume in the system suspend although to be
> honest its mostly just to force the pm_runtime_force_resume() in
> the system resume handler to always do a runtime resume.

I think we are talking about different actions...

a) pm_runtime resume BEFORE system suspend. That would be necessary to deal with e.g. clock stop modes that are valid in pm_runtime suspend but not system suspend. It's not clear to me for example if all SDCA chips will support direct transitions from PS3 to PS4, or be ok with power rails cut while in PS3.

b) pm_runtime resume DURING system resume. That may be useful to restore functionality, but it's too late to handle problems that occur during the system suspend phase.

Either way, that's a bit orthogonal to this patch, more a discussion on how to deal with class power management.

>> Sorry if I am splitting hair, in the past we played with
>> these PM flags and always understood them in the wrong way...
> 
> There is definitely a lot of subtlety in this part of the kernel,
> hence why I CCed the PM people on this patch :-) Its a bit of an
> odd optimisation this direct complete thing, as far as I can see
> lots of drives don't run it without really deliberately avoiding
> it. For SoundWire itself the soundwire host resumes all children
> before a suspend, which dodges the direct complete. I would
> imagine a lot of other peripheral buses do similar. For MFD
> children they are almost always on the same fwnode as their
> parent so they don't hit it either. Turns out this class driver
> is the first thing I have worked on that actually hits the direct
> complete optimimisation as far as I can see.

You lost me with this sentence:

"
For SoundWire itself the soundwire host resumes all children
before a suspend, which dodges the direct complete.
"

If the direct-complete optimization is not used, then do you actually see a different behavior with this NO_DIRECT_COMPLETE flag set?


