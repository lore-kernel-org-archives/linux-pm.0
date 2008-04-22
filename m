From: Greg KH <greg@kroah.com>
Subject: Re: device_pm_add (was: Re: 2.6.25-git2: BUG: unable to
	handle	kernel paging request at ffffffffffffffff)
Date: Tue, 22 Apr 2008 15:12:12 -0700
Message-ID: <20080422221212.GB7792__32161.0308521942$1208903385$gmane$org@kroah.com>
References: <alpine.LFD.1.10.0804201410090.2779@woody.linux-foundation.org>
	<c4e36d110804221135v1dbfaf1bn4557052d1ead6060@mail.gmail.com>
	<alpine.LFD.1.10.0804221144130.2779@woody.linux-foundation.org>
	<200804222234.19936.rjw@sisk.pl>
	<alpine.LFD.1.10.0804221350110.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804221350110.2779@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 22, 2008 at 01:58:43PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 22 Apr 2008, Rafael J. Wysocki wrote:
> > 
> > There is a bug in device_add() that IMO can be fixed this way:
> 
> Ok, looks fine. Greg?

No, the other patch from Rafael looks "more correct", I'd prefer that
one to go in.  I'm about to be away from email for probably 24 hours or
so, so if you could commit it, I'd appreciate it.

thanks,

greg k-h
