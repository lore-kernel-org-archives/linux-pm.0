From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] QoS params patch
Date: Thu, 27 Sep 2007 23:25:01 -0700
Message-ID: <20070927232501.79f9f4bd.akpm__4828.36318337849$1190960805$gmane$org@linux-foundation.org>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926224026.GA23218@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Sep 2007 15:40:26 -0700 Mark Gross <mgross@linux.intel.com> wrote:

> +#define QOS_RESERVED 0
> +#define QOS_CPU_DMA_LATENCY 1
> +#define QOS_NETWORK_LATENCY 2
> +#define QOS_NETWORK_THROUGHPUT 3
> +
> +#define QOS_NUM_CLASSES 4
> +#define QOS_DEFAULT_VALUE -1
> +
> +int qos_add_requirement(int qos, char *name, s32 value);
> +int qos_update_requirement(int qos, char *name, s32 new_value);
> +void qos_remove_requirement(int qos, char *name);

It's a bit rude stealing the entire "qos" namespace like this - there are
many different forms of QoS, some already in-kernel.

s/qos/pm_qos/g ?
