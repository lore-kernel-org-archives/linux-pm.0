From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] skge: Do not use legacy PCI power management
Date: Fri, 31 Dec 2010 12:50:32 -0800 (PST)
Message-ID: <20101231.125032.200373631.davem__23296.1441310637$1293828694$gmane$org@davemloft.net>
References: <201012261944.32517.rjw@sisk.pl> <20101230105229.189f3737@nehalam>
	<201012302350.01205.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012302350.01205.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 30 Dec 2010 23:50:01 +0100

> On Thursday, December 30, 2010, Stephen Hemminger wrote:
>> The skge driver used the legacy PCI power management, and did its
>> own PCI callbacks.  Use the same code model as Rafael's changes to
>> sky2. Let the PCI subsystem take care of all the PCI-specific aspects of
>> device handling during system power transitions.
>> 
>> Compile tested only (so far).
>> 
>> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to net-next-2.6, thanks!
