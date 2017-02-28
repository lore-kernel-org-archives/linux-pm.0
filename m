From: Dushara Jayasinghe <dushara@successful.com.au>
Subject: query regarding the bp24257 driver
Date: Tue, 28 Feb 2017 16:25:47 +1100
Message-ID: <9dd68081-6370-9050-5a2f-f70013d46a02@successful.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34596 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1Fxx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2017 00:53:53 -0500
Received: by mail-pf0-f171.google.com with SMTP id p185so1211092pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2017 21:53:44 -0800 (PST)
Received: from [10.73.0.117] (74.206.70.115.static.exetel.com.au. [115.70.206.74])
        by smtp.gmail.com with ESMTPSA id i15sm1077467pfj.0.2017.02.27.21.25.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 21:25:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi all,

I'm working a on a embedded device with the 4.4 branch of the kernel.

One of the devices on the board is a BQ24250 charger which is supported 
by the BQ24257 driver. One thing I've noticed is that the device has a 
charge enable pin which is not supported by the driver. I'm wondering if 
this is so because:

 1. The original author didn't need to control this line
 2. Charge enable functionality doesn't belong in this driver
 3. Some other reason

Could someone let me know please?

Thanks

Dushara
