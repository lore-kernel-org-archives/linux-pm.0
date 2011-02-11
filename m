From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [Patch] idle governor: Avoid lock acquisition to
 read pm_qos before entering idle
Date: Fri, 11 Feb 2011 13:33:34 -0600
Message-ID: <1297452814.4967.110.camel__5725.45500840551$1297453703$gmane$org@mulgrave.site>
References: <1297300864.2645.128.camel@schen9-DESK>
	<201102110017.16066.rjw@sisk.pl>
	<1297385416.2645.262.camel@schen9-DESK>
	<201102112022.25637.rjw@sisk.pl>
	<1297452478.2645.265.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297452478.2645.265.camel@schen9-DESK>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Len <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, mark gross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, David Alan Gilbert <linux@treblig.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-02-11 at 11:27 -0800, Tim Chen wrote:
> On Fri, 2011-02-11 at 20:22 +0100, Rafael J. Wysocki wrote:
> 
> > 
> > Thanks, but I'd put that comment before the structure definition with the
> > "NOTE:" prefix and I think you should explain the reason why that field
> > shouldn't be changed to 64-bits.
> > 
> 
> Either you or James want to suggest a comment on why the field shouldn't
> be changed to 64-bits to be placed there?

/*
 * Note: The lockless read read path depends on the CPU accessing 
 * target_value atomically.  Atomic access is only guaranteed on all CPU
 * types linux supports for 32 bit quantites
 */

James
