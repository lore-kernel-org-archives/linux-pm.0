From: Paul Menage <paul@paulmenage.org>
Subject: Re: [PATCH 3/6] cgroup: introduce cgroup_taskset and use
 it in subsys->can_attach(), cancel_attach() and attach()
Date: Thu, 25 Aug 2011 02:32:35 -0700
Message-ID: <CALdu-PDVzDzJWmyUB4vqR5qYVbMPgtM4BE4BwC3wk5ah0VzQcw__32036.626750096$1314288268$gmane$org@mail.gmail.com>
References: <1314138000-2049-1-git-send-email-tj@kernel.org>
	<1314138000-2049-4-git-send-email-tj@kernel.org>
	<CALdu-PDAgqeRJt5vqTB9wddwz70Yn+Jf-Pb0dDKDBD_q37tHQg@mail.gmail.com>
	<20110825092045.GG3286@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110825092045.GG3286@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, containers@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-pm@lists.linux-foundation.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2011 at 2:20 AM, Tejun Heo <tj@kernel.org> wrote:
>
> I think having separate ->attach() and ->attach_task() is inherently
> broken. =A0Look at the memcg discussion I had in this thread for
> reference and as soon as we need to do something across the tasks
> being migrated, iteration-by-callback becomes very painful.
> e.g. let's say memcg wants to find the mm->owner and wants to print
> warning or fail if that doesn't work out. =A0How would that be
> implemented if it's iterating by callback.

OK, fair point. See my other email for patch comments.

Paul
