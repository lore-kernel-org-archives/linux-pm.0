From: "Du, ChangbinX" <changbinx.du@intel.com>
Subject: question: will irq abort suspend process during pm is calling
 suspend() funtion of device driver?
Date: Mon, 1 Apr 2013 12:54:06 +0000
Message-ID: <0C18FE92A7765D4EB9EE5D38D86A563AAF47F2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59477 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197Ab3DAMyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 08:54:10 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Du, ChangbinX" <changbinx.du@intel.com>

Hello, everyone:
I am not familiar with PM module. I know if a device cannot enter suspend state, suspend will be aborted. 
But as the title descripted, Can anyone tell me if any interrupt event can make suspend process aborted?
I have analysis a piece of log and it seems the irq doesn't abort the process.

Thanks!
Du, Changbin

