From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/cpu: post the event cpux add/remove instead
 of online/offline during hotplug
Date: Sun, 5 Aug 2018 10:52:24 +0800
Message-ID: <CAFgQCTu-UWr9iwG1qFEQ_Ur3TMUKwfWnamoybRyOhVOnSZjFug@mail.gmail.com>
References: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
 <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
 <87tvoag835.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <87tvoag835.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 4, 2018 at 10:48 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Pingfan,
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > Technically speaking, echo 1/0 > cpuX/online is only a subset of cpu
> > hotplug/unplug, i.e. add/remove. The latter one includes the physical
> > adding/removing of a cpu device. Some user space tools such as kexec-tools
> > resort to the event add/remove to automatically rebuild dtb.
> > If the dtb is not rebuilt correctly, we may hang on 2nd kernel due to
> > lack the info of boot-cpu-hwid in dtb.
>
> I notice you also sent a patch for ppc64_cpu to deal with CPUs being
> removed rather than just offlined.
>
> If I apply this patch then existing ppc64_cpu (without your other patch)
> will break. Is that right?
>
Yes. Since removing cpu will make a hole in cpu map, but ppc64_cpu
code takes the assumption that the cpu map is contiguous.

Thanks,
Pingfan
