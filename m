From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac
	suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 17:34:10 +0900
Message-ID: <aec7e5c30906050134u1bcfc326p15691d90b6902d68__33184.9052491181$1244190965$gmane$org@mail.gmail.com>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	<20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
	<20090605101816.6bbe496e@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090605101816.6bbe496e@hskinnemoen-d830>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: ben-linux@fluff.org, anemo@mba.ocn.ne.jp, gregkh@suse.de, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 5, 2009 at 5:18 PM, Haavard
Skinnemoen<haavard.skinnemoen@atmel.com> wrote:
> Magnus Damm wrote:
>> +static struct dev_pm_ops dw_dev_pm_ops =3D {
>> + =A0 =A0 .suspend_noirq =3D dw_suspend_noirq,
>> + =A0 =A0 .resume_noirq =3D dw_resume_noirq,
>> +};
>
> Can this be const?

Hm, adding const generates a warning for me. At on SuperH with
gcc-4.3.3 (Sourcery G++ Lite 4.3-143):

[modified dev_pm_ops to const in sh_keysc.c]

  CC      drivers/input/keyboard/sh_keysc.o
drivers/input/keyboard/sh_keysc.c:299: warning: initialization
discards qualifiers from pointer target type

/ magnus
