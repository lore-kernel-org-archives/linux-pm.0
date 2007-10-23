From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: pm qos and cpufreq interaction [Was: pm qos
	infrastructure and interface]
Date: Tue, 23 Oct 2007 20:03:43 +0200
Message-ID: <20071023180343.GA2624@isilmar.linta.de>
References: <20071004215139.GA20078@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071004215139.GA20078@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Thu, Oct 04, 2007 at 02:51:39PM -0700, Mark Gross wrote:
> Currently we have {cpu_dma_latency, network_latency, network_throughput}
> as the initial set of pm_qos parameters.

What about cpu_throughput{_min,_max}, as being something considered to be
proportional to the CPU frequency? This way, the cpufreq policy notifiers
might be able to utilize the pm_qos infrastructure; but maybe even also the
userspace interface (at least the min freq/max freq one)... Haven't thought
this through, but maybe you (or someone else) has.

Best,
	Dominik

PS: Each time I've tried to get back into business during the past
months, something got in between -- current issue is my terminally
broken notebook...
