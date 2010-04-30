From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] workqueues: export keventd_wq
Date: Fri, 30 Apr 2010 07:16:49 +0200
Message-ID: <4BDA67C1.7050709@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com>
	<4BD89922.1040306@kernel.org> <201004282308.10751.rjw@sisk.pl>
	<20100429185851.GA13862@redhat.com>
	<20100429194447.GA17280@redhat.com>
	<20100429194545.GC17280@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100429194545.GC17280@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5?=@smtp1.linux-foundation.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

On 04/29/2010 09:45 PM, Oleg Nesterov wrote:
> -static struct workqueue_struct *keventd_wq __read_mostly;
> +struct workqueue_struct *keventd_wq __read_mostly;
> +EXPORT_SYMBOL(keventd_wq);

Umm... does it have to be EXPORTed?  Suspend block API can't be built
as a module, right?

-- 
tejun
