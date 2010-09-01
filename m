From: Tejun Heo <tj@kernel.org>
Subject: Re: v2.6.36-rc2-373-g29cfcdd complaints after the 2nd
 suspend2ram
Date: Wed, 01 Sep 2010 11:00:12 +0200
Message-ID: <4C7E161C.6000407@kernel.org>
References: <201008300946.38558.toralf.foerster@gmx.de>
	<201008302028.13853.toralf.foerster@gmx.de>
	<4C7CB570.9010607@kernel.org> <201008312214.48665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008312214.48665.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-2?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On 08/31/2010 10:14 PM, Rafael J. Wysocki wrote:
>> Can you please pull from the following branch and see whether the
>> problem is resolved?
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-linus
> 
> Which commit in there is the suspected fix?

Commit 8a2e8e5dec7e29c56a46ba176c664ab6a3d04118 (workqueue: fix
cwq->nr_active underflow).  The symptom described in the patch
description is different but nr_active is used for workqueue freezing
and can definitely lead to malfunction during freeze.  I've sent pull
request to Linus yesterday.

Thanks.

-- 
tejun
