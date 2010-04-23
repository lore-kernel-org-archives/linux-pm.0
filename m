From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Fri, 23 Apr 2010 11:31:45 -0400
Message-ID: <20100423153145.GA6072__37521.8321024024$1272036878$gmane$org@elliptictech.com>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
	<20100420135636.GA10674@elliptictech.com>
	<201004210715.38621.rjw@sisk.pl>
	<20100421085739.GA2576@barney.localdomain>
	<20100421165758.GA23565@elliptictech.com>
	<20100423102338.GA3151@barney.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100423102338.GA3151@barney.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jerome Glisse <glisse@freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12:23 Fri 23 Apr     , Jerome Glisse wrote:
> On Wed, Apr 21, 2010 at 12:57:58PM -0400, Nick Bowler wrote:
> > OK, if the failure is due to userspace is doing Very Bad Things(tm),
> > catching that seems reasonable.
> > 
> > Nevertheless, even if it happened by luck, the result was (ostensibly)
> > working programs that suddenly break once one "upgrades" to the latest
> > kernel.  If userspace can't be fixed before 2.6.34 is released, perhaps
> > a less cryptic log message would be appropriate?
> 
> I pushed fix into mesa for the depth issue i will look into the other
> one today and likely push kernel fix.

Great, thanks.  I'll try out the depth fix tonight.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
