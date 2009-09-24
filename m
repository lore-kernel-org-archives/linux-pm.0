From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] 3c59x: Get rid of "Trying to free
	already-free IRQ"
Date: Thu, 24 Sep 2009 15:47:42 -0700 (PDT)
Message-ID: <20090924.154742.171195189.davem__42206.4053979286$1253832525$gmane$org@davemloft.net>
References: <20090924183152.GA30254@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090924183152.GA30254@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: avorontsov@ru.mvista.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 24 Sep 2009 22:31:52 +0400

> Following trace pops up if we try to suspend with 3c59x ethernet NIC
> brought down:
 ...
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
