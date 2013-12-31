From: loody <miloody@gmail.com>
Subject: how to know how long it takes on suspend/resume for platform usb driver
Date: Tue, 31 Dec 2013 17:11:48 +0800
Message-ID: <CANudz+v2LP5nUYa8gosm_sXdin7C4R3kP7xBT0C61yd2Zsd6mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62731 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3LaJLt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2013 04:11:49 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so10671956wgg.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2013 01:11:48 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

hi all:
I am implementing platform layer suspend/resume usb driver.
Is there kernel configuration or module parameter I can used to
calculate suspend/resume time spend?

-- 
Regards,
