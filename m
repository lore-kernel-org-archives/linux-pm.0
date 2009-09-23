From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 23 Sep 2009 16:36:19 -0700
Message-ID: <4ABAB0F3.2050802__21250.6643300459$1253749129$gmane$org@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Mikael Pettersson <mikpe@it.uu.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Eric Miao wrote:
> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Mikael Pettersson wrote:
>>> Eric Miao writes:
>>>  > On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>  > <khilman@deeprootsystems.com> wrote:
>>>  > > On ARM platforms, power management can be very platform specific.
>>>  > > This patch allows ARM subarches to extend the platform_device
>>>  > > pdev_archdata for each subarch by creating a new struct pdev_machdata
>>>  > > and allowing each subarch to customize it as needed.
>>>  > >
>>>  > > As a starting point, each subarch's <mach/device.h> creates an empty
>>>  > > struct pdev_machdata.
>>>  > >
>>>  >  > Shouldn't that pdev_archdata and pdev_machdata be pointer or
>>> something
>>>  > so that multiple platform_device can share something in common?
>>>
>>> Forcing it to be a pointer has allocation and lifetime implications.
>>> Making it a struct allows the subarch to duplicate or share
>>> (via a private pointer) data as it sees fit.
>> Yes, the allocation/lifetime issues were why a struct was chosen.
>>
> 
> Mmm... this makes sense to me. I'm ok with this patch - just wondering
> for the moment what to put for the pxa architecture - I'll see what davinci
> will do first, of course :)

Well, I'll be doing OMAP before davinci, and the pdev_machdata will 
bascailly contain an OMAP specific struct (omap_device) that keeps track 
of various OMAP-specific device proerties (powerdomain, clock(s), PM 
register offsets, etc. etc.)  Basically, nothing that would be shared by 
other arches.

If down the road we figure out stuff common to all ARM platforms, we 
could put it in the pdev_archdata struct.

Kevin
