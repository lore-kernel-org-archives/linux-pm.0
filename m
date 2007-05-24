From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Thu, 24 May 2007 16:04:04 +0200
Message-ID: <46559B54.80106__7299.51920588991$1180015505$gmane$org@googlemail.com>
References: <46558708.2040803@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46558708.2040803@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-usb-devel@lists.sourceforge.net, =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, sparclinux@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux1394-devel@lists.sourceforge.net, Andrey Borzenkov <arvidjaar@mail.ru>, David Miller <davem@davemloft.net>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Memory management

Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8476
Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
Status     : Unknown



PCMCIA

Subject    : libata and legacy ide pcmcia failure
References : http://lkml.org/lkml/2007/5/17/305
Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
Status     : Unknown



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Status     : Unknown



Suspend

Subject    : STD fails with pci_device_suspend(): usb_hcd_pci_suspend+0x0=
/0x160 [usbcore]() returns -16
References : http://lkml.org/lkml/2007/5/19/66
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
Status     : Unknown

Subject    : 2.6.22-rc1 suspend to RAM problem
References : http://permalink.gmane.org/gmane.linux.power-management.gene=
ral/5819
Submitter  : Marcus Better <marcus@better.se>
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
             Kristian H=C3=B8gsberg <krh@bitplanet.net>
Status     : caused by fw-ohci module



Regards,
Michal

--=20
"Najbardziej brakowa=C5=82o mi twojego milczenia."
-- Andrzej Sapkowski "Co=C5=9B wi=C4=99cej"
