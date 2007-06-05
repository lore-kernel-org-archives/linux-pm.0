From: James Morris <jmorris@namei.org>
Subject: Re: [4/5] 2.6.22-rc4: known regressions
Date: Tue, 5 Jun 2007 10:51:54 -0400 (EDT)
Message-ID: <Line.LNX.4.64.0706051049050.21439__39076.0571150624$1181055179$gmane$org@d.namei>
References: <46657407.1000108@googlemail.com> <466576B1.5020105@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466576B1.5020105@googlemail.com>
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
Cc: sparclinux@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, Simon <sg02r@ecs.soton.ac.uk>, Stephen Smalley <sds@tycho.nsa.gov>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Gregor Jasny <gjasny@googlemail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@redhat.com>, Eric Paris <eparis@parisplace.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Jun 2007, Michal Piotrowski wrote:

> SELinux
> 
> Subject    : very high non-preempt latency in context_struct_compute_av()
> References : http://lkml.org/lkml/2007/6/4/78
> Submitter  : Ingo Molnar <mingo@elte.hu>
> Handled-By : Stephen Smalley <sds@tycho.nsa.gov>
>             James Morris <jmorris@namei.org>
> Status     : unknown

Not sure what the criteria are for being listed as a regression, but this 
problem was likely introduced many moons ago with changes which reduced 
the memory footprint of security policy.


-- 
James Morris
<jmorris@namei.org>
