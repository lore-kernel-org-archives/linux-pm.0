From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 01/04] Driver Core: Add platform device arch
	data
Date: Fri, 29 May 2009 14:51:05 +0900
Message-ID: <20090529055105.GD1122__11442.552021663$1243579391$gmane$org@linux-sh.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
	<200905282326.57431.rjw@sisk.pl>
	<aec7e5c30905282207v5fe17e6aj5a6382aa30d1774f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <aec7e5c30905282207v5fe17e6aj5a6382aa30d1774f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 29, 2009 at 02:07:35PM +0900, Magnus Damm wrote:
> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> --- 0001/arch/Kconfig
> >> +++ work/arch/Kconfig 2009-05-15 14:51:35.000000000 +0900
> >> @@ -112,3 +112,6 @@ config HAVE_DMA_API_DEBUG
> >>
> >> ?config HAVE_DEFAULT_NO_SPIN_MUTEXES
> >> ? ? ? bool
> >> +
> >> +config HAVE_PLATFORM_DEVICE_ARCHDATA
> >
> > Hmm. ?Do we really need yet another CONFIG_ option for that?
> 
> I don't think we need a total of 3 different config options for the
> platform device pm stuff, but I do think it makes sense to handle the
> platform archdata separately. Not sure which is the best way though,
> the #ifdefery is not very pretty. Maybe the best solution is just to
> drop the Kconfig stuff and add empty structures to all architecture
> versions of asm/device.h.
> 
A stub in asm-generic/device.h will cover the majority of cases. That is
much cleaner than adding to the Kconfig mess.
