From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 14:00:55 +0530
Message-ID: <20150623083055.GJ16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
 <20150623071647.GD3245@x1>
 <20150623080309.GI16776@linux>
 <20150623082759.GF3245@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150623082759.GF3245@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On 23-06-15, 09:27, Lee Jones wrote:
> Okay, but the reasoning is the same.  I consider the function to have
> failed, but the over-all failure culminates in just a warning that
> voltage scaling has indeed failed, but we can still go on with
> frequency scaling.

Ahh, I thought that the other opp-table will also have voltages.

> Unless his is a big blocker for you, I would like to keep these
> semantics.

No, the print is actually fine.

> So technically you are correct, but it makes the code slightly more
> confusing IMHO.  Yes, it's one more line of code, but it's worth it to
> add clarity.

Your call :)

-- 
viresh
