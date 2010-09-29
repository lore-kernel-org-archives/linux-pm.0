From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM / Hibernate / x86: Change
	RESTORE_MAGIC on x86_64
Date: Wed, 29 Sep 2010 12:58:05 +0200
Message-ID: <201009291258.06048.rjw__21426.4917107814$1285758133$gmane$org@sisk.pl>
References: <201009290112.11363.rjw@sisk.pl> <4CA27A01.1080606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA27A01.1080606@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 29, 2010, H. Peter Anvin wrote:
> On 09/28/2010 04:12 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > On x86_64 the configuration and version of the kernel that
> > hibernates and creates a system image may be different from the
> > configuration and version of the boot kernel that loads the image.
> > So long as both these kernels are built with the same value of
> > RESTORE_MAGIC, the image created by one of them should be
> > successfully loaded and restored by the other one.
> > 
> > It wasn't necessary to modify RESTORE_MAGIC in the past, but now
> > that we are adding compression to the in-kernel hibernate code,
> > change the value of RESTORE_MAGIC so that earlier kernels don't
> > try to load compressed images they can't handle.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  arch/x86/power/hibernate_64.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6/arch/x86/power/hibernate_64.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/power/hibernate_64.c
> > +++ linux-2.6/arch/x86/power/hibernate_64.c
> > @@ -137,7 +137,7 @@ struct restore_data_record {
> >  	unsigned long magic;
> >  };
> >  
> > -#define RESTORE_MAGIC	0x0123456789ABCDEFUL
> > +#define RESTORE_MAGIC	0x0123456789ABCDF0UL
> >  
> 
> Two issues with this:
> 
> a) shouldn't we only set this when the image is actually compressed?

Well, in fact, this is a workaround, because the compression happens in a
different layer.  However, that other layer doesn't have any compatibility
checks (at least on x86-64), other than seeing that the image metadata
don't make sense at one point.

> b) using systematic magics like this is pessimal in terms of collision
> avoidance.  It's much better to use a true random number.
> 
> Hence, I propose:
> 
> : anacreon 95 ; ranpwd -xc 16
> 0x4ddedd3236f1e6e1

Fine with me, although I don't expect it will be necessary to do that in
the future.

Thanks,
Rafael
