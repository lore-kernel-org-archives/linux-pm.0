From: Thomas Fjellstrom <thomas@fjellstrom.ca>
Subject: Question on intel_pstate driver
Date: Sat, 31 May 2014 15:44:02 -0600
Message-ID: <1425705.adneRaQSNa@balsa>
Reply-To: thomas@fjellstrom.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I've noticed a strange issue on my lenovo W530 laptop for a few months now. 
Even with just a few percent cpu use, it spins the cpu up to it's full boost 
on one or more cores, and tends to keep it there for an extended period. Ever 
since my laptop has been significantly warmer, and louder than it was a while 
back.

Cpu is a: i7-3720QM
Current kernel is: 3.14.4 (debian)

I've also tried vanilla kernels: 3.13, 3.14-rc8

Disabling the intel_pstep driver seems to disable boost states completely, 
which is odd, as I could swear it worked before without it.

Is there something I can do to keep boost states while reducing the heat and 
noise? It seems to be way over compensating for minimal amounts of cpu use.

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
