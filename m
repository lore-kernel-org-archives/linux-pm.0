From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/3] Net driver fixes related to power
	management
Date: Fri, 11 Feb 2011 11:39:04 -0800 (PST)
Message-ID: <20110211.113904.28807180.davem__40378.365739207$1297453245$gmane$org@davemloft.net>
References: <201102101751.56508.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102101751.56508.rjw@sisk.pl>
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
Cc: jcliburn@gmail.com, netdev@vger.kernel.org, mcarlson@broadcom.com, jie.yang@atheros.com, thomas@fjellstrom.ca, mchan@broadcom.com, chris.snook@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 10 Feb 2011 17:51:56 +0100

> The following series of patches fix minor issues related to power management
> in the tg3, alt1 and atl1c drivers.
> 
> [1/3] - tg3: Don't use device_init_wakeup() (PCI does that)
> [2/3] - atl1c: Don't use device_init_wakeup() (ditto)
> [3/3] - atl1: Don't use legacy PCI power management.
> 
> Please consider for applying.

All applied to net-next-2.6, thank you.
