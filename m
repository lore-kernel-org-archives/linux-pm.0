From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 23 Sep 2009 16:28:29 -0700
Message-ID: <4ABAAF1D.6090907@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <19129.63264.653666.70492@pilspetsen.it.uu.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-pm@lists.linux-foundation.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Mikael Pettersson wrote:
> Eric Miao writes:
>  > On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>  > <khilman@deeprootsystems.com> wrote:
>  > > On ARM platforms, power management can be very platform specific.
>  > > This patch allows ARM subarches to extend the platform_device
>  > > pdev_archdata for each subarch by creating a new struct pdev_machdata
>  > > and allowing each subarch to customize it as needed.
>  > >
>  > > As a starting point, each subarch's <mach/device.h> creates an empty
>  > > struct pdev_machdata.
>  > >
>  > 
>  > Shouldn't that pdev_archdata and pdev_machdata be pointer or something
>  > so that multiple platform_device can share something in common?
> 
> Forcing it to be a pointer has allocation and lifetime implications.
> Making it a struct allows the subarch to duplicate or share
> (via a private pointer) data as it sees fit.

Yes, the allocation/lifetime issues were why a struct was chosen.

Kevin
