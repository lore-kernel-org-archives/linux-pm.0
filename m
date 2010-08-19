From: Tejun Heo <tj@kernel.org>
Subject: Re: [Regression,
 2.6.36-rc1] ath9k resume problem on Acer Ferrari One
Date: Thu, 19 Aug 2010 10:11:01 +0200
Message-ID: <4C6CE715.4010203__33134.1199846522$1282205830$gmane$org@kernel.org>
References: <201008190001.11342.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008190001.11342.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ath9k-devel@venema.h4ckr.net, Luis Rodriguez <lrodriguez@atheros.com>, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On 08/19/2010 12:01 AM, Rafael J. Wysocki wrote:
> While testing 2.6.36-rc1 (with a couple of fixes on top) I noticed
> that the ath9k driver didn't work after resume from suspend to RAM.
> An attempt to unload the driver using rmmod caused the BUG_ON() in
> kernel/workqueue.c:2844 to trigger.

That BUG_ON() triggers if destroy_workqueue() is called while work
items are still pending on the workqueue.  Can you please trigger
stack traces after resume and post it?

Thanks.

-- 
tejun
