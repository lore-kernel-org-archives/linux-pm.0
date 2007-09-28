From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC] QoS params patch update.
Date: Fri, 28 Sep 2007 09:08:47 +0900
Message-ID: <20070928000847.GA30814__18559.2730682858$1190938346$gmane$org@linux-sh.org>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070927022440.GB25873@linux-sh.org>
	<20070926210515.6725e745.randy.dunlap@oracle.com>
	<20070927201739.GA2831@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070927201739.GA2831@linux.intel.com>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 27, 2007 at 01:17:39PM -0700, Mark Gross wrote:
> Updated qos PM parameter patch:
> Note: the replacing of latency.c with this is a separate patch.
> 
> this patch attempts to address the issues raised so far.
> 
[snip]

> +static int register_new_qos_misc(struct qos_object *qos)
> +{
> +	int ret;
> +
> +	qos->qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
> +	qos->qos_power_miscdev.name = qos->name;
> +	qos->qos_power_miscdev.fops = &qos_power_fops;
> +
> +	ret = misc_register(&qos->qos_power_miscdev);
> +
> +	return ret;
> +}
> +
Minor nit, ret is a pointless variable here, you can just return
misc_register directly.

Other than that, this looks much better!
