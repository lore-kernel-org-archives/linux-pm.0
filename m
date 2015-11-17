From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: Fwd: Freescale IMX6 active cooling
Date: Tue, 17 Nov 2015 08:12:56 +0200
Message-ID: <CABH3fy_KHmOWRDdLYO8_4vpXpD_dJTamDa4GVPY8nSbddgw+Jw@mail.gmail.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36898 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbKQGM5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 01:12:57 -0500
Received: by wmww144 with SMTP id w144so10462795wmw.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2015 22:12:56 -0800 (PST)
In-Reply-To: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@arm.com>, linux-pm@vger.kernel.org

+CC Maintainers

---------- Forwarded message ----------
From: Catalin Crenguta <catalin.crenguta@gmail.com>
Date: Mon, Nov 16, 2015 at 11:43 AM
Subject: Freescale IMX6 active cooling
To: "linux-arm-kernel@lists.infradead.org"
<linux-arm-kernel@lists.infradead.org>
Cc: fabio.estevam@freescale.com, Fabio Estevam <festevam@gmail.com>


Hello,

I'm trying to use a GPIO Fan to cool down a Riotboard (I.MX6 Solo).
I've read [0], investigated the driver which provides the on-die
temperature ( fsl,imx6q-tempmon [1]) but it seems to provide the
temperature by creating a thermal zone (relevant dts: [2][3][4]).
I don't know how I should proceed:
1) Should I research how can I attach a cooling device to this already
existing thermal zone? (I believe it involves modifying the existing
driver by adding new device tree handles)
2) Should I create another thermal zone, use the existing driver to
get the temperature and bind to a cooling device?
3) Should I modify the existing driver to not create a thermal zone
and move the creation in the device tree using the of-thermal driver ?

Best regards,
Catalin Crenguta

[0] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/thermal/thermal.txt
[1] http://lxr.free-electrons.com/source/drivers/thermal/imx_thermal.c
[2] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6dl-riotboard.dts
[3] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6dl.dtsi
[4] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6qdl.dtsi
