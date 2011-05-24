From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq
	table
Date: Mon, 23 May 2011 17:05:49 -0700
Message-ID: <20110524000549.GA20225__39852.6393961676$1306195718$gmane$org@google.com>
References: <1306192335-19883-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306192335-19883-1-git-send-email-nm@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
> cpufreq table allocated by opp_init_cpufreq_table is better
> freed by OPP layer itself. This allows future modifications to
> the table handling to be transparent to the users.
...
> +void opp_free_cpufreq_table(struct device *dev,
> +				struct cpufreq_frequency_table **table)
> +{
> +	if (!table)
> +		return;
> +
> +	/* Pretend as if I am an updater */
> +	mutex_lock(&dev_opp_list_lock);
> +	kfree(*table);
> +	*table = NULL;
> +	mutex_unlock(&dev_opp_list_lock);
> +}

Not clear what the mutex protects here.  Currently it protects only
device opp list modifications.  opp_init_cpufreq_table holds the lock only
while looking up and walking the device opp list; the cpufreq table it
creates is not complete by the time the lock is dropped.


Todd
