From: Paul Jackson <pj@sgi.com>
Subject: Re: [RFC][PATCH 5/5] Add a Signal Control Group Subsystem
Date: Thu, 24 Apr 2008 14:30:32 -0500
Message-ID: <20080424143032.7e659522.pj__35872.0278404236$1209078052$gmane$org@sgi.com>
References: <20080424064756.643890130@us.ibm.com>
	<20080424064758.113999091@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080424064758.113999091@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clg@fr.ibm.com, menage@google.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> +static struct cftype kill_file = {
> +	.name = "kill",

The name "kill" seems ambiguous to me.  It suggests that any write
will send some default signal (TERM or KILL?) to all tasks in the
cgroup, rather like the 'killall' command.

I'm guessing that more people, on seeing this file in a cgroup
directory, will guess correctly what it does if it were named
"signal" or "send_signal" or some such.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.940.382.4214
