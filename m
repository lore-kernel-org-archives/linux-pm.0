From: Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 2/5] Documentation: devicetree: Add property for controlling power saving mode for the us5182 als sensor
Date: Tue, 24 Nov 2015 12:59:49 +0200
Message-ID: <1448362792-5181-3-git-send-email-adriana.reus@intel.com>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net, lars@metafoo.de, Adriana Reus <adriana.reus@intel.com>
List-Id: linux-pm@vger.kernel.org

Add a property to allow changing the default power-saving mode.
By default, at read raw the chip will activate and provide
one measurent, then it will shut itself down. However, the
chip can also work in "continuous" mode which may be more reliable
but is also more power consuming.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Documentation/devicetree/bindings/iio/light/us5182d.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
index 6f0a530..a619799 100644
--- a/Documentation/devicetree/bindings/iio/light/us5182d.txt
+++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
@@ -7,13 +7,24 @@ Required properties:
 Optional properties:
 - upisemi,glass-coef: glass attenuation factor - compensation factor of
                       resolution 1000 for material transmittance.
+
 - upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
                     counts) corresponding to every scale.
+
 - upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
                            fractional bits - Q4.4) applied when light > threshold
+
 - upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
                            fractional bits - Q4.4) applied when light < threshold
 
+- upisemi,continuous: This chip has two power modes: one-shot (chip takes one
+                      measurement and then shuts itself down) and continuous (
+                      chip takes continuous measurements). The one-shot mode is
+                      more power-friendly but the continuous mode may be more
+                      reliable. If this property is specified the continuous
+                      mode will be used instead of the default one-shot one for
+                      raw reads.
+
 If the optional properties are not specified these factors will default to the
 values in the below example.
 The glass-coef defaults to no compensation for the covering material.
-- 
1.9.1
