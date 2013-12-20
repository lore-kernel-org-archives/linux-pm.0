From: Rodolfo =?utf-8?B?R2FyY8OtYSBQZcOxYXM=?= <kix@kix.es>
Subject: Question about autosleep_show function
Date: Fri, 20 Dec 2013 20:33:20 +0100
Message-ID: <20131220193320.GA31769@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:39629 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750866Ab3LTTm7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Dec 2013 14:42:59 -0500
Received: from kix.es (4.Red-217-127-226.staticIP.rima-tde.net [217.127.226.4])
	by what.com.es (Postfix) with ESMTPSA id 5BE096A055B
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2013 20:33:16 +0100 (CET)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I am new with the kernel source.

The function autosleep_show is defined at kernel/power/main.c, but it is not used. Is possible remove it or I am missing something? See [1]

Thanks
kix

[1] http://lxr.free-electrons.com/ident?i=autosleep_show
-- 
||// //\\// Rodolfo "kix" Garcia
||\\// //\\ http://www.kix.es/
