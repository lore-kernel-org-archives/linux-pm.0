From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 15:05:07 +1000
Message-ID: <1114664707.3580.12.camel@desktop.cunningham.myip.net.au>
References: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
	<1114663706.22110.35.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5157611437577132=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114663706.22110.35.camel@sli10-desk.sh.intel.com>
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

--===============5157611437577132==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-04-28 at 14:48, Li Shaohua wrote:
> Hi,
> On Wed, 2005-04-27 at 17:53, Nigel Cunningham wrote:
> > > Sorry for raising the problem again after a long time. I got some
> > > reports about ' xxx not stopped' at suspend time. The general cause
> > is
> > > one task is waiting for another task which has been into
> > refrigerator
> > > first. Report an error and stop suspend can't solve the problem.
> > After
> > > the task's dependent task is released from refrigerator, the task
> > itself
> > > will soon go into refrigerator and will never be waked up. 
> > > Nigel's refrigerator patch half solves the problem. It distinct
> > kernel
> > > tasks and user tasks, so can solve the dependence between kernel
> > tasks
> > > and user tasks, but can't solve the user tasks dependence. Right,
> > Nigel?
> > 
> > That's right, but the example you give below is userspace (syslogd) vs
> > kernel space (kjournald), so I wonder if something could be wrong with
> > your implementation.
> Right, my example can be solved with your patch. But I'd like a more
> generic solution to solve all the dependences, like user space tasks
> dependencies.

Do you have a particular example in mind? I haven't seen or heard of any
freezing failures in Suspend2 for ages, so I'm struggling to see what is
lacking.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============5157611437577132==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============5157611437577132==--
