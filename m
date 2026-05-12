Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDA38734D
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575682; cv=none; b=owou0XdtfZbZeUQHgIOVRYzhZcUva33cATy+XI3Z0hDT1xeOhleRolYPUQjJP7HXlqp8t1FFLx4kTxB7E/vkKA/3b4T116+turtLkAxLOhSNIHkzYK/DmqnHGGDq7sjQqsDwofzXKRP6mH9PouzP+sbrb7eQRAzEXz67peqXpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575682; c=relaxed/simple;
	bh=RFDRZ0P9Qvc4vKthE7AfKBJfxxb4zYyJ3FkJxGuoe6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFADLkkbtP+8MBxcTVG4IzjqacREb7+mZjTokwKb7TYng0wsvcRDl47ptEt5ePtsjnI/Aattn7AJ6GNIPNbs/jxlIUQNhKfWMPOVDdZld0F3KMUXqeQb7D7ZxKOD85nEXQFS9JZkvigeiJYY01uIuxxOi8DRFgjWL6tTvRY2ekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=ozr+2/9O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="ozr+2/9O"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449de065cb3so4755368f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778575669; x=1779180469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9O4jHzVBdAwNrd2mArQ7dhJ6WlsevAEdelDSBRniGo8=;
        b=ozr+2/9OnfqNmOV1QySVTe7DeWabrZPi4e4FIKo9xSVRUe6ttTSh8eNS2Z52xgD8hT
         ghM4dR+M4kliAggyIVInPJ73viXG0tlpPrFRI7K03B2FgBzWlCr2tWEow8nFJu6CXoUP
         6+AMKgRHdF/v4X/NPsc0DO6EcgwKPDc55eFNwMAOGXvUAm7XnMSLDPb8UVJY1uYMfMUl
         SRo7RWjL/2Bs2d3UPFMcUW/gPodTh2okMf4hCltOps7NwGdQnm7RN+Q6xJK2dEvRLFSQ
         XzVi60QqUWtLOGpbOp1ReZ7+YFFICxyrY7qjkWZUogry5XhVqrzn2Ed9W57lxtWQPCyW
         wM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778575669; x=1779180469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O4jHzVBdAwNrd2mArQ7dhJ6WlsevAEdelDSBRniGo8=;
        b=gon3tHHeqeGrwYPTBVoSsIZAA/ZZ3nuqIBS1mWKdxoUCA3I7CEbeOPALoi8DsFXs/U
         jOxZFSc+kVuyjXbmTQowip3QPs9hDaCFyC6yreEkcyH+vlvXJknqFYWpPa6/zrty4SDv
         OGQbRNRPZDh0UEPCLf0ZxbK3VJwgEhXzjeme/dzZy8A35XnmwvIY3c72YzL6HZduDYai
         2lZVR9vGpysoEI4d2s1aN4A9JOM9NKaVffsBkljx3sWE4MGprvqOxGIbzrK9k8Q9ePNq
         lJqmhCrNX2LDvAnHbQlhX+xArA8g+FJ/cg2MmlSQaN8ItRUdyYaTesLiEw/2wE6/1EWZ
         +Fdg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y4MhTGl1YHTv106eXjPy8B8ZaeYgqiP/LhSlGlssXUUZNIQ/ZF9zePHJrEQF0fsDFn8j3daUQEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Bt96wSMHCDEXB9DUBMbm4NoE4CBz/iVX41Hs3Qmqv4tY94z9
	LBexAufCTl7GOWSPPaSM++WskatBTbuZLACtg/dEQVvA9+QNdyt+bZNPva6vLMzRe5hbcrgsa2Y
	a88tD
X-Gm-Gg: Acq92OHESY9pkH1Ncb+9imINTG6bkwG9dVlHH8gXDIQ4eDz1Kux5Zl9BP1Q+i9n2khI
	II8GuAUSGn6Hms8o4jzbrsJ6Mu45rW8meJlFbhVu9dMHt+0H7uAj0OhQqHI0qg5hHYxqNkxCs6h
	MbPu7XNzcvyyGlmXyUCHzCE94JGuLwbEk+ESh8eeJPvZzWpOu9nxHqoY+nE1s6MWWsDchA1VF6p
	UIop942Ow7ekDeY8i2ZrzmA3hFhiIvEX6CTMyzP7BbaS7mDALL272RSdJruo93PKmrZcacXSfPI
	v5tnoI8TlRVlzYmPuHUDTyCJA3WW59jV7gsYxMAfLU+rhfZuaRG3rhVw7SeRInpuIcvOtJIAlAL
	MdK4UOfQAIkVd/3PAL6fHxFown/L/AOFI09pIxDGSbIgYTuHnIZ8JwEl5xMg5UJW6wrA2K4eS1p
	nTo/KfUyxG1A7anQud
X-Received: by 2002:a05:6000:4203:b0:44e:d7f8:3945 with SMTP id ffacd0b85a97d-4515b525c29mr45824736f8f.13.1778575669109;
        Tue, 12 May 2026 01:47:49 -0700 (PDT)
Received: from airbuntu ([146.70.179.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm32178544f8f.32.2026.05.12.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:47:48 -0700 (PDT)
Date: Tue, 12 May 2026 09:47:45 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
Message-ID: <20260512084745.s47ujqoymvbdz2uf@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <20260511105704.GR3126523@noisy.programming.kicks-ass.net>
 <20260512075809.5on43u3wrnelqe4i@airbuntu>
 <20260512083054.GM3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512083054.GM3102624@noisy.programming.kicks-ass.net>

On 05/12/26 10:30, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 08:58:09AM +0100, Qais Yousef wrote:
> 
> > If you saw schedqos code
> 
> I was in fact looking for that, but found this series did not include
> it. Didn't get around to looking harder yet..

I had a link to the commit that integrates rampup multiplier [1]. The utility
is in my github [2] at the moment. I am hoping, if we all agree it is the right
thing to do, to move it to kernel.org and get the development on the list.

I yet to introduce how to manage cookies there FWIW. I still need to spend more
time to bring it to full shape.. I plan to add support to help Tim and Chen to
easily tag QOS_MEM_DEP (or whatever name we choose) tasks/processes so that can
help with driving how cache aware support can be added and managed by this
service. And give us more confidence in the interface and overall concept.

It'd be reassuring to know if it's moving in the right direction or not before
I sink more time on it :)

[1] https://github.com/qais-yousef/schedqos/compare/main...schedqos
[2] https://github.com/qais-yousef/schedqos

> 
> > I already have to parse procfs to discover all existing running processes/tasks
> > after connecting to netlink socket to listen to new forks/execs (and plug the
> > race). 
> 
