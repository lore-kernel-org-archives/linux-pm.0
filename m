From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Fri, 5 Jun 2009 11:52:53 +0900
Message-ID: <aec7e5c30906041952q5dd0ae66n8c72a28f075d384@mail.gmail.com>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<200906012133.32074.rjw@sisk.pl>
	<aec7e5c30906012133w74d7d843jccad99c564a308ec@mail.gmail.com>
	<200906031045.45005.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906031045.45005.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 3, 2009 at 5:45 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Tuesday 02 June 2009, Magnus Damm wrote:
>> However, a typical embedded system has a wide range of platform
>> devices. Some are for the SoC itself and some are for external
>> devices, like on board ethernet controlllers (not on chip like the SoC
>> platform devices).
>
> Why don't we use the arch-specific wrapping for all platform devices on t=
his
> arch, the SoC ones and the non-SoC ones? =A0Is there any particular reaso=
n not
> to do that?

There are quite a few in-tree platform device drivers for SuperH that
can run on both ARM and SuperH. Maybe even MIPS in the future, who
knows. And we already have a perfectly fine platform device interface
that we can share, so I don't see any reason why we should invent
something new all of a sudden.

> If idle() and wakeup() are supposed to be platform-specific, and quite fr=
ankly
> I don't see how they could be implemented in a generic way, they don't ev=
en
> need to operate on struct platform_device objects.

The implementation can be platform specific, but the interface should
be shared across architectures. This so we can use the same device
driver on multiple architectures.

If you dislike the idea of operating on struct platform_device then
how about letting idle()/wakeup() or enable()/disable() take a pointer
to struct device instead of struct platform_device?

In my opinion it makes sense to allow architectures to add data to
struct platform_device since it's platform devices we're going to do
runtime PM on. For architectures not using struct pdev_archdata there
is really no additional runtime cost.

>> If you guys dislike adding arch specific data to struct platform
>> device then for SuperH we can just (mis)use the arch specific data in
>> struct device instead. I'm afraid that solution wastes memory since
>> the data will only be used for platform devices anyway. So I prefer
>> adding arch specific data to struct platform_device instead of struct
>> device if possible.
>
> That's generally OK, but I'd like to get convinced that there's no better
> way indeed.

The earlier version did something ugly with Kconfig. That's even worse IMO.

> What I personally don't like about the patch is the duplication of empty
> struct pdev_archdata for quite a number of architectures. =A0It's not nic=
e and
> I wonder if there's a way to avoid it.

I don't think there's any other way around that than Kconfig. The per
arch duplication of empty structures is already done for struct device
so it can't be that bad.

Thanks for your help!

/ magnus
