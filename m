From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 10:47:35 +0200
Message-ID: <1274863655.5882.4875.camel__44650.7634748288$1274863963$gmane$org@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005250138.16293.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
> > This of course will lead to a scattering of suspend blockers into any
> > drivers/subsystems considered "useful", which by looking through current
> > Android kernels is many of them.
> 
> That depends on the maintainers of these subsystems, who still have the power
> to reject requested changes. 

So as a scheduler maintainer I'm going to merge a patch that does a
suspend_blocker when the runqueue's aren't empty... how about that?
