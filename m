From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: How binding of cpu cooling dev with tzd works when using
 thermal_zone_of_.... functions
Date: Thu, 30 Mar 2017 16:38:45 +0200
Message-ID: <CAHKzcEPTkrxvKT1_AgAMD6ZdpXnH3_hq6HoZ4gjEaFb20J0VBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33114 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdC3Oj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 10:39:27 -0400
Received: by mail-wr0-f175.google.com with SMTP id w43so63546850wrb.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 07:39:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

Recently, I started to work with thermal framework and I write a
thermal driver. I did it, say normal way,  with
thermal_zone_device_register() + cpufreq_cooling_register(), but now I
want to define complete thermal zone with trips and cooling maps in
DT.

I use  devm_thermal_zone_of_sensor_register() which works nice, but I
can see it does not register a cpu cooling device. I assume
intentionally.  Even if I  cpufreq_cooling_register as in a normal way
before devm_thermal_zone_of_sensor_register() in the probe(). I cannot
see it binds tz with cooling dev as I assume bind cb is missing in
thermal_zone_of_device_ops struct.

How  should I bind cpu cooling dev  with thermal zone if I use
devm_thermal_zone_of_sensor_register() ?


Any help appreciated.

Thanks,

/Waldek
