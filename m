From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 21/27] cpufreq: scpi: Don't validate the frequency table
 twice
Date: Mon, 12 Mar 2018 12:43:36 +0000
Message-ID: <96a6904f-2328-c316-4852-937772f95402@arm.com>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <9a5c962bd3a225cfa87d6dcb0f6bb85697991c66.1519620578.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9a5c962bd3a225cfa87d6dcb0f6bb85697991c66.1519620578.git.viresh.kumar@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org



On 26/02/18 05:09, Viresh Kumar wrote:
> The cpufreq core is already validating the CPU frequency table after
> calling the ->init() callback of the cpufreq drivers and the drivers
> don't need to do the same anymore. Though they need to set the
> policy->freq_table field directly from the ->init() callback now.
> 
> Stop validating the frequency table from scpi driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

FWIW,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
