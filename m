From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 3/5] Container Freezer: Implement
	freezer cgroup	subsystem
Date: Wed, 30 Apr 2008 14:28:25 -0700
Message-ID: <1209590905.29759.38.camel__38749.9835146174$1209591044$gmane$org@localhost.localdomain>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064757.526468716@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080424064757.526468716@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Oren Laadan <orenl@cs.columbia.edu>, Linux Containers <containers@lists.linux-foundation.org>, Cedric Le Goater <clg@fr.ibm.com>, Paul Menage <menage@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Wed, 2008-04-23 at 23:47 -0700, Matt Helsley wrote:

<snip>

> +static ssize_t freezer_write(struct cgroup *cgroup,
> +			     struct cftype *cft,
> +			     struct file *file,
> +			     const char __user *userbuf,
> +			     size_t nbytes, loff_t *unused_ppos)
> +{
> +	char *buffer;
> +	int retval = 0;
> +	enum freezer_state goal_state;
> +
> +	if (nbytes >= PATH_MAX)
> +		return -E2BIG;
> +
> +	/* +1 for nul-terminator */
> +	buffer = kmalloc(nbytes + 1, GFP_KERNEL);
> +	if (buffer == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(buffer, userbuf, nbytes)) {
> +		retval = -EFAULT;
> +		goto free_buffer;
> +	}
> +	buffer[nbytes] = 0;	/* nul-terminate */
> +	strstrip(buffer);
> +	if (strcmp(buffer, "RUNNING") == 0)
> +		goal_state = STATE_RUNNING;
> +	else if (strcmp(buffer, "FROZEN") == 0)
> +		goal_state = STATE_FROZEN;
> +	else {
> +		retval = -EIO;
> +		goto free_buffer;
> +	}
> +
> +	cgroup_lock();
> +
> +	if (cgroup_is_removed(cgroup)) {
> +		retval = -ENODEV;
> +		goto unlock;
> +	}

I think this was copy/paste'd from cgroup_common_file_write() which
modifies the cgroup hierarchy. However this function does not modify the
cgroup hierarchy and we're not getting the cgroup from the task. So I
don't think cgroup_lock()/unlock() are needed here. Paul, do you agree?

> +	retval = freezer_freeze(cgroup, goal_state);
> +	if (retval == 0)
> +		retval = nbytes;
> +unlock:
> +	cgroup_unlock();
> +free_buffer:
> +	kfree(buffer);
> +	return retval;
> +}

Cheers,
	-Matt Helsley
