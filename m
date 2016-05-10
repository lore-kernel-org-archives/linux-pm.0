From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Subject: [PATCH 0/2] cpufreq: rcar: Enable CPUFreq support
Date: Tue, 10 May 2016 11:55:41 +0700
Message-ID: <573169CD.8050607@rvc.renesas.com>
References: <1462372543-31835-1-git-send-email-geert+renesas@glider.be>
 <5731664D.1030909@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <5731664D.1030909@rvc.renesas.com>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "Khiem Trong. Nguyen" <khiem.nguyen.xt@rvc.renesas.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series enables CPUFreq support in available R-Car Gen3 SoC.

It depends on 2 series below:
    [PATCH 0/4] clk: renesas: cpg-mssr: Add support for R-Car M3-W
    [RFC 0/4] Add Z clock support

All comments are appreciated.

Khiem Nguyen (2):
   cpufreq: rcar: Add support for R8A7795 SoC
   cpufreq: rcar: Add support for R8A7796 SoC

  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
  1 file changed, 2 insertions(+)

-- 
1.9.1

