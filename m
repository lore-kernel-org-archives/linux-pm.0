From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 3/6] mm,
 PM/Freezer: Disable OOM killer when tasks are frozen
Date: Wed, 13 May 2009 16:01:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905131558010.26966__40947.8239169859$1242255854$gmane$org@chino.kir.corp.google.com>
References: <200905070040.08561.rjw@sisk.pl> <200905101548.57557.rjw@sisk.pl>
	<200905131032.53624.rjw@sisk.pl> <200905131037.50011.rjw@sisk.pl>
	<alpine.DEB.2.00.0905131534530.25680@chino.kir.corp.google.com>
	<20090513154726.0786a27d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513154726.0786a27d.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 May 2009, Andrew Morton wrote:

> > This allows __GFP_NOFAIL allocations to fail.
> 
> I think that's OK - oom_killer_disable() and __GFP_NOFAIL are
> fundamentally incompatible, and __GFP_NOFAIL is a crock.
> 

Ok, so we need some documentation of that or some notification that we're 
allowing an allocation to fail that has been specified to "retry 
infinitely [because] the caller cannot handle allocation failures."
