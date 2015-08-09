From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/8] serial: imx: rework pm support and add runtime pm
Date: Sun,  9 Aug 2015 11:19:01 -0700
Message-ID: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36210 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143AbbHISTP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Aug 2015 14:19:15 -0400
Received: by pacrr5 with SMTP id rr5so87087349pac.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2015 11:19:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hello,

This is a patch series to introduce runtime pm in the imx serial driver.
The work is pretty straight forward. The idea is to get runtime pm
to handle ipg and per clocks, idling the device when possible,
configuring wakeups, and saving and restoring context when needed.

A minor refactoring was needed to get things done. Mainly because
the suspend and resume path shares several needed steps with
the runtime pm path. Therefore, several common helper functions
were created to avoid code duplication between these two pm features.

On top of this, I am also adding a simple pm qos requirement. The idea
is to skip deeper c-states when we know the uart port is going to have
latency requirements. The latency is computed based on baud rate and
buffer size.

Most of the code is a design copy of existing serial drivers.

This code has been tested with IMX6SL, mainly with UART1 used as console.

Comments and suggestions of improvements are welcome.

BR,

Eduardo Valentin (8):
  serial: imx: remove unbalanced clk_prepare
  serial: imx: introduce serial_imx_enable_wakeup()
  serial: imx: allow waking up on RTSD
  serial: imx: use dev_pm_ops
  serial: imx: save and restore context in the suspend path
  serial: imx: add a flag to indicate we are in the suspend path
  serial: imx: add runtime pm support
  serial: imx: add pm_qos request

 drivers/tty/serial/imx.c | 342 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 276 insertions(+), 66 deletions(-)

-- 
2.5.0

