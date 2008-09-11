From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC 2/5] devcore adds generic wakeup event handler
Date: Thu, 11 Sep 2008 12:48:52 -0600
Message-ID: <200809111248.52924.bjorn.helgaas__38134.6386428506$1221159358$gmane$org@hp.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<20080911063823.083409592@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080911063823.083409592@sli10-desk.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday 11 September 2008 12:30:39 am Shaohua Li wrote:
> The default action to handle wakeup event. Currently just prints something,
> maybe we should call .resume(). The routine will be called in task context.
> ...

> +void device_receive_wakeup_event(struct device *dev)
> +{
> +	printk("Device %s invokes wakeup event\n", dev->bus_id);

Please use dev_printk(), e.g., dev_info() in this case.  Also
applies to patches 4 and 5.
