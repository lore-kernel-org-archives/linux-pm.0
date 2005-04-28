From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 12:48:26 +0800
Message-ID: <1114663706.22110.35.camel@sli10-desk.sh.intel.com>
References: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31927440217486436=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============31927440217486436==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
On Wed, 2005-04-27 at 17:53, Nigel Cunningham wrote:
> > Sorry for raising the problem again after a long time. I got some
> > reports about ' xxx not stopped' at suspend time. The general cause
> is
> > one task is waiting for another task which has been into
> refrigerator
> > first. Report an error and stop suspend can't solve the problem.
> After
> > the task's dependent task is released from refrigerator, the task
> itself
> > will soon go into refrigerator and will never be waked up. 
> > Nigel's refrigerator patch half solves the problem. It distinct
> kernel
> > tasks and user tasks, so can solve the dependence between kernel
> tasks
> > and user tasks, but can't solve the user tasks dependence. Right,
> Nigel?
> 
> That's right, but the example you give below is userspace (syslogd) vs
> kernel space (kjournald), so I wonder if something could be wrong with
> your implementation.
Right, my example can be solved with your patch. But I'd like a more
generic solution to solve all the dependences, like user space tasks
dependencies.

Thanks,
Shaohua


--===============31927440217486436==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31927440217486436==--
