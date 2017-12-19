From: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 00/11] Armada thermal: improvements and A7K/A8K SoCs support
Date: Tue, 19 Dec 2017 14:57:08 +0100
Message-ID: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series takes over Baruch's series by integrating his patches about
supporting thermal on Armada 7K and 8K SoCs within a larger series with
several improvements on the armada_thermal.c driver.

For now, Armada 380 and CP110 compatibles share the same initialization
routine but this will probably change in the near future when adding
support for overheat interrupts.

DT bindings documentation is updated to match existing code.

Armada AP806 and CP110 DT are also updated with thermal nodes and have
already been accepted (thus absent in this series).

Thank you,
Miquèl


Changes since v4:
  - Added Gregory's Reviewed-by tags
  - Rephrased the paragraph in the documentation explaining what
    compatible supports.
  - Enumerated the compatibles supporting only the new bindings.
  - Required the Armada 375 SoC compatible string to be used with
    new bindings.


Baruch Siach (4):
  dt-bindings: thermal: Describe Armada AP806 and CP110
  thermal: armada: Use msleep for long delays
  thermal: armada: Add support for Armada AP806
  thermal: armada: Add support for Armada CP110

Miquel Raynal (7):
  thermal: armada: Simplify the check of the validity bit
  thermal: armada: Clarify control registers accesses
  thermal: armada: Use real status register name
  thermal: armada: Update Kconfig and module description
  thermal: armada: Change sensors trim default value
  thermal: armada: Wait sensors validity before exiting the init
    callback
  thermal: armada: Give meaningful names to the thermal zones

 .../devicetree/bindings/thermal/armada-thermal.txt |  37 ++-
 drivers/thermal/Kconfig                            |   4 +-
 drivers/thermal/armada_thermal.c                   | 253 +++++++++++++++------
 3 files changed, 215 insertions(+), 79 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
