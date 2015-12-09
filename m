From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 09/11] cpufreq: st: Provide runtime initialised driver
 for ST's platforms
Date: Wed, 9 Dec 2015 08:28:41 +0530
Message-ID: <20151209025841.GW3692@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-10-git-send-email-lee.jones@linaro.org>
 <20151209025719.GV3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151209025719.GV3692@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On 09-12-15, 08:27, Viresh Kumar wrote:
> Good work Lee, looks mostly okay. Few nits below.

Also, it may make sense to quit early of opp-v2 isn't present in your
/cpus/cpuX node. As we wouldn't be using any of this then.

-- 
viresh
