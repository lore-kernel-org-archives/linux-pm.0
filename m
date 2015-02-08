From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] drivers/base: Remove unnecessary OOM message
Date: Mon, 09 Feb 2015 00:28:35 +0100
Message-ID: <2675935.6VkJO9HMpc@vostro.rjw.lan>
References: <20150206153912.GA8486@sloth> <20150206211708.GA25967@amd> <20150207102436.GB5206@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150207102436.GB5206@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Quentin Lambert <lambert.quentin@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, February 07, 2015 01:24:36 PM Dan Carpenter wrote:
> Facts:
> 1) None of these four error messages will ever be printed.
>    http://lwn.net/Articles/627419/
> 2) These messages are a waste of RAM.

So this is what the changelog should be saying, not that it "fixes
checkpatch warnings".

checkpatch warnings in *existing* code are meaningless, unless they
uncover a *real* problem in it which quite arguably this one is.  But
in those cases patch changelogs should talk about the *real* problems
and they don't even need to mention checkpatch then as far as I'm
concerned.

Send this one with a better changelog and I'll apply it.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
