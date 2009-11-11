From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] add suspend support for loongson2f
Date: Wed, 11 Nov 2009 14:55:51 +0800
Message-ID: <1257922551.2922.96.camel__23451.7433601015$1257922642$gmane$org@falcon.domain.org>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Len Brown <len.brown@intel.com>, yanh@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

(Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)

Loongson2f's cpu frequency is software configurable, when we set its frequency
to ZERO, it will go into the suspend mode and can be waked up by the external
interrupts.

With this feature and based on the kernel's suspend framework, this patch add
the suspend support for loongson2f family machines.

To utilize this support, the machines should provide a necessary external
interrupt to wakeup loongson2f from the suspend mode and make sure the
interrupt be able to send to the processor directly or indirectly(the interrupt
path is not blocked). otherwise, it will suspend there all the time.

And If there is an external timer used, please mask it with IRQF_TIMER,
otherwise, the system will fail on resuming from suspend.

The old lemote Fuloong2F mini PC did not provide any method to wakeup the
machine from the suspend mode, so, please not try to suspend the machine.  But
the latest lemote Fuloong2F add an interrupt line from the Power Button to the
Processor, If we press the button and release it immediatly, it will work as a
wakeup button.

For YeeLoong2F netbook, Since it's easy to setup the keyboard interrupt as the
wakeup interrupt, we just setup it and avoid changing the hardware. So the old
YeeLoong2F machines can also utilize this support. and in the coming patchset,
we will also setup the LID interrupt as the wakeup interrupt.

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (2):
  [loongson] 2f: add suspend support framework
  [loongson] yeeloong2f: add board specific suspend support

 arch/mips/loongson/Kconfig            |    5 +
 arch/mips/loongson/common/Makefile    |    6 ++
 arch/mips/loongson/common/pm.c        |  157 +++++++++++++++++++++++++++++++++
 arch/mips/loongson/lemote-2f/Makefile |    6 ++
 arch/mips/loongson/lemote-2f/pm.c     |   70 +++++++++++++++
 5 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/pm.c
 create mode 100644 arch/mips/loongson/lemote-2f/pm.c
