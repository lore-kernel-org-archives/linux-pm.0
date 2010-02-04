From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Net / pktgen: Fix freezing problem
Date: Thu, 04 Feb 2010 14:00:54 -0800 (PST)
Message-ID: <20100204.140054.169192674.davem__7678.25890002332$1265325295$gmane$org@davemloft.net>
References: <201002042250.58944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002042250.58944.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, ciprian.craciun@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 4 Feb 2010 22:50:58 +0100

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Net / pktgen: Fix freezing problem
> 
> Add missing try_to_freeze() to one of the pktgen_thread_worker() code
> paths so that it doesn't block suspend/hibernation.
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=15006
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-and-tested-by: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>

Applied, thanks a lot.
