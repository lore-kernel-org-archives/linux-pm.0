From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH 00/13] Remove mach-kirkwood and mach-dove
Date: Mon, 30 Jun 2014 09:16:43 +0200
Message-ID: <20140630091643.2df3b0fb@armhf>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
	<20140629213510.GR32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20140629213510.GR32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, alsa-devel@alsa-project.org, Bryan Wu <cooloney@gmail.com>, Jason Cooper <jason@lakedaemon.net>, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tejun Heo <tj@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 29 Jun 2014 22:35:11 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> There is actually a cubox regression which has yet to be tracked down=
=2E
> Running with my kernel (which is not-DT based) runs perfectly.  With
> DT, HDMI output can be unstable.

Russell,

What is this HDMI problem with DT?

I am running a DT based kernel on my Cubox for more than 1 year and the
only problem I have is a random black screen at startup time, and this
black screen problem also exists with the old non-DT kernels from
SolidRun.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
