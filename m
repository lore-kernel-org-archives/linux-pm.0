From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: pwoertop frequencies not ordered descending
Date: Mon, 26 Jan 2015 14:55:26 +0100
Message-ID: <54C6474E.6080805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56836 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbbAZNz3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 26 Jan 2015 08:55:29 -0500
Received: from [192.168.178.24] ([78.54.139.165]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MZkNy-1XycxF265G-00LWQ3 for
 <linux-pm@vger.kernel.org>; Mon, 26 Jan 2015 14:55:27 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm >> Linux PM list" <linux-pm@vger.kernel.org>

With the ACPI driver (and CPU governor "ondemand") the output of powertop looked always fine.
However with the P-State driver I do now have this output at 2 hardened 64 bit Gentoo Linux systems:


PowerTOP 2.6      Overview   Idle stats   Frequency stats   Device stats   Tunables                     


            Package |             Core    |            CPU 0       CPU 1
                    |                     | Actual    2.6 GHz     2.7 GHz
Idle         0.3%   | Idle        63.2%   | Idle        73.9%       75.0%
2.50 GHz     0.1%   | 2.50 GHz     0.1%   | 2.50 GHz     0.1%        0.0%
2.60 GHz     9.0%   | 2.60 GHz     8.9%   | 2.60 GHz     8.9%        0.3%
2.90 GHz    74.5%   | 2.90 GHz    13.4%   | 2.90 GHz     5.4%       11.3%
2.71 GHz    13.5%   | 2.71 GHz    12.9%   | 2.71 GHz    11.2%       12.3%
 800 MHz     0.2%   |  800 MHz     0.1%   | 2.81 GHz     0.5%        0.1%
2.81 GHz     2.3%   | 2.81 GHz     1.1%   | 1200 MHz     0.0%        0.9%
 900 MHz     0.0%   | 1000 MHz     0.1%   | 1100 MHz     0.0%        0.1%
1000 MHz     0.1%   | 1200 MHz     0.0%   | 1000 MHz     0.0%        0.0%
1200 MHz     0.0%   |  900 MHz     0.0%   |  800 MHz     0.0%        0.0%
1100 MHz     0.0%   | 1100 MHz     0.0%   |  900 MHz     0.0%        0.0%
1300 MHz     0.0%   | 1500 MHz     0.0%   |                          0.0%
1500 MHz     0.0%   | 1400 MHz     0.0%   |                          0.0%
1400 MHz     0.0%   |                     |

                    |             Core    |            CPU 2       CPU 3
                    |                     | Actual    2.8 GHz     2.8 GHz
                    | Idle         6.6%   | Idle        23.1%       24.9%
                    | 2.50 GHz     0.1%   | 2.50 GHz     0.0%        0.1%
                    | 2.60 GHz     8.9%   | 2.60 GHz     0.1%        8.9%
                    | 2.90 GHz    69.1%   | 2.90 GHz    62.9%       62.5%

Is this (partly ?) related to the kernel or just an issue of powertop ?

-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E

