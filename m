From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
Subject: RE: [PATCHv3 0/1] Intel Quark X1000 DTS thermal driver
Date: Tue, 31 Mar 2015 02:12:12 +0000
Message-ID: <F54AEECA5E2B9541821D670476DAE19C2B8CCA4B@PGSMSX102.gar.corp.intel.com>
References: <1425886977-31078-1-git-send-email-boon.leong.ong@intel.com>
 <AF233D1473C1364ABD51D28909A1B1B733B2E164@PGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34382 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbbCaCOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 22:14:03 -0400
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B733B2E164@PGSMSX104.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ong, Boon Leong" <boon.leong.ong@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>

> -----Original Message-----
> From: Ong, Boon Leong
> Sent: Tuesday, March 31, 2015 7:58 AM
> To: Zhang, Rui; edubezval@gmail.com
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ong, Boon
> Leong; pure.logic@nexus-software.ie; Kweh, Hock Leong;
> andy.shevchenko@gmail.com
> Subject: RE: [PATCHv3 0/1] Intel Quark X1000 DTS thermal driver
> 
> Dear maintainer, gentle ping if this driver is ready for more review/inclusion
> into Linux v4.1 ?
> Thank you very much.
> 
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >owner@vger.kernel.org] On Behalf Of Ong Boon Leong
> >Sent: Monday, March 9, 2015 3:43 PM
> >To: Zhang, Rui; edubezval@gmail.com; pure.logic@nexus-software.ie;
> >Kweh, Hock Leong; andy.shevchenko@gmail.com
> >Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: [PATCHv3 0/1] Intel Quark X1000 DTS thermal driver
> >
> >Dear maintainers & communities,
> >
> >This patch introduces DTS thermal driver for Intel Quark X1000.
> >The code implementation is based on intel_soc_dts_thermal.c.
> >
> >Intel Quark X1000 has one on-die DTS with two configurable trip points:
> >critical and hot trip points. However, todate, UEFI BIOS for Quark
> >X1000 uses only critical trip point. UEFI BIOS always lock DTS register
> >before hand-over to Linux kernel.
> >
> >The minimalist thermal design is meant to trigger Linux distro to
> >gracefully power-down the system when its DTS temperature exceeds the
> >configured critical trip point.
> >
> >In anticipation that other variant of Quark platform may come with UEFI
> >BIOS that does not lock DTS register during hand-over, this DTS driver
> >is built with logics to handle such case too.
> >
> >I have tested v1 of the patch on Intel Galileo Gen v2 board and found
> >it satisfactory with logs below:
> >
> >  root@quark:/sys/class/thermal/thermal_zone0# echo disabled > mode
> >  [   46.276881] intel_quark_dts_thermal: DTS is locked. Cannot disable DTS
> >  -sh: echo: write error: Operation not permitted
> > root@quark:/sys/class/thermal/thermal_zone0#
> >  root@quark:/sys/class/thermal/thermal_zone0# cat temp
> >  53
> >  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_0_temp
> >  105
> >  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_0_type
> > critical  root@quark:/sys/class/thermal/thermal_zone0# cat
> > trip_point_1_temp
> >  20
> >  root@quark:/sys/class/thermal/thermal_zone0# cat trip_point_1_type
> > hot  root@quark:/sys/class/thermal/thermal_zone0# cat type  quark_dts
> >
> >  root@quark:/sys/class/thermal/thermal_zone0# echo 105 > emul_temp
> >  [  179.372981] thermal thermal_zone0: critical temperature reached(0
> >C),shutting down
> >  root@quark:/sys/class/thermal/thermal_zone0#
> >  [  OK  ] Stopped target Multi-User System.
> >           Stopping Telephony service...
> >           Stopping Lightning Fast Webserver With Light System Requirements...
> >           Stopping Target Communication Framework agent...
> >           Stopping Galileo Arduino Layer...
> >  [  OK  ] Stopped target Login Prompts.
> >           Stopping Getty on tty1...
> >           Stopping Serial Getty on ttyS1...
> >           Stopping Login Service...
> >           Stopping D-Bus System Message Bus...
> >           Starting Store Sound Card State...
> >  [  OK  ] Stopped Telephony service.
> >  [  OK  ] Stopped Galileo Arduino Layer.
> >  [  OK  ] Stopped Login Service.
> >  [  OK  ] Stopped D-Bus System Message Bus.
> >  [  OK  ] Stopped Target Communication Framework agent.
> >  [  OK  ] Stopped Lightning Fast Webserver With Light System Requirements.
> >  [  OK  ] Stopped WPA supplicant.
> >  [  OK  ] Stopped Getty on tty1.
> >  [  OK  ] Stopped Serial Getty on ttyS1.
> >
> >Please kindly review the patch at your convenient time and provide me
> >feedback for improvement. Appreciate your time and effort.
> >
> >Thank You
> >Ong Boon Leong
> >Intel Corp.
> >
> >---
> >Changes in v3:
> >* Kconfig dependency changed to X86_INTEL_QUARK
> >
> >Changes in v2:
> >* Fix several commit write-up grammar, choice of words.
> >* Ensure "int ret" in correct order
> >* Add comment to explain DTS register field read/write bit operation
> >* Change to Dual BSD/GPL license
> >* Add logic to ensure safe trip point threshold value being set
> >
> >Ong Boon Leong (1):
> >  thermal: intel Quark SoC X1000 DTS thermal driver
> >
> > drivers/thermal/Kconfig                   |   10
> > drivers/thermal/Makefile                  |    1
> > drivers/thermal/intel_quark_dts_thermal.c |  434
> >+++++++++++++++++++++++++++++
> > 3 files changed, 445 insertions(+)
> > create mode 100644 drivers/thermal/intel_quark_dts_thermal.c
> >
> >--
> >1.7.9.5
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> >in the body of a message to majordomo@vger.kernel.org More majordomo
> >info at http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/

I am fine with it. Thanks.
Reviewed-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>

