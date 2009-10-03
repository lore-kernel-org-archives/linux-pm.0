From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/19] freezer: don't get over-anxious while
	waiting
Date: Sat, 03 Oct 2009 09:43:43 +0900
Message-ID: <4AC69E3F.80301__47904.746552422$1254530747$gmane$org@kernel.org>
References: <1254384558-1018-1-git-send-email-tj@kernel.org>
	<4AC658C2.6070406@librato.com>
	<20091002210445.GE4189@count0.beaverton.ibm.com>
	<200910022321.11796.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910022321.11796.rjw@sisk.pl>
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
Cc: cl@linux-foundation.org, jeff@garzik.org, pm list <linux-pm@lists.linux-foundation.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, Oren Laadan <orenl@librato.com>, dhowells@redhat.com, jens.axboe@oracle.com, mingo@elte.hu, arjan@linux.intel.com, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

Rafael J. Wysocki wrote:
> Tejun, do you want me to take the patch or is it more convenient to you to
> push it yourself?

Please take the patch.  As long as it's in a stable git tree, it
should be fine for me.

> Also, care to respond to my previous comment?

About the comment?  Dropping it is fine.  Do you want me to resend the
patch w/o the comment?

Thanks.

-- 
tejun
