From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] drivers/base: Remove unnecessary OOM message
Date: Sat, 7 Feb 2015 13:24:36 +0300
Message-ID: <20150207102436.GB5206@mwanda>
References: <20150206153912.GA8486@sloth>
 <20150206205852.GA14126@amd>
 <1423256670.4752.16.camel@perches.com>
 <20150206211708.GA25967@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150206211708.GA25967@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Joe Perches <joe@perches.com>, Quentin Lambert <lambert.quentin@gmail.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Facts:
1) None of these four error messages will ever be printed.
   http://lwn.net/Articles/627419/
2) These messages are a waste of RAM.

Debatable:
1) These messages are bad style and distracting.  Simple code is better.
2) The normal OOM message is enough to find which allocation failed.

Not everbody, but a lot of people write these kinds of error messages
with their brain on auto-pilot because they think they *should* do it.
It's quite common to do things like printk("dev is NULL.  %s",
dev->name);.  I'm happy for this checkpatch warning because it hopefully
bumps people out of mindless mode and makes them think about error
messages.

regards,
dan carpenter
