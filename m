Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD53F1AC9
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188213; cv=none; b=W9rAarcujUOUs4hjJt1EM3hrkVAJ96AYf/lYqHFpJlBmRwCXhAAyuL5+gyyKx0YCQrMi5ErAhR5OPTlOSJGJ6DZATOJ5gbMgPB/p33llfVPGZc7UXOd1jAhdn7rmmgSlENKDodJtp8+BrIQZGBN9fU2kJOfSVxtWYnj4rGs9n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188213; c=relaxed/simple;
	bh=EndwdVD2O0qF5pb0wVa12iic0+kyWk7mBcLxDvPivzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMlRNvQYSSvIJymiF87OeAKG/AyycsY/pEzKX3gY+ix6dpmuAJqprA5Ug5yWoAnlgZgmTp123/i3oTnrr6sIIUHf7mPNx0xWD+YkFZeBkofAdDQw4cnF5ff4I826CBShDSLDLLqFp/xzCF6c3Pn+k8Dziz8xF9FFWgujRRdvO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=GU8OaWBu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="GU8OaWBu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso35334135e9.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1779188208; x=1779793008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h35duRtvh//yTgDxr0rLTRW2W/E6xgSVQ77IaLTNpFk=;
        b=GU8OaWBu9cuqPyiN/it9nbcucnrsOz0vdW3+Q5xDNcJYE+w6vL5+gzAJvepYF9bdxh
         covS6ngGbwas75FYhCMQnZd9/48EpI5X5DMnFe7hhs8xMEcG8vw63pYX1Fy1ORJcNgWN
         BtMFbsMmVNJZIemGqmLLk74JAgiXloO/LCNvDq1UD1tYnuDc5u79/ZL5rTwVbtOkpn3C
         adm8uWXXrnXcyVMpNWfgmDTAgddZFwrODMsT2lL4sCUbKTXQWcla3rngUqJ8EbVtE0HK
         e23/Ad4b+v9Wi02gBpmHVetHiOcH2sEUq83bwqsDCOVpFOICFUTKx8DM9YR+qdiwD2KH
         87xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188208; x=1779793008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h35duRtvh//yTgDxr0rLTRW2W/E6xgSVQ77IaLTNpFk=;
        b=gLR64WjarhB5BV8rcepqJfDzb5a3N1ntjWdkzwXsNPrtCDjbsDQgJxsA/E+G2nSIJr
         FFgf3Fb+rbW85MRWn9z53hVCigEB5GQcwq82vFy0lTAFwfpP/6PfLFPeHWAPTz08p0P6
         H+5yZQnp0Hx9cO8gqY4XDvlIBmStfjGTpV9R5SpUxqJ/YmPxZdGabyOHRtVs01MlnpLu
         LtXpYUqcTXjGybOFGthBxMygvdAbef7AT7NfBF5gdUsDaUWljS9fynv90lRYEHcVMmpJ
         5Ifzdjj2SSdOjgfa/dcxcoYFn6i8SjwBFdAUedAIZd2izMSR693OM5BowOBeCy5YNp//
         tRdA==
X-Forwarded-Encrypted: i=1; AFNElJ80d8Q04/5bWdZn2Vqg63+hy5T2ycCLuH5YRSAMXADGMJSlTTX7DbXlXLBjI05nvUJ+UH9Dld3ISg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFg6NDHVWRK8O9pQwW/XV61oI6YLptsBm346BTM9Cic6hUjBQt
	hcjKwbmDy8tuhP9YgNy6LzXUQhEjIJkxdMgU9KMX7xgg2U3hmIYWa/hr7zeBOWOzKZs=
X-Gm-Gg: Acq92OHkplkGkL8SU5xnv+5KPDqskPMyLLc6G+w87n4EEp6hdGJQln4bXVCrwi+7HUR
	bkICqmrUHYAfNvP9qsfKXi3nKmZP9CZPJQvjPaKPkCqKbsgwlBsjKXDAqM3e6SsBB6WYTqwCPvs
	Cm3kis4nn3CAu2OvbCJlFhCqsUVJB3uMGzJ75llghjqnWowEfu9P5TzE5DF7Xu+BfUadfKTvQIo
	42MQnlUdpWRfXA6zoGmrqGVnMBvM35qWli2YAYqlvZJgo8ozY4GT43n23Xb7mZiZ7wYQWljcEIP
	9YQLn3tAMULIo8/X1fNZiOgRA+CB9G4eWijIRkitLJ56dEMsmYzPY7IDh8FbPBayy2C97trFibb
	3Qqr5lG+f3cWo8pM5ozhQUp7Q/+zP/Tz9Q6lKNZDrrUF4FJILKoVQOKOgEzWVE1wKrp5gntmnyL
	brZN3kJv5IJSRLO9pia73e2GA8WQ==
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-48fe60eb0ebmr318246515e9.10.1779188207380;
        Tue, 19 May 2026 03:56:47 -0700 (PDT)
Received: from airbuntu ([149.40.48.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm303124745e9.12.2026.05.19.03.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:56:46 -0700 (PDT)
Date: Tue, 19 May 2026 11:56:44 +0100
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
Message-ID: <20260519105644.4tavwmfm2fouxq2w@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <20260519094745.GC3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519094745.GC3126523@noisy.programming.kicks-ass.net>

On 05/19/26 11:47, Peter Zijlstra wrote:
> On Mon, May 04, 2026 at 02:59:58AM +0100, Qais Yousef wrote:
> 
> > QoS is treated as a scarce resource and the intention is for the
> > a syscall to be done for each individual QoS tag. QoS tags are not
> > inherited on fork by default too for the same reason.
> 
> This is somewhat awkward. Most all state is inherited on fork. And all
> our tools are built around that. This is for example how I set a shorter
> slice on proton when launching a game (chrt -o --sched-runtime 280000
> 0). Tagging each individual thread that comes out of wine / random .exe
> is going to be painful.

Hmm. The problem is that with the benefit of a hindsight and after running
different experiments, you really don't want to inherit these properties by
default. I think if this tagging is not all designed, you end up with randoms.

With schedqos it is easy to tag all tasks by the way.

For example

	{
		"chrome": {
			"qos": "QOS_INTERACTIVE"
		}
	}

will cause all chrome tasks to be interactive by default, from /var/log/schedqos.log

	[2026-05-19 11:24:36] [INFO] [qos_manager.c:262] New app instance of 505409 /snap/chromium/3258/usr/lib/chromium-browser/chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505409:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505410:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505410 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505411:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505411 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505412:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505412 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505413:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505413 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505410:505409 PerfettoTrace
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505410 PerfettoTrace
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505412:505409 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505412 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505414:505409 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505414 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505413:505409 Chrome_ChildIOT
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505413 Chrome_ChildIOT
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505411:505409 ThreadPoolServi
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505411 ThreadPoolServi
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505414:505409 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505414 ThreadPoolForeg
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505415:505409 Compositor
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505415 Compositor
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505415:505409 Compositor
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505415 Compositor
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505416:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505416 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505416:505409 ThreadPoolSingl
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505416 ThreadPoolSingl
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505417:505409 chrome
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505417 chrome
	[2026-05-19 11:24:36] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505417:505409 HangWatcher
	[2026-05-19 11:24:36] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505417 HangWatcher

This is what I call the poor/easy way to tag; but the log gives you all created
tasks so you can try to use that to create smarter tagging, I found by
experiment for instance that the main chrome thread is the main interactive
task and while speedometer still drops a little bit, but I get really close
with this simple intentional tagging

	{
		"chrome": {
			"thread_qos": {
				"chrome": "QOS_INTERACTIVE"
			}
		}
	}

	sudo schedqos restart --daemon
	(no need to reboot or even restart chrome)

	[2026-05-19 11:28:38] [INFO] [qos_manager.c:262] New app instance of 505345 /snap/chromium/3258/usr/lib/chromium-browser/chrome
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505345:505345 chrome
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505345 chrome
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505346:505345 PerfettoTrace
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505346 PerfettoTrace
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505348:505345 ThreadPoolServi
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505348 ThreadPoolServi
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505349:505345 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505349 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505350:505345 Chrome_ChildIOT
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505350 Chrome_ChildIOT
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505351:505345 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505351 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505363:505345 Compositor
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505363 Compositor
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505367:505345 ThreadPoolSingl
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505367 ThreadPoolSingl
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505368:505345 HangWatcher
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505368 HangWatcher
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505407:505345 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505407 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505766:505345 MemoryInfra
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505766 MemoryInfra
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505405:505405 kworker/u4:4-ev
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505405 kworker/u4:4-ev
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505406:505406 kworker/u4:5
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505406 kworker/u4:5
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:262] New app instance of 505409 /snap/chromium/3258/usr/lib/chromium-browser/chrome
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_USER_INTERACTIVE for 505409:505409 chrome
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_USER_INTERACTIVE for 505409 chrome
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505410:505409 PerfettoTrace
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505410 PerfettoTrace
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505411:505409 ThreadPoolServi
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505411 ThreadPoolServi
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505412:505409 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505412 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505413:505409 Chrome_ChildIOT
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505413 Chrome_ChildIOT
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505414:505409 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505414 ThreadPoolForeg
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505415:505409 Compositor
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505415 Compositor
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505416:505409 ThreadPoolSingl
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505416 ThreadPoolSingl
	[2026-05-19 11:28:38] [INFO] [qos_manager.c:309] Applying QoS Tag QOS_DEFAULT for 505417:505409 HangWatcher
	[2026-05-19 11:28:38] [INFO] [qos_tagging.c:271] Applying QoS Tag QOS_DEFAULT for 505417 HangWatcher

You should be able to use that for testing by the way already instead of chrt
:-)

Actually on my laptop since I am very power sensitive and I use chrome a lot
I have this config to force all chrome tasks to be background except for one
(uclamp_max should help prevent using the top freqs often when not needed to
deliver meaningful perf)

	{
		"chrome": {
			"qos": "QOS_BACKGROUND",
			"thread_qos": {
				"chrome": "QOS_INTERACTIVE"
			}
		}
	}


I did create a config for steam to test gaming, but I still can't get a booting
kernel on ToT for my M1 system to run tests and collect more data.. The other
machine I have is poor for gaming workloads.

You can control the slice values for each QoS levels from qos_mappings.json.
Restarting the daemon is enough for it to take effect globally. So you can
change configs, restart and collect data for different experiments on the fly.

Only caveat: you have to reboot to undo schedqos fiddling with all tasks.
I don't have a good way to restore system state yet and I am not sure it can be
reversible..

> 
> Can't we have both by using something like SCHED_FLAG_RESET_ON_FORK
> combined with setting a hint?

We had similar discussion in the past in [1]. And I think we'll end up getting
more of such proposals to selectively reset specific tags.

I do set this flag anyway in schedqos so that we can introduce the option to
introduce new high level QoS to take advantage of RT, DL etc. Not that users
can escape schedqos listening to all forks and execs anyway :p

Anyway, my point is that I hopefully fixed the problem how folks can be
intentional very easily, and while I won't spend a lot of time arguing for it,
but my strong recommendation being reserved and not inherit is the easier
problem to deal with. A big part of the problem space is noise management, not
just functional development of new QoS.

We still have the question whether we must enforce a single CAP_PERF_MANAGER
user of this interface. Maybe at LPC we can discuss these details better.

[1] https://lore.kernel.org/lkml/20230416213406.2966521-1-davidai@google.com/
