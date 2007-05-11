From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-gitX: known regressions
Date: Thu, 10 May 2007 18:10:44 -0700
Message-ID: <20070510181044.d0f24e51.akpm__8811.81932422823$1178845932$gmane$org@linux-foundation.org>
References: <46430A3D.4030004@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46430A3D.4030004@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Auke Kok <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>, e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org, Thomas@smtp2.linux-foundation.org, David Chinner <dgc@sgi.com>, LKML <linux-kernel@vger.kernel.org>, Doug Chapman <doug.chapman@hp.com>, Alexey Dobriyan <adobriyan@sw.ru>, John Ronciak <john.ronciak@intel.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-pm@lists.linux-foundation.org, Gleixner <tglx@linutronix.de>, Jeb Cramer <cramerj@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 10 May 2007 14:04:13 +0200
Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi all,
> 
> Here is a list of some known regressions in 2.6.21-gitX.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> 
> 
> Unclassified:
> 
> Subject    : 2.6.21-git10/11: files getting truncated on xfs (after suspend/resume?)
> References : http://lkml.org/lkml/2007/5/9/410
> Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
> Handled-By : David Chinner <dgc@sgi.com>
> Status     : problem is being debugged
> 
> Subject    : Current -git kernel kills X
> References : http://lkml.org/lkml/2007/5/8/667
> Submitter  : Jeff Garzik <jeff@garzik.org>
> Status     : Unknown
> 
> 
> 
> Block devices:
> 
> Subject    : BUG in loop.ko
> References : http://lkml.org/lkml/2007/5/9/510
> Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
> Status     : Unknown
> 
> 
> 
> Networking:
> 
> Subject    : panic with e1000 driver on HP Integrity servers
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8455
> Submitter  : Doug Chapman <doug.chapman@hp.com>
> Caused-By  : Auke Kok <auke-jan.h.kok@intel.com>
>              commit e0aac5a289b1dacbc94bd9ae8c449bcdf9ab508c
> Status     : Unknown
> 
> 
> 
> Timers/NOHZ:
> 
> Subject    : 2.6.21-git4 BUG: soft lockup detected on CPU#1! 
> References : http://lkml.org/lkml/2007/5/2/511
> Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
> Handled-By : Thomas Gleixner <tglx@linutronix.de>
> Status     : problem is being debugged
> 

Please also consider:

Subject: libata reset-seq merge broke sata_sil on sh
Subject: [Bugme-new] [Bug 8462] New: applications under wine freezes

But we have many many more regressions which are in 2.6.21.x, only nobody's
tracking those.  Nobody seems to be fixing them either.  Probably
everyone's busy on the 2.6.14 regressions.
