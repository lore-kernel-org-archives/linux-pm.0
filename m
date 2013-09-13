From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 039/228] cpufreq: sa11x0: let cpufreq core initialize
	struct policy fields
Date: Fri, 13 Sep 2013 15:29:37 +0100
Message-ID: <20130913142937.GV12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org> <8a36f8e32d7a9e9f4aa74db0525dbdc74fc023dd.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8a36f8e32d7a9e9f4aa74db0525dbdc74fc023dd.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 13, 2013 at 06:29:45PM +0530, Viresh Kumar wrote:
> Many fields of struct policy are filled by cpufreq core when we call
> cpufreq_table_validate_and_show() and so cpufreq driver doesn't need to set them
> anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
