From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Power driver patches to avoid lockdep complaints
Date: Wed, 15 Jun 2016 14:13:44 -0700
Message-ID: <20160615211344.GA31850@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38526 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753055AbcFOVNs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:13:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5FLDhcu090962
	for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 17:13:47 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23je2n0s0q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 17:13:47 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 15:13:46 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 89FD61FF001E
	for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 15:13:28 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5FLDiDP40632472
	for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 21:13:44 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5FLDh1h031123
	for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 17:13:44 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, tony@atomide.com, linux@roeck-us.net
Cc: rostedt@goodmis.org, linux-pm@vger.kernel.org

Hello!

Ingo was not comfortable taking these through -tip, which is understandable,
given that they don't depend on each other or on anything else not already
in mainline, and that they don't have anything to do with -tip.

So what would you guys like to do with these?

They may be pulled from 13e698e68f75 (power: Use _rcuidle for
suspend/resume tracepoints) in my -rcu tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

