From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 Resend 00/34] CPUFreq Cleanup Part III
Date: Fri, 25 Oct 2013 14:56:53 +0200
Message-ID: <14730355.7hm7UiW5IU@vostro.rjw.lan>
References: <cover.1382104514.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1382104514.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, October 18, 2013 07:29:23 PM Viresh Kumar wrote:
> As Part II is already in your linux-next branch, I am sending Part III for
> inclusion in bleeding-edge.
> 
> This is oriented around a light weight ->target_index() routine. CPUFreq
> notifications would be moved to CPUFreq core in the next patchset that I will
> send, as you suggested not to merge multiple series together.. Although both of
> them are oriented towards a light weight ->target_index() routine.
> 
> This is rebased over your bleeding-edge branch + "cpufreq: create per policy
> rwsem instead of per CPU cpu_policy_rwsem"..

Having considered that a bit I think that I'd prefer one patch doing all of
these changes in one go (and with all applicable ACKs collected), one of the
reasons being that if it is necessary to revert that stuff, whatever the
reason, it will be much easier to do that with just one commit than with
34 of them.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
