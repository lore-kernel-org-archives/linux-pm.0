From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Mon, 11 May 2009 16:07:04 -0700
Message-ID: <20090511160704.e1fa2512.akpm__3325.29299562356$1242083662$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905100103.23815.rjw@sisk.pl>
	<alpine.DEB.2.00.0905111249170.23739@chino.kir.corp.google.com>
	<200905120044.37342.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905120044.37342.rjw@sisk.pl>
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
Cc: kernel-testers@vger.kernel.org, mel@csn.ul.ie, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 12 May 2009 00:44:36 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Which means this patch:
> http://marc.info/?l=linux-kernel&m=124165031723627 (it also is my favourite
> one).

ho hum, I could live with that ;)

Would it make sense to turn it into something more general?  Instead of
"tasks_frozen/processes_are_frozen()", present it as
"oom_killer_disabled/oom_killer_is_disabled()"?

That would invite other subsystems to use it, if they want to.  Which
might well be a bad thing on their behalf, hard to say..
