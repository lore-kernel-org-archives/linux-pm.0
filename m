From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after
 concurrent writing to cpufreq/scaling_governor (Resend)
Date: Mon, 08 Sep 2014 10:16:48 +0200
Message-ID: <1410164208.6159.18.camel@x200t>
References: <1405522398.2348.42.camel@x200t> <1406185912.2406.3.camel@x200t>
	 <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
	 <1406277769.2399.4.camel@x200t>
	 <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:53115 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989AbaIHIlO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 04:41:14 -0400
In-Reply-To: <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

(Sorry for the resend, I forgot to disable my S/MIME signature)

The patch you suggested did not work, so I introduced a new mutex in the
patch below.

I am not happy with adding just another mutex, but it fixes my problem
of changing governors concurrently.

Robert



This patch fixes a race condition when concurrently writing to cpufreq/scaling+AF8-governor


diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9fdedd..2ad6b03 100644
--- a/drivers/cpufreq/cpufreq.c
+-+-+- b/drivers/cpufreq/cpufreq.c
+AEAAQA -572,8 +-572,15 +AEAAQA static ssize+AF8-t show+AF8-scaling+AF8-governor(struct cpufreq+AF8-policy +ACo-policy, char +ACo-buf)
 +AH0
 
 /+ACoAKg
+- +ACo This mutex guarantees, that a concurrent writing to cpuX/scaling+AF8-governor
+- +ACo does not run into an OOPS.
+- +ACo-/
+-static DEFINE+AF8-MUTEX(cpufreq+AF8-store+AF8-governor+AF8-lock)+ADs
+-
+-/+ACoAKg
  +ACo store+AF8-scaling+AF8-governor - store policy for the specified CPU
  +ACo-/
+-
 static ssize+AF8-t store+AF8-scaling+AF8-governor(struct cpufreq+AF8-policy +ACo-policy,
                                        const char +ACo-buf, size+AF8-t count)
 +AHs
+AEAAQA -593,11 +-600,15 +AEAAQA static ssize+AF8-t store+AF8-scaling+AF8-governor(struct cpufreq+AF8-policy +ACo-policy,
                                                +ACY-new+AF8-policy.governor))
                return -EINVAL+ADs
 
+-       if (+ACE mutex+AF8-trylock(+ACY-cpufreq+AF8-store+AF8-governor+AF8-lock))
+-               return -EBUSY+ADs
+-
        ret +AD0 cpufreq+AF8-set+AF8-policy(policy, +ACY-new+AF8-policy)+ADs
 
        policy-+AD4-user+AF8-policy.policy +AD0 policy-+AD4-policy+ADs
        policy-+AD4-user+AF8-policy.governor +AD0 policy-+AD4-governor+ADs
 
+-       mutex+AF8-unlock(+ACY-cpufreq+AF8-store+AF8-governor+AF8-lock)+ADs
        if (ret)
                return ret+ADs
        else



-- 

Dipl.-Inf. Robert Schoene
Computer Scientist - R+ACY-D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +-49 (351) 463-42483
Fax : +-49 (351) 463-37773
E-Mail: Robert.Schoene+AEA-tu-dresden.de

