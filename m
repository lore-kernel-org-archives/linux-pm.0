From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 3/4] Container Freezer: Implement freezer
	cgroup	subsystem
Date: Fri, 11 Apr 2008 13:49:47 +0200
Message-ID: <20080411114947.GD1740__19030.9000121944$1207914753$gmane$org@elf.ucw.cz>
References: <20080403210316.397506379@us.ibm.com>
	<20080403210317.160210906@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080403210317.160210906@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: matthltc@us.ibm.com
Cc: Linux Containers <containers@lists.linux-foundation.org>, Cedric Le Goater <clg@fr.ibm.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch implements a new freezer subsystem for Paul Menage's 
> control groups framework. It provides a way to stop and resume 
> execution of all tasks in a cgroup by writing in the cgroup 
> filesystem.
> 
> This is the basic mechanism which should do the right thing for 
> user space tasks in a simple scenario. This will require more work 
> to get the freezing right (cf. try_to_freeze_tasks()) for ptraced
> tasks.

> --- /dev/null
> +++ linux-2.6.25-rc8-mm1/include/linux/cgroup_freezer.h
> @@ -0,0 +1,57 @@
> +#ifndef _LINUX_CGROUP_FREEZER_H
> +#define _LINUX_CGROUP_FREEZER_H
> +/*
> + * cgroup_freezer.h -  control group freezer subsystem interface
> + *
> + * Copyright IBM Corp. 2007
> + *
> + * Author : Cedric Le Goater <clg@fr.ibm.com>
> + */

If you have copyright, add GPL.

> --- /dev/null
> +++ linux-2.6.25-rc8-mm1/kernel/cgroup_freezer.c
> @@ -0,0 +1,280 @@
> +/*
> + * cgroup_freezer.c -  control group freezer subsystem
> + *
> + * Copyright IBM Corp. 2007
> + *
> + * Author : Cedric Le Goater <clg@fr.ibm.com>
> + */

Same here.

>+static struct cgroup_subsys_state *freezer_create(
>+       struct cgroup_subsys *ss, struct cgroup *cgroup)
>+{

Function headers are somehow non-traditional.

+       struct freezer *freezer;
+
+       if (!capable(CAP_SYS_ADMIN))
+               return ERR_PTR(-EPERM);
+
+       freezer = kzalloc(sizeof(struct freezer), GFP_KERNEL);
+       if (!freezer)
+               return ERR_PTR(-ENOMEM);
+
+       spin_lock_init(&freezer->lock);
+       freezer->state = STATE_RUNNING;
+       return  &freezer->css;
+}

One space too many after "return" :-).

Hmm, returning pointer inside struct freezer is rather ugly, right?
Could you just pass struct freezer around?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
