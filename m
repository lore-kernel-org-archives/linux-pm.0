From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Mon, 26 Oct 2009 16:13:35 -0700
Message-ID: <87k4yhagv4.fsf__47401.7953304157$1256598924$gmane$org@deeprootsystems.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	(Eric Miao's message of "Thu\, 24 Sep 2009 07\:30\:40 +0800")
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

Eric Miao <eric.y.miao@gmail.com> writes:

> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Mikael Pettersson wrote:
>>>
>>> Eric Miao writes:
>>> =A0> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>> =A0> <khilman@deeprootsystems.com> wrote:
>>> =A0> > On ARM platforms, power management can be very platform specific.
>>> =A0> > This patch allows ARM subarches to extend the platform_device
>>> =A0> > pdev_archdata for each subarch by creating a new struct pdev_mac=
hdata
>>> =A0> > and allowing each subarch to customize it as needed.
>>> =A0> >
>>> =A0> > As a starting point, each subarch's <mach/device.h> creates an e=
mpty
>>> =A0> > struct pdev_machdata.
>>> =A0> >
>>> =A0> =A0> Shouldn't that pdev_archdata and pdev_machdata be pointer or
>>> something
>>> =A0> so that multiple platform_device can share something in common?
>>>
>>> Forcing it to be a pointer has allocation and lifetime implications.
>>> Making it a struct allows the subarch to duplicate or share
>>> (via a private pointer) data as it sees fit.
>>
>> Yes, the allocation/lifetime issues were why a struct was chosen.
>>
>
> Mmm... this makes sense to me. I'm ok with this patch - just wondering
> for the moment what to put for the pxa architecture - I'll see what davin=
ci
> will do first, of course :)

OK, after no further comments, sending this patch to the patch system.

Kevin
