From: =?ISO-8859-1?Q?=22Rodolfo_Garc=EDa_Pe=F1as_=28kix=29=22?=
	<kix@kix.es>
Subject: suspend-utils: support for UUID
Date: Mon, 04 Mar 2013 23:37:01 +0100
Message-ID: <5135220D.8080407@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:60961 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895Ab3CDWq3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 17:46:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Hi,

what do you think about to implement UUID support for suspend-utils?

Now, suspend-utils try to open the file specified in the configuration file:

http://git.kernel.org/cgit/linux/kernel/git/rafael/suspend-utils.git/tree/suspend.c#n2417

If the config file con
-- 
||// //\\// Rodolfo "kix" Garcia
||\\// //\\ http://www.kix.es/
