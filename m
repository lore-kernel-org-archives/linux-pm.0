From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Wed, 2 Mar 2011 00:40:09 +0100
Message-ID: <AANLkTinNG9ecqSGk+zDjd0A+nLXmwHQkRot0WZ18amsv__36593.3443223641$1299022880$gmane$org@mail.gmail.com>
References: <cover.1298820825.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011431400.2034-100000@iolanthe.rowland.org>
	<AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
	<201103012207.22798.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103012207.22798.rjw@sisk.pl>
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
Cc: linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 1, 2011 at 10:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, March 01, 2011, Pierre Tardy wrote:
>> On Tue, Mar 1, 2011 at 8:33 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
>> > On Tue, 1 Mar 2011, Pierre Tardy wrote:
>> >
>> >> Please find sdhci runtime_pm implementation.
>> >>
>> >> It uses clock gating fw as a tip to know when our chip is idle.
>> >> It implements wake up from card insertion/removal.
>> >>
>> >> This is RFC, please dont merge yet. I really would like to have deep =
review
>> >> from PCI linux-pm guys.
>> >>
>> >> Opens are:
>> >>
>> >> 1/ Not sure if the pci configs in the driver in rpm_suspend/resume fl=
ow
>> >> =A0are not duplicate from what the core is doing.
>> >
>> > There may be one or two small errors.
>> >
>> >> 2/ Wakeup from D3hot: I cannot find any driver that is implementing i=
t in current upstream,
>> >
>> > Other drivers do it, but they use PCI PME# instead of interrupts.
>> Could you please elaborate?
>> My understanding is that PCI PME will generate MSI, which translate in
>> interrupt.
>
> Your driver won't get those interrupts.
>
> How it works is, basically, that when the device signals wakeup, it either
> causes a PME# signal to be raised (parallel PCI), or a PME Message to be
> sent upstream (PCIe). =A0In the first case it will cause a platform event
> (eg. ACPI GPE) to occur and the handle of that event will resume your
> device (using pm_request_resume()). =A0In the second case it will cause t=
he PCIe
> root port handling the PME Message to generate an interrupt and the handl=
er of
> that interrupt will resume your device.
Thanks, that explain a lot how it works.
What I still dont understand is that the wake source I'll have (e.g.
sd card insert) is still an interrupt source.
So it is supposed to generate interrupt until the interrupt source is
acknowledged.
Are we supposed to mask that interrupt source while suspended to make
sure we have either wake or interrupt?

>
> In fact, there are a few drivers in the tree using this mechanism already
> (r8169, e1000e, i believe PCI HCDs too).
Hope there will be more and more.

thanks,
Pierre
