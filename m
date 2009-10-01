From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] 3c59x: Rework suspend and resume
Date: Wed, 30 Sep 2009 20:11:19 -0700 (PDT)
Message-ID: <20090930.201119.136086134.davem__10076.2745169506$1254366809$gmane$org@davemloft.net>
References: <20090925205206.GA9270@oksana.dev.rtsoft.ru>
	<200909252354.34511.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909252354.34511.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, avorontsov@ru.mvista.com
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 25 Sep 2009 23:54:34 +0200

> On Friday 25 September 2009, Anton Vorontsov wrote:
>> As noticed by Alan Stern, there is still one issue with the driver:
>> we disable PCI IRQ on suspend, but other devices on the same IRQ
>> line might still need the IRQ enabled to suspend properly.
>> 
>> Nowadays, PCI core handles all power management work by itself, with
>> one condition though: if we use dev_pm_ops. So, rework the driver to
>> only quiesce 3c59x internal logic on suspend, while PCI core will
>> manage PCI device power state with IRQs disabled.
>> 
>> Suggested-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied, thanks everyone.
