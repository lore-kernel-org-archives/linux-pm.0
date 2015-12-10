From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 00/10] cpufreq: Introduce ST's CPUFreq driver
Date: Thu, 10 Dec 2015 07:42:07 +0530
Message-ID: <20151210021207.GC29459@ubuntu>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On 09-12-15, 15:58, Lee Jones wrote:
> This is a re-write of the original submission, hence why the
> change-log is omitted.  Basically almost everything has changed.
> We are now using the new OPP framework and generic bindings
> written by Viresh.
> 
> There are 'ARM' patches in the set which are not necessarily
> related to CPUFreq, but are required to get it to work. Anyone
> who is not interested in general STi DT changes can safely
> ignore these.

Apart from minor comments in the 8th patch, everything else looks
fine.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
