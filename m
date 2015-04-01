From: "W.Pelser" <w.pelser@web.de>
Subject: resume bug
Date: Wed, 01 Apr 2015 17:40:31 +0200
Message-ID: <551C116F.2000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:60422 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbbDAPke (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Apr 2015 11:40:34 -0400
Received: from [192.168.2.21] ([84.179.221.45]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LbZlL-1ZK8cN08ZH-00lCXL for <linux-pm@vger.kernel.org>;
 Wed, 01 Apr 2015 17:40:32 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Bug ID: 94861
            Summary: After resume from hibernate/sleep USB-DVBT-adapter
                      does not work

Kernel 3.19.x and 4.0rcx

After boot:
   strace -f -o /tmp/strace.out lsdvb .... :
     .
     .
     2114  open("/dev/dvb/adapter0/frontend0", O_RDWR|O_NONBLOCK) = 6
     .
     .


After resume:
   strace -f -o /tmp/strace.out lsdvb .... :
      .
      .
     3848  open("/dev/dvb/adapter0/frontend0", O_RDWR|O_NONBLOCK) = -1 
ENODEV (No  such device)
      .
      .


