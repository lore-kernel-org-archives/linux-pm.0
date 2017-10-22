From: stefan <stefan@entroserv.de>
Subject: [Bug] cpupower frequency-set -u800MHz does not survive standby
Date: Sun, 22 Oct 2017 14:07:57 +0200
Message-ID: <cdfc4c60-ce89-590d-581e-3c590534c277@entroserv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from losalamos.entroserv.de ([178.63.154.91]:51909 "EHLO
        mail.entroserv.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbdJVMOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 08:14:19 -0400
Received: from [192.168.254.34] (unknown [185.104.184.187])
        by mail.entroserv.de (Postfix) with ESMTPSA id 6E3BA24096A
        for <linux-pm@vger.kernel.org>; Sun, 22 Oct 2017 14:08:08 +0200 (CEST)
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Using Ubuntu 16.04 (amd64) on Sandybridge i7-2820QM with cpupower 4.4.87 the set upper frequency does not survive standby.

After wakeup from standby the upper frequency is like 2300 MHz. But turboboost is switched off, like it should be, if upper frequency is below base clock. 

Sometimes running the same command: frequency-set -u800MHz
again, does not change anything


--

Stefan Helmert
Brückenstr. 2
09111 Chemnitz


USt-IdNr.:  DE294678351

KTO-Inh.:   Stefan Helmert
IBAN:       DE42700222000020030860
BIC:        FDDODEMMXXX

Paypal:     paypal@entroserv.de

Tel.:       +49 (0)177 8506921
E-Mail:     info@entroserv.de
