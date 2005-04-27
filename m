From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Re: freeze_processes questions
Date: Wed, 27 Apr 2005 19:53:54 +1000
Message-ID: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
References: <200504081323.51164.rjw@sisk.pl>
	<1114594241.12809.37.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70168650808194744=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114594241.12809.37.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============70168650808194744==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Wed, 2005-04-27 at 19:30, Li Shaohua wrote:
> Hi,
> Sorry for raising the problem again after a long time. I got some
> reports about ' xxx not stopped' at suspend time. The general cause is
> one task is waiting for another task which has been into refrigerator
> first. Report an error and stop suspend can't solve the problem. After
> the task's dependent task is released from refrigerator, the task itself
> will soon go into refrigerator and will never be waked up. 
> Nigel's refrigerator patch half solves the problem. It distinct kernel
> tasks and user tasks, so can solve the dependence between kernel tasks
> and user tasks, but can't solve the user tasks dependence. Right, Nigel?

That's right, but the example you give below is userspace (syslogd) vs
kernel space (kjournald), so I wonder if something could be wrong with
your implementation.

> Below is a proposal method to solve the issue. Assume task A depends on
> task B. Task B is frozen first. When we find task A can't be frozen
> after a long time, we thaw all tasks and let task A continue (task A has
> gotten a freeze signal so it will soon go into refrigerator) and then we
> freeze other tasks again. In theory, this can solve all task dependence
> (sure can't solve the circled dependence) if the retry times are enough
> big, but cost maybe too high. Looks it help my case (syslogd can't be
> stopped because it's waitting for kjournald). Any idea?

Perhaps what is needful is the other component of my refrigerator
implementation. I also mark threads like kjournald with the new flag
PF_SYNCTHREAD, and temporarily give it to threads that enter sys_sync
and siblings. That ensures that processes submitting I/O are frozen,
then the I/O is flushed, then kernel threads such as kjournald are
frozen.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============70168650808194744==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70168650808194744==--
