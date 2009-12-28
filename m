From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] phylib: Fix deadlock on resume
Date: Sun, 27 Dec 2009 21:54:54 -0800 (PST)
Message-ID: <20091227.215454.226776048.davem__43843.4485615746$1261979766$gmane$org@davemloft.net>
References: <20091222221447.GA9268@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091222221447.GA9268@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: cbouatmailru@gmail.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, leoli@freescale.com, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 23 Dec 2009 01:14:47 +0300

> Sometimes kernel hangs on resume with the following trace:
 ...
> This patch fixes the issue by stopping the state machine on suspend
> and starting it again on resume.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
