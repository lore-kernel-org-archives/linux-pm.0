From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powermac: proper sleep management
Date: Tue, 4 Dec 2007 16:48:01 +1100
Message-ID: <18260.59921.473117.994246@cargo.ozlabs.ibm.com>
References: <1194981933.6695.17.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194981933.6695.17.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:

> +		printk(KERN_INFO
> +		       "via-pmu: the PMU_IOC_SLEEP ioctl is deprecated.\n");
> +		printk(KERN_INFO "via-pmu: use \"echo mem >"
> +		       " /sys/power/state\"  instead!\n");
> +		printk(KERN_INFO
> +		       "via-pmu: this ioctl will be removed soon.\n");

I don't like this.  I would rather keep the ioctls indefinitely and
not make any noise about programs using them.  The ioctls are part of
the kernel/user ABI, and thus need to be preserved, especially since
it only takes about 6 or 7 lines of code to implement them.

Paul.
