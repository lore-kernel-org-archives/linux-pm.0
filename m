From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Thu, 22 Dec 2011 13:20:38 -0800
Message-ID: <CAMbhsRQDLdozcK0uazMd2gSxRMdPqMq6vAE2__k08BBFCQS3eQ__20901.8747591928$1324588853$gmane$org@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4EF1A0B4.5080307@linux.intel.com>
	<CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
	<4EF1AA8A.8060304@linux.intel.com>
	<CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
	<4EF1CD49.9020800@linux.intel.com>
	<CAMbhsRRnKoR3YPWrZzVynVe+dcuU5v0siYvmp2vbBcS1hquC7Q@mail.gmail.com>
	<4EF2352C.3060102@linux.intel.com>
	<CAMbhsRSPCo9MSGp57Fv0sRdYUFcdwx8jEz1-CfX8LdKf8X4MVg@mail.gmail.com>
	<CAMQu2gxws83BUdj_eMbF0xpA1Mo_OA_MswE7KUm5pvbn3YbMuQ@mail.gmail.com>
	<4EF2F01E.8060307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4EF2F01E.8060307@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 22, 2011 at 12:53 AM, Arjan van de Ven
<arjan@linux.intel.com> wrote:
> On 12/22/2011 9:35 AM, Shilimkar, Santosh wrote:
>
>> Indeed. The SOCs, Arch's which does support low power
>> state independently and doesn't need any co-ordination between CPU's
>> will continue to work same way as before with this series.
>
> btw I think you misunderstand; I don't object to a need for something
> like this, I am just very concerned that this may not be possible to be
> done in a race-free way.

I agree that there are many potential races in this code, but I
believe I've handled all of them.  This patch set is a refactoring of
the common parts of the SMP idle code that has shipped on Tegra and
OMAP4 devices, so the basic idea has been hammered on extensively.

I think I've explained the protection against the race condition you
asked about earlier.  As for the power impact, the power savings of
getting into the deeper coupled power states far outweighs the cost of
booting all coupled cpus out of idle and letting them loop back to a
shallower idle state.

On an OMAP4 platform, at the slowest cpu speed, the system-wide power
usage with both cpus in the non-coupled state (WFI) is around 50 mA,
while the deepest coupled state is 12 mA.  At the fastest cpu speed,
WFI is over 100 mA.

On some platforms it may be possible to have only one cpu boot out of
idle when an interrupt arrives, but that introduces the race condition
you asked about before, where the last cpu tries to go into idle at
the same time that an already-idle cpu comes back out.  This way has
fairly minimal overhead (booting the 2nd cpu and then going to WFI),
and that's a path that already needs to be fast because it's part of
the normal single-cpu idle path.
