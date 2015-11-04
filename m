From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] thermal: underflow in trip_point_temp_store()
Date: Wed, 4 Nov 2015 14:32:32 +0300
Message-ID: <20151104113231.GI7289@mwanda>
References: <20151103221434.GB19280@mwanda>
 <20151104055659.GB8850@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45066 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbKDLck (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 06:32:40 -0500
Content-Disposition: inline
In-Reply-To: <20151104055659.GB8850@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

Oh...  Hm.  I actually sent a totally different patch to fix this
warning and you just merged it.  I had forgotten about that.  As far as
I am concerned this issue is solved.  :)  Sorry for sending duplicates.

regards,
dan carpenter

