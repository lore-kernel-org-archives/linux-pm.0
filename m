From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Thu, 22 Jul 2010 17:06:16 +0900
Message-ID: <AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK__3985.3505128578$1279786050$gmane$org@mail.gmail.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4yhagv4.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, Mikael Pettersson <mikpe@it.uu.se>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 27, 2009 at 8:13 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Eric Miao <eric.y.miao@gmail.com> writes:
>> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Mikael Pettersson wrote:
>>>> Eric Miao writes:
>>>> =A0> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>> =A0> <khilman@deeprootsystems.com> wrote:
>>>> =A0> > On ARM platforms, power management can be very platform specifi=
c.
>>>> =A0> > This patch allows ARM subarches to extend the platform_device
>>>> =A0> > pdev_archdata for each subarch by creating a new struct pdev_ma=
chdata
>>>> =A0> > and allowing each subarch to customize it as needed.

[snip]

> OK, after no further comments, sending this patch to the patch system.

Hi Kevin,

Thanks for your work on this. I found this patch marked as superseeded
in the tracker here:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D5773/1

I'd now like to use struct pdev_archdata myself on mach-shmobile, so
almost a year later I wonder why this patch didn't make it.

I realize that you use struct omap_device instead of struct
pdev_archdata. I prefer not to wrap if possible. This because I'd like
to reuse already existing drivers and PM code with the SuperH
architecture.

Do you remember what happened with this patch?

Cheers,

/ magnus
