From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] turbostat, add set_base_cpu()
Date: Wed, 27 May 2015 17:54:46 -0400
Message-ID: <CAJvTdKmpeT5hM-ByFGnQb9p7frXG3TjMZ4zM8L=mEEU-+c6QXw@mail.gmail.com>
References: <1432557269-10994-1-git-send-email-prarit@redhat.com>
	<1432557269-10994-3-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33628 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbE0Vyr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 17:54:47 -0400
In-Reply-To: <1432557269-10994-3-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Andrey Semin <andrey.semin@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

> +       base_cpu = sched_getcpu();

looks good.
I combined this w/ the previous patch.
I'll send this with some other patches to linux-pm shortly.
If no problems, I'll offer the bundle of fixes to Linus for -rc5,
else we'll get to it in the next merge window.

thanks,
Len Brown, Intel Open Source Technology Center
