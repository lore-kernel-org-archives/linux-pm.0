From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 3/5] PM / Hibernate: separate block_io
Date: Thu, 29 Apr 2010 08:22:34 +0200
Message-ID: <4BD925AA.5060902@gmail.com>
References: <1272356118-10012-1-git-send-email-jslaby@suse.cz>
	<1272356118-10012-3-git-send-email-jslaby@suse.cz>
	<20100428055244.GA3501@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100428055244.GA3501@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/28/2010 07:52 AM, Pavel Machek wrote:
>> + * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>
> 
> That address no longer works, but keeps popping up....

Oops, it's a cut&paste from swap.c:
$ grep -r pavel.*suse kernel/power/
kernel/power/snapshot.c: * Copyright (C) 1998-2005 Pavel Machek
<pavel@suse.cz>
kernel/power/swap.c: * Copyright (C) 1998,2001-2005 Pavel Machek
<pavel@suse.cz>
kernel/power/hibernate.c: * Copyright (c) 2004 Pavel Machek <pavel@suse.cz>

-- 
js
