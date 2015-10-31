From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/3] power, vfs: move away from PF_KTHREAD freezing in
 favor of fs freezing
Date: Sat, 31 Oct 2015 09:55:56 +0100
Message-ID: <1446281756.21651.7.camel@suse.com>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
	 <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbbJaI5h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 31 Oct 2015 04:57:37 -0400
In-Reply-To: <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 2015-10-30 at 14:47 +0100, Jiri Kosina wrote:
> Basically the main argument why kthread freezer is not needed boils
> down to
> this: the only facility that is needed during suspend: "no persistent
> fs
> changes are allowed from now on".

Is that true? Drivers of character devices also may assume
that IO and suspend() wouldn't race (except in fairly clear exceptions)

	Regards
		Oliver


